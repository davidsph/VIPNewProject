//
//  JobGuidanceHomeVC.m
//  JobGuidance
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JobGuidanceHomeVC.h"
#import "GDataXMLNode.h"
#import "ArticleListVC.h"
#import "ArticleDetailVC.h"
#import "Channel.h"
#import "Articles.h"


@interface JobGuidanceHomeVC()
//发送网络请求
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end
@implementation JobGuidanceHomeVC
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
-(void)dealloc
{
    [activityV release];
    [super dealloc];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 50, 40);
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [btn addTarget:self action:@selector(backFirstView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn; 
    [backBtn release];

    self.navigationItem.title=@"求职指导";
    self.title=@"求职指导";
       
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"纸纹.png"]];
   
    self.tableView.delegate=self;
    
}
-(void)backFirstView
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
  
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)sendRequest
{
    //设置访问的URL
  
    NSURL *url = [[NSURL alloc]initWithString:@"http://mobileinterface.zhaopin.com/iphone/article/channellist.service"];
  
  
   //创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
   // 连接服务器
    NSURLConnection  *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [connection release];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self sendRequest];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES; 
    
    [super viewWillAppear:animated];
     
    
    //加载时页面
    activityV = [[ActivityView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:activityV];
    [activityV show];     
    
}
- (void)setViewContent
{
    //开始解析xml
    channelList = [[NSMutableArray alloc]init];
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
  
    //
    for (int i = 0; i<8; i++)
    {
        //解析channel的数据
        GDataXMLElement *channelElement = [[root children]objectAtIndex:i];
        Channel *channel = [[Channel alloc]init];
        channel.ID = [[[channelElement attributeForName:@"id"]stringValue]intValue];
        channel.name = [[[channelElement nodesForXPath:@"name" error:nil] objectAtIndex:0] stringValue];
    
        //解析articles的数据
        channel.articles = [[NSMutableArray alloc]init];        
        for (int j = 0; j<5; j++) 
        {
            Articles *article = [[Articles alloc]init];
            article.title = [[[channelElement nodesForXPath:@"articles/article/title" error:nil]objectAtIndex:j]stringValue];
            article.ID = [[[[channelElement nodesForXPath:@"articles/article/id" error:nil]objectAtIndex:j]stringValue]intValue];
            [channel.articles addObject:article];
            [article release];
        }
        [channelList addObject:channel];
        [channel release];
    }
   
    
    //设置view的内容    
    [self.tableView reloadData];
    [_data release];
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
    
    [self setViewContent];
    [activityV hidden];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    // Return the number of sections.
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
  
    cell.textLabel.font =[UIFont fontWithName:@"Verdana" size:18];
    
    UIImage *image=[UIImage imageNamed:@"accessoryArrow.png"];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    button.backgroundColor=[UIColor colorWithPatternImage:image];
    cell.accessoryView=button;
    

    Channel *channel = [channelList objectAtIndex:indexPath.section];
    Articles *article = [channel.articles objectAtIndex:indexPath.row]; 
    cell.textLabel.text = article.title;
    
    
   
    
    
     
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    //用label显示文章类型
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textColor=[UIColor blackColor];
    Channel *channel = [channelList objectAtIndex:section];
    label.text = channel.name;
    [view addSubview:label];
    [label release];
    //创建more按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = channel.ID;
    button.frame = CGRectMake(250, 10, 50, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"moreNormal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"moreSelected.png"] forState:UIControlStateHighlighted];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [button setTitle:@"更多" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
   
    return view;
}

- (void)moreButtonClicked:(UIButton *)button
{
    ArticleListVC *detailViewController = [[ArticleListVC alloc]init];
    detailViewController.ID = button.tag;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
   
   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    ArticleDetailVC *detailViewController = [[ArticleDetailVC alloc] init];
    Channel *channel = [channelList objectAtIndex:indexPath.section];
    Articles *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
   
     
}

@end
