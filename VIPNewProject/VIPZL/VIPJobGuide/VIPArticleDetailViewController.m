//
//  VIPArticleDetailViewController.m
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPArticleDetailViewController.h"
#import "VIPArticleListViewController.h"
#import "VIPArticle.h"
#import "VIPIndicator.h"

//私有方法
@interface VIPArticleDetailViewController()
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end

@implementation VIPArticleDetailViewController
@synthesize ID,titleLabel,startDateLabel,imageView,contentTextView,endView,topView,textFont;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s",__FUNCTION__);
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
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imgv.userInteractionEnabled=YES;
    imgv.image = [UIImage imageNamed:@"Home.jpg"];
    [self.view addSubview:imgv];
    [imgv release];
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];//标题
    self.startDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 30, 165, 24)];//日期
    self.startDateLabel.font=[UIFont fontWithName:@"BradleyHandITCTT-Bold" size:13];//提示时间字体
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, 320, 4)];
    self.imageView.backgroundColor=[UIColor orangeColor];//分割线颜色
    self.contentTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 60, 320, 360)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.startDateLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textAlignment=UITextAlignmentCenter;//居中显示
    self.navigationItem.title=@"文章详情"; 
    
    //添加右侧“分享按钮”
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(share)];//分享事件
    self.navigationItem.rightBarButtonItem=right;
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem=left;
    self.endView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    self.contentTextView.font=[UIFont fontWithName:@"BradleyHandITCTT-Bold" size:self.textFont];//设置初始时字体的大小
    self.contentTextView.backgroundColor=[UIColor clearColor];
    self.contentTextView.delegate=self;
    self.contentTextView.editable=NO;//文章不可编辑
    //加捏合手势
    UIPinchGestureRecognizer*pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.contentTextView addGestureRecognizer:pinch];
    //加轻扫手势
    UISwipeGestureRecognizer *swp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    swp.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentTextView addGestureRecognizer:swp];
    
    [pinch release];
    [imgv addSubview:self.titleLabel];
    [imgv addSubview:self.startDateLabel];
    [imgv addSubview:self.imageView];
    [imgv addSubview:self.contentTextView];
 }

#pragma mark - View lifecycle
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    //发送网络请求
    [self sendRequest];
    // 显示网络状况提示视图
    [VIPIndicator addIndicator:self.view];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setStartDateLabel:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articledetail.service?id=%d",self.ID];
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
//设置view的内容
- (void)setViewContent
{
    //根据下载下来的xml数据创建article对象
    VIPArticle *article = [[VIPArticle alloc]initByXMLData:_data];
    [_data release];
    //设置view的内容
    titleLabel.text = article.title;
    startDateLabel.text = article.startDate;
    contentTextView.text = article.content;
    [article release];
}
//捏合手势的实现
-(void)pinch:(UIPinchGestureRecognizer*)pinch
{
    self.contentTextView.font=[UIFont fontWithName:@"BradleyHandITCTT-Bold" size:pinch.scale*15];
    self.textFont=pinch.scale*15;
}
//轻扫手势
- (void)swipe
{
    NSLog(@"向左轻扫");
    if (self.delegate &&[self.delegate respondsToSelector:@selector(textFont: )]) {
        [self.delegate textFont:self.textFont];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//实现返回
-(void)back
{
    int c = [self.navigationController.viewControllers count];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(100, 100, 0, 0)style:UITableViewStyleGrouped];
    tbView.backgroundColor = [UIColor clearColor];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.tag = 100;
    [self.contentTextView addSubview:tbView];
    
    [UIView animateWithDuration:2 animations:^{
        tbView.frame = CGRectMake(100,50, 110,40*c  );
    }];
    
}
//表格协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.navigationController.viewControllers count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:indexPath.row];
        NSString *name = vc.navigationItem.title;
        NSLog(@"路径 -- %@",name);
        cell.textLabel.text = name;
        cell.backgroundColor = [UIColor brownColor];
        cell.alpha = 0.8;
        cell.textLabel.textColor = [UIColor whiteColor];
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
            NSLog(@"返回到哪一个假面");
    if (indexPath.row == [self.navigationController.viewControllers count]-1) {
        [tbView removeFromSuperview];
    }
    else
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:indexPath.row] animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
           return 30;
}

//实现分享
-(void)share
{
    NSString *text;
    if (self.contentTextView.selectedRange.length > 0)
		text = [self.contentTextView.text substringWithRange:self.contentTextView.selectedRange];
	else
		text = self.contentTextView.text;
  	SHKItem *item = [SHKItem text:text];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - Connection data delegate
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
//重写dealloc
- (void)dealloc 
{
    [topView release];
    [imageView release];
    [endView release];
    [titleLabel release];
    [startDateLabel release];
    [contentTextView release];
    [super dealloc];
}


@end
