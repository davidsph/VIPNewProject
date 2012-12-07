//
//  DetailEmailViewController.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailEmailViewController.h"
#import "Indicator.h"
#import "GDataXMLNode.h"
#import "DNWrapper.h"
#import "IsLogin.h"

@implementation DetailEmailViewController

@synthesize titleLabel;
@synthesize fromLabel;
@synthesize dateLabel;
@synthesize emailContent;
@synthesize emailNum;
@synthesize connection;
@synthesize uticket;
@synthesize emailData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"来信详情";
    

    UIButton  *  leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =  CGRectMake(0, 0, 50, 44);
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.titleLabel.adjustsFontSizeToFitWidth =YES;
    [leftBtn setTitle:@"来信" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backBarButton;
    [backBarButton release];
    
    UIButton  *  right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame =  CGRectMake(0, 0, 50, 44);
    right.titleLabel.font =[UIFont systemFontOfSize:14.0];
    
    right.backgroundColor = [UIColor clearColor];
    right.titleLabel.adjustsFontSizeToFitWidth =YES;
    [right setTitle:@"回复" forState:UIControlStateNormal];
    [right setBackgroundImage:[UIImage imageNamed:@"方形按钮.png"] forState:UIControlStateNormal];
    
    [right addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem= button;
    [button release];
    
    IsLogin *islogin=[IsLogin defaultIsLogin];
    self.uticket=islogin.uticket;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    NSString *str=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_showmail.aspx?email_number=%@&uticket=%@",self.emailNum,self.uticket];
       self.emailData=[[NSMutableData alloc]init ];
    [Indicator addIndicator:self.view];
    [self setURL:str];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}
//调用ios邮件系统发送邮件
-(void)send
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Enter Your Subject!"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"ibokan@qq.com"]; 
    
    
    [picker setToRecipients:toRecipients];
    
    // Attach an image to the email
    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@""];
    
    // Fill out the email body text
    
    [self presentModalViewController:picker animated:YES];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{    
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)setURL:(NSString *)string{
    NSString *urlstr=[DNWrapper getMD5String:string];
   
    NSURL *url=[[NSURL alloc]initWithString:urlstr];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [url release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.emailData appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [Indicator removeIndicator:self.view];
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithData:self.emailData options:0 error:nil];
    GDataXMLElement *root=[document rootElement];
    self.titleLabel.text=[[[root nodesForXPath:@"mail/subject" error:nil] objectAtIndex:0] stringValue];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    self.fromLabel.text=[[[root nodesForXPath:@"mail/company_name" error:nil] objectAtIndex:0] stringValue];
    self.dateLabel.text=[[[root nodesForXPath:@"mail/date_posted" error:nil] objectAtIndex:0] stringValue];
    self.dateLabel.font=[UIFont boldSystemFontOfSize:13];
    self.emailContent.text=[[[root nodesForXPath:@"mail/mail_body" error:nil]objectAtIndex:0] stringValue];
    
}
- (void)viewDidUnload
{
    [self setDateLabel:nil];
    [self setFromLabel:nil];
    [self setTitleLabel:nil];
    [self setEmailContent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [dateLabel release];
    [fromLabel release];
    [titleLabel release];
    [emailContent release];
    [super dealloc];
}
@end
