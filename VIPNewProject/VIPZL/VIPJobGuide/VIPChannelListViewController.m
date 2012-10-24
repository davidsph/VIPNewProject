//
//  VIPChannelListViewController.m
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPChannelListViewController.h"
#import "VIPArticleListViewController.h"
#import "VIPArticleDetailViewController.h"
#import "VIPChannel.h"
#import "VIPArticle.h"
#import "GDataXMLNode.h"
#import "VIPIndicator.h"

//私有方法
@interface VIPChannelListViewController()
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end


@implementation VIPChannelListViewController
@synthesize channelListTableView,txtFont;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imgv.image = [UIImage imageNamed:@"Home.jpg"];
    [self.view addSubview:imgv];
    self.channelListTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    self.channelListTableView.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Home.jpg"]];
    self.tableView=self.channelListTableView;
    self.txtFont =15;
   
}

- (void)viewDidUnload
{
    //释放内存
    [self setChannelListTableView:nil];
    [channelList release],channelList = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - View 生命周期
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    [self sendRequest];
    self.title = @"求职指导";
    [VIPIndicator addIndicator:self.view];
}
#pragma mark - 私有方法
//实现发送网络请求的方法
- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/channellist.service"];
    NSURL *url = [[NSURL alloc]initWithString:string];
    [string release];
    // 发送网络请求的方式有很多，具体哪一个更好，还需要测试
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    //使用异步获取网络数据，方法有两种，到底该用哪一种需要测试
    NSURLConnection  *_connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [_connection release];
}
//实现设置view的内容的方法
- (void)setViewContent
{
    //开始解析xml
    channelList = [[NSMutableArray alloc]init];
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    //
    for (int i = 0; i<8; i++) {
        //解析channel的数据
        GDataXMLElement *channelElement = [[root children]objectAtIndex:i];
        VIPChannel *channel = [[VIPChannel alloc]init];
        channel.ID = [[[channelElement attributeForName:@"id"]stringValue]intValue];
        channel.name = [[[channelElement nodesForXPath:@"name" error:nil] objectAtIndex:0] stringValue];
        //解析articles的数据
        channel.articles = [[NSMutableArray alloc]init];        
        for (int j = 0; j<5; j++) {
            VIPArticle *article = [[VIPArticle alloc]init];
            article.title = [[[channelElement nodesForXPath:@"articles/article/title" error:nil]objectAtIndex:j]stringValue];
            article.ID = [[[[channelElement nodesForXPath:@"articles/article/id" error:nil]objectAtIndex:j]stringValue]intValue];
            [channel.articles addObject:article];
            [article release];
        }
        [channelList addObject:channel];
        [channel release];
    }
    
    //设置view的内容    
    [channelListTableView reloadData];
    [_data release];
}
#pragma mark - 网络请求异步代理方法
//发送网络请求失败时，执行的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
//服务器响应请求时要执行的方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse
{
    //初始化存放xml数据的_data
    _data = [[NSMutableData alloc]init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
//完成数据接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self setViewContent];
    [VIPIndicator removeIndicator:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    VIPChannel *channel = [channelList objectAtIndex:indexPath.section];
    VIPArticle *article = [channel.articles objectAtIndex:indexPath.row]; 
    cell.textLabel.text = article.title;
    cell.textLabel.font = [UIFont fontWithName:@"" size:16];
    
    return cell;
}

//设置section header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//table view 每个section header里的视图的设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    //用label显示文章类型
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    VIPChannel *channel = [channelList objectAtIndex:section];
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
    [button release];
    return view;
}
//more按钮点击是push到文章列表界面
- (void)moreButtonClicked:(UIButton *)sender
{
    VIPArticleListViewController *detailViewController = [[VIPArticleListViewController alloc]init];
    detailViewController.ID = sender.tag;
    detailViewController.txtFont=self.txtFont;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
//当点击cell时，push到文章详细界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VIPArticleDetailViewController *detailViewController = [[VIPArticleDetailViewController alloc] init];
    VIPChannel *channel = [channelList objectAtIndex:indexPath.section];
    VIPArticle *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
    detailViewController.textFont=txtFont;
    detailViewController.delegate =self;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
//重写dealloc
- (void)dealloc {
    [channelListTableView release];
    [super dealloc];
}
-(void)textFont:(double)aTextFont
{
    self.txtFont =aTextFont;
    NSLog(@"%f",self.txtFont);
}
@end
