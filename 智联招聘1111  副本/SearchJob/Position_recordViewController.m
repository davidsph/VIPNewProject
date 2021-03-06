//
//  Position_recordViewController.m
//  Position-record
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Position_recordViewController.h"
#import "RecordCell.h"
#import "IsLogin.h"
#import "GDataXMLNode.h"
#import "DNWrapper.h"
#import "A1ShowJob.h"
#import "A1Job.h"

@implementation Position_recordViewController

@synthesize receivedData,recordArr,tableV,items;

-(void)dealloc
{
    [activityV release];
    [connection release];
    [items release];
    [self.tableV release];
    [super dealloc];
}


-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 416)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"纸纹.png"]];
    self.navigationItem.title = @"职位申请记录";
    
//    UIImage *titleImage = [UIImage imageNamed:@"navigationbar_bg.png"];  //获取图片
//    [self.navigationController.navigationBar setBackgroundImage:titleImage forBarMetrics:UIBarMetricsDefault];  //设置背景
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom]autorelease];
    btn.frame = CGRectMake(0, 0, 50, 44);//横纵坐标无关紧要
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];//设置背景图片
    [btn setTitle:@"智联" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[[UIBarButtonItem alloc]initWithCustomView:btn]autorelease];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //加载时页面
    activityV = [[ActivityView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:activityV];
    activityV.alpha = 0.7;
    [activityV show]; 
    
    IsLogin *islogin=[IsLogin defaultIsLogin];
    NSString *url0=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_applist.aspx?uticket=%@&Page=1&Pagesize=1000",islogin.uticket];
    NSString *url1 = [DNWrapper getMD5String:url0];
    NSURL *url = [NSURL URLWithString:url1];
    //创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //连接服务器
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];          
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    items = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < 6; i++)
    {
        [items addObject:[NSString stringWithFormat:@"cell %i",i]];
    }      
}

- (void)didReceiveMemoryWarning 
{ 
    [super didReceiveMemoryWarning]; 
}

- (void)viewDidUnload 
{ 
    items = nil;
    self.tableV = nil;
} 


-(void)back//返回按钮触发方法
{
//    if (self.mm == 10) {
//        [self dismissModalViewControllerAnimated:YES];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//section个数
{
    int count = [items count];
    return count + 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行高
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//cell显示
{
    NSString *identifier = [NSString stringWithFormat:@"row%d",indexPath.row];//不重用
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        cell = [[[RecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;//颜色 
        
        //右侧小按钮
        UIImage *image= [UIImage imageNamed:@"accessoryArrow.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button. frame = CGRectMake(0.0,0.0,image.size.width,image.size.height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tableView:didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];//点击此小按钮跟点击cell触发方法相同
        button. backgroundColor = [UIColor clearColor];
        cell. accessoryView = button;        
    }
    else
    {
        return cell;
    }
    
    if(indexPath.row == ([items count])) 
    { 
        cell.textLabel.text = @"More...";
    }
    else 
    {     
        NSArray *titleArr = [root nodesForXPath:@"applylist/apply/job_title" error:nil];//绝对路径
        NSArray *nameArr = [root nodesForXPath:@"applylist/apply/company_name" error:nil];//绝对路径    
        NSArray *dateArr = [root nodesForXPath:@"applylist/apply/date_applied" error:nil];//绝对路径    
        NSArray *countArr = [root nodesForXPath:@"applylist/apply/applied_count" error:nil];//绝对路径
        
        //职位名称
        cell.titleLabel.text = [[titleArr objectAtIndex:indexPath.row] stringValue];
        
        //职位所在公司
        cell.companyLabel.text = [[nameArr objectAtIndex:indexPath.row] stringValue];
        
        //申请职位日期
        NSString *date = [[dateArr objectAtIndex:indexPath.row] stringValue];
        NSString *monthDate1 = [date substringToIndex:7];
        NSString *monthDate2 = [monthDate1 substringFromIndex:6];//取到第七位字符
        NSString *monthDate3 = [monthDate1 substringFromIndex:5];//取到第六、七位字符
        NSString *monthDate4 = [date substringToIndex:6];
        NSString *monthDate5 = [monthDate4 substringFromIndex:5];//取到第六位字符
        if ([monthDate2 isEqualToString:@"/"]) //判断第七位字符是否为“/”
        {
            NSString *monthDate6 = [@"0" stringByAppendingString:monthDate5];
            NSString *dayDate1 = [date substringToIndex:9];
            NSString *dayDate2 = [dayDate1 substringFromIndex:8];//取到第九位字符
            NSString *dayDate3 = [dayDate1 substringFromIndex:7];//取到第八、九位字符
            NSString *dayDate4 = [date substringToIndex:8];
            NSString *dayDate5 = [dayDate4 substringFromIndex:7];//取到第八位字符
            NSString *dayDate6;
            if ([dayDate2 isEqualToString:@" "]) 
            {
                dayDate6 = [@"0" stringByAppendingString:dayDate5];
            }
            else
            {
                dayDate6 = dayDate3;
            }
            NSString *monthDate7 = [monthDate6 stringByAppendingString:@"-"];
            cell.dateLabel.text = [monthDate7 stringByAppendingString:dayDate6];            
        }
        else
        {
            NSString *dayDate1 = [date substringToIndex:10];
            NSString *dayDate2 = [dayDate1 substringFromIndex:9];//取到第十位字符
            NSString *dayDate3 = [dayDate1 substringFromIndex:8];//取到第九、十位字符
            NSString *dayDate4 = [date substringToIndex:9];
            NSString *dayDate5 = [dayDate4 substringFromIndex:8];//取到第九位字符
            NSString *dayDate6;
            if ([dayDate2 isEqualToString:@" "]) 
            {
                dayDate6 = [@"0" stringByAppendingString:dayDate5];
            }
            else
            {
                dayDate6 = dayDate3;
            }
            NSString *monthDate6 = [monthDate3 stringByAppendingString:@"-"];
            cell.dateLabel.text = [monthDate6 stringByAppendingString:dayDate6];          
            
        }
        
        //此职位已申请人数
        NSString *count0 = [[countArr objectAtIndex:indexPath.row] stringValue];
        NSString *count1 = @"已申请：";
        NSString *count2 = [count1 stringByAppendingString:count0];
        NSString *count3 = [count2 stringByAppendingString:@"人"];
        cell.countLabel.text = count3;
    }     
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath//点击cell触发方法
{
    if (indexPath.row == [items count]) 
    { 
        [self performSelectorInBackground:@selector(appendTableWith) withObject:nil]; 
        [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return ; 
    }     
    else
    {        
        A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
        
        NSArray *jobnumberArr = [root nodesForXPath:@"applylist/apply/job_number" error:nil];
        NSArray *jobtitleArr = [root nodesForXPath:@"applylist/apply/job_title" error:nil];
        NSArray *jobcityArr = [root nodesForXPath:@"applylist/apply/job_city" error:nil];    
        
        A1Job *job=[[A1Job alloc]initWithJobNumber:[[jobnumberArr objectAtIndex:indexPath.row] stringValue] JobTitle:[[jobtitleArr objectAtIndex:indexPath.row] stringValue] JobCity:[[jobcityArr objectAtIndex:indexPath.row] stringValue] JobCityRegion:nil];
        showJobVC.job=job;
        showJobVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:showJobVC animated:YES];
    }
}


-(void)appendTableWith
{ 
    for (int i = 0;i < 6;i++) 
    { 
        [items addObject:[NSString stringWithFormat:@"%d",i ]]; 
    } 
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:6]; 
    for (int ind = 6; ind >= 1; ind--) 
    { 
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:items.count-ind inSection:0]; 
        [insertIndexPaths addObject:newPath]; 
    } 
    [self.tableV insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade]; 
} 

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [NSMutableData data];//data:类方法，创建并返回一个空的数据对象
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:self.receivedData options:0 error:nil];
    root = [[document rootElement] retain];//获得根节点 
    GDataXMLElement *applylist = [[root children]objectAtIndex:1];
    self.recordArr = [applylist children];
    
    //数据加载完才有tableV
    self.tableV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableV];         
    self.tableV.delegate = self;
    self.tableV.dataSource = self; 
    [activityV hidden];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error//异常时调用
{
    NSLog(@"%@",[error localizedDescription]);
}




@end
