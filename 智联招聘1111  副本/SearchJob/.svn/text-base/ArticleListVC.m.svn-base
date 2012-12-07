//
//  ArticleListVC.m
//  JobGuidance
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleListVC.h"
#import "Articles.h"
#import "ArticleDetailVC.h"
#import "Channel.h"


@interface ArticleListVC()
//发送网络请求
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end

@implementation ArticleListVC

@synthesize ID;
@synthesize tableView;
-(void)dealloc
{
    self.tableView=nil;
    [super  dealloc];
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
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
     self.view =[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground.png"]];
 
    self.navigationItem.backBarButtonItem=nil;
   
    //自定义leftbutton
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 50, 44);
    [button setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
   tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor=[UIColor clearColor];
   tableView.dataSource=self;
   tableView.delegate=self;
   [self.view addSubview:tableView];
   [tableView release];
    
  
    

    
   
}
-(void)back
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}


//实现发送网络请求的方法
- (void)sendRequest
{
    //设置访问的URl
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articlelist.service?cid=%d",self.ID];
    NSURL *url = [[NSURL alloc]initWithString:string];
    [string release];
    //创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    //连接服务器
    NSURLConnection  *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [connection release];
   
}
//实现设置view的内容的方法
- (void)setViewContent
{
   
    channel = [[Channel alloc]initByXMLData:_data];
    //设置view的内容    
    [self.tableView reloadData];
    [_data release];
    self.navigationItem.title=channel.name;

}
#pragma mark - 网络连接异步代理

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
#pragma mark - table view data 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}
//row的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return channel.articleCount;
}
//cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font =[UIFont fontWithName:@"Verdana" size:18];
    
    UIImage *image=[UIImage imageNamed:@"accessoryArrow.png"];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    button.backgroundColor=[UIColor colorWithPatternImage:image];
    cell.accessoryView=button;
    
    Articles *article = [channel.articles objectAtIndex:indexPath.row];   
    cell.textLabel.text = article.title;  
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailVC *detailViewController = [[ArticleDetailVC alloc] init];
    Articles *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


@end
