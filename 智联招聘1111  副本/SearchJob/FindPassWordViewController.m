//
//  FindPassWordViewController.m
//  LogIn
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"

@implementation FindPassWordViewController
@synthesize emailTextField;
@synthesize isSentPhoneButton;
@synthesize isPhone = _isPhone;

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
    self.isPhone = 0;//默认不发送到手机
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    
    [self setIsSentPhoneButton:nil];
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
    [emailTextField release];
    
    [isSentPhoneButton release];
    [super dealloc];
}
- (IBAction)sentAction:(id)sender {
    NSString *urlstr1 = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/forgetpwd.aspx?email=%@&uticket=xxxxxxxxxxxxxxxxxxxxx&needSendMobile=%@",emailTextField.text,_isPhone];
    NSString *urlstr2 = [DNWrapper getMD5String:urlstr1];
    NSLog(@"%@",urlstr2);
    
    NSURL *url = [NSURL URLWithString:urlstr2];
    NSLog(@"url = %@",urlstr2);
    
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //第三步， 连接服务器
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    //讲网页内容获取放到document里面
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root = [document rootElement];//获得根节点
    
    NSArray *children = [root children];
    GDataXMLElement *resultValue = [children objectAtIndex:0];
    NSLog(@"result = %@",[resultValue stringValue]);

    if ([[resultValue stringValue]  isEqualToString:@"1"]) {
        NSLog(@"发送成功"); 
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [self.view addSubview:successAlert];
        [successAlert show];
        successAlert.delegate = self;
            }else
    {
        NSLog(@"发送失败");
    }
    
}
- (void)alertViewCancel:(UIAlertView *)alertView
{
    NSLog(@"alert关闭");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"alert关闭111");
    
}

- (IBAction)sentPhone:(id)sender {
    if (isSentPhoneButton.imageView.image == [UIImage imageNamed:@"unselect_icon@2x.png"]) {
        NSLog(@"选择发送");
        [isSentPhoneButton setImage:[UIImage imageNamed:@"select_icon@2x.png"] forState:UIControlStateNormal];
        self.isPhone = [NSString stringWithFormat:@"%d",1];
    }
    else
    {
        NSLog(@"选择不发送");
        [isSentPhoneButton setImage:[UIImage imageNamed:@"unselect_icon@2x.png"] forState:UIControlStateNormal];
        self.isPhone = [NSString stringWithFormat:@"%d",0];
    }
}
@end
