//
//  VIPArticleListViewController.m
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPArticleListViewController.h"
#import "VIPChannel.h"
#import "VIPArticle.h"
#import "VIPIndicator.h"
#import "VIPChannelListViewController.h"
//私有方法
@interface VIPArticleListViewController()
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
-(void)reloadView;
@end

@implementation VIPArticleListViewController
@synthesize articleListTableView,ID,i,topButton,txtFont;

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
    imgv.userInteractionEnabled=YES;
    imgv.image = [UIImage imageNamed:@"home.png"];
    [self.view addSubview:imgv];
    [imgv release];
    self.articleListTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    self.articleListTableView.backgroundColor=[UIColor blueColor];
    self.tableView=self.articleListTableView;
    i=10;
    canreload=YES;
    self.navigationItem.title=@"更多文章";
     footView=[[VIPTableFootView alloc]init];
     self.tableView.tableFooterView=footView;
    topButton=[UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame=CGRectMake(30, 0, 260, 50);
    [topButton addTarget:nil action:@selector(gotop) forControlEvents:UIControlEventTouchUpInside];
    [topButton setTitle:@"没有更多了,点击文字回顶部" forState:UIControlStateNormal];
    [footView addSubview:topButton];

   }

- (void)viewDidUnload
{
    [self setArticleListTableView:nil];
    [channel release],channel = nil;
    [super viewDidUnload];
}
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    //发送网络请求
    [self sendRequest];
    //添加网络状况视图 
    [VIPIndicator addIndicator:self.view];
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
#pragma mark -私有方法
//实现发送网络请求的方法
- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articlelist.service?cid=%d",self.ID];
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
    channel = [[VIPChannel alloc]initByXMLData:_data];
    //设置view的内容    
    [articleListTableView reloadData];
    [_data release];
}
#pragma mark - 网络连接异步代理
//发送网络请求失败时，执行的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
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
    //移除网络状况提示视图
    [VIPIndicator removeIndicator:self.view];
    [self setViewContent];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return i;
}
//网络上提显示更多
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>hight&&canreload==YES) {
        [self performSelector:@selector(reloadView) withObject:nil afterDelay:1.0]; 
        i=i+10;
        hight=hight+10*44;
        [footView.activityIndicator startAnimating];
        self.topButton.hidden=YES;
          }
   if(canreload==NO)
    {
        footView.infoLabel.hidden=YES;
        footView.activityIndicator.hidden=YES;
        self.topButton.hidden=NO;
    }
}
-(void)gotop//回至顶部
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)reloadView//重新载入
{
    [self.tableView reloadData];
    if (i>=channel.totalCount) {
        canreload=NO;
    }
 }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    VIPArticle *article= [channel.articles objectAtIndex:indexPath.row];
    cell.textLabel.text = article.title;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIPArticleDetailViewController *detailViewController = [[VIPArticleDetailViewController alloc] init];
    VIPArticle *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
    detailViewController.delegate=self;
    detailViewController.textFont=self.txtFont;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release]; 
}

//重写dealloc
- (void)dealloc 
{
    [articleListTableView release];
    [super dealloc];
}

@end
