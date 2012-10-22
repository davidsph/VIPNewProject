//
//  VIPJObRecommend.m
//  VIPZL
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPJObRecommend.h"
#import "CustomCell.h"
#import "GDataXMLNode.h"
#import "DNWrapper.h"

@implementation VIPJObRecommend
@synthesize sclv,tbView;

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
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
    
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"实时推荐";
    self.sclv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.sclv.contentSize = CGSizeMake(320,500);
    self.sclv.showsVerticalScrollIndicator = NO;
    self.sclv.backgroundColor = [UIColor clearColor];
    self.sclv.scrollEnabled = YES;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 200, 20)];
    label1.text = @"实时推荐";
    label1.backgroundColor = [UIColor clearColor];
    [self.sclv addSubview:label1];
    [label1 release];
    
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(7, 34, 306, 630) style:UITableViewStyleGrouped];
    self.tbView.backgroundColor = [UIColor clearColor];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.scrollEnabled = NO;
    [self.sclv addSubview:self.tbView];
    
    [self.view addSubview:self.sclv];
    
    NSString *string = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/recommendjob.aspx?uticket=qvlylUH/GMyvMq5YePve43PYeQwnekLUTpkLLXbvLfy+k8xzMngO9w=="];
    //DNWrapper *w = [[DNWrapper alloc]init];
    NSString *str1 = [DNWrapper getMD5String:string];
    NSURL *url = [NSURL URLWithString:str1];
    NSLog(@"str1 = %@",str1);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"str = %@",str);
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    NSArray *arr=  [root nodesForXPath:@"//job_city" error:nil] ;
    for(GDataXMLElement *job_city in arr)
    {
        NSLog(@"job_city = %@",[job_city stringValue]);
        [array addObject:[job_city stringValue]];
        
    }


    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
