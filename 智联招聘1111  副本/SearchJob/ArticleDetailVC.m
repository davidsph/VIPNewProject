//
//  ArticleDetailVC.m
//  JobGuide
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleDetailVC.h"
#import "Articles.h"



@interface ArticleDetailVC()
//发送网络请求
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end

@implementation ArticleDetailVC
@synthesize ID;
@synthesize titleLabel;
@synthesize startDateLabel;
@synthesize contentTextView;
- (void)dealloc 
{
    self.titleLabel=nil;
    self.startDateLabel=nil;
    self.contentTextView=nil;
    [super dealloc];
}

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
-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground.png"]];
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:titleLabel];
    
    startDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,30, 320, 20)];
    startDateLabel.textAlignment=UITextAlignmentCenter;
    startDateLabel.font=[UIFont fontWithName:@"Helvetica-Light" size:10];
    startDateLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:startDateLabel];
    
    UIView *view=[[[UIView alloc]initWithFrame:CGRectMake(0,58, 320, 2)]autorelease];
    view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"contentSprarator.png"]];
    [self.view addSubview:view];
    
    contentTextView=[[UITextView alloc]initWithFrame:CGRectMake(5,60,310, 350)];
    contentTextView.editable=NO;
    contentTextView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:contentTextView];
    
      self.navigationItem.backBarButtonItem=nil;
    
    //自定义leftbutton
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 50, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
-(void)back
{
  [self.navigationController popViewControllerAnimated:YES];  
}
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    //发送网络请求
    [self sendRequest];

    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;//在状态栏上显示
    
    
    //加载时页面
    activityV = [[ActivityView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:activityV];
    [activityV show];  
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Private methods
//发送网络请求
- (void)sendRequest
{
   //设置访问的URL
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articledetail.service?id=%d",self.ID];
    NSURL *url = [[NSURL alloc]initWithString:string];
    [string release];
    //创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
   //连接服务器
    NSURLConnection  *_connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [_connection release];
}
//设置view的内容
- (void)setViewContent
{
  
    Articles *article = [[Articles alloc]initByXMLData:_data];
    [_data release];
    //设置view的内容
   
    titleLabel.text = article.title;
    startDateLabel.text = article.startDate;
    contentTextView.text = article.content;
    [article release];
}
#pragma mark - Connection data delegate

//服务器响应请求,初始化存放xml数据的_data
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse
{
    _data = [[NSMutableData alloc]init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
//完成数据接收,设置文章视图显示的内容
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [activityV hidden];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    [self setViewContent];
   
}

@end
