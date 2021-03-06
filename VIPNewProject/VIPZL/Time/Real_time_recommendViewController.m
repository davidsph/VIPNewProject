//
//  Real_time_recommendViewController.m
//  Real-time recommend
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Real_time_recommendViewController.h"
#import "ApplyCell.h"
#import "UnApplyCell.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"
#import "A1ShowJob.h"
#import "IsLogin.h"
#import "VIPLoginViewController.h"

@implementation Real_time_recommendViewController

@synthesize receivedData,delegate,uTicket;


-(void)dealloc
{
    
    [self.receivedData release];
    [self.uTicket release];
    
    [super dealloc];
}


-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 416)]autorelease];
    self.navigationItem.title = @"实时推荐";

    UIBarButtonItem *rightButon = [[UIBarButtonItem alloc] initWithTitle:@"申请" style:UIBarButtonItemStyleBordered target:self action:@selector(apply)];    
    //UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc]initWithCustomView:btn]autorelease];
    self.navigationItem.rightBarButtonItem = rightButon;
    
    //设置大背景
    UIImageView *imageV0 = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    imageV0.image = [UIImage imageNamed:@"Home.jpg"];
    [self.view addSubview:imageV0];
    
    selectJob = [[NSMutableArray alloc]init]; 
}
-(void)backHome
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    //加载时页面
    activityV = [[ActivityView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:activityV];
    
    [activityV show]; 
}
-(void)viewDidAppear:(BOOL)animated
{
    a++;
    IsLogin *islogin=[IsLogin defaultIsLogin];
    self.uTicket=islogin.uticket;
        
    if (self.uTicket == nil) 
    {
        //未登录警示框
        loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" 
                                                message:@"您尚未登录，无法推荐职位" 
                                               delegate:self 
                                      cancelButtonTitle:@"放弃" 
                                      otherButtonTitles:@"登录", nil];
        [loginAlertV show];
        [activityV hidden];
    }
    else
    {       
        if (a == 1)
        {
            NSString *url0=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/recommendjob.aspx?uticket=%@",uTicket];
            NSString *url1 = [DNWrapper getMD5String:url0];
            NSLog(@"%@",url1);
            NSURL *url = [NSURL URLWithString:url1];
            //创建请求
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //连接服务器
            connection = [[NSURLConnection alloc]initWithRequest:request delegate:self]; 
            c = YES;
        }
        if (c == NO && a == 2) 
        {
            NSString *url0 = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/recommendjob.aspx?uticket=%@",self.uTicket];
            NSString *url1 = [DNWrapper getMD5String:url0];
            NSLog(@"%@",url1);
            NSURL *url = [NSURL URLWithString:url1];
            //创建请求
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //连接服务器
            connection = [[NSURLConnection alloc]initWithRequest:request delegate:self]; 
            c = YES;
        }
    } 
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//警示框的按钮触发方法
{      
    if (alertView == loginAlertV)//如果是登录警示框 
    {  
        if(buttonIndex == 0) 
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        if(buttonIndex == 1)
        {
            VIPLoginViewController *loginVC = [[[VIPLoginViewController alloc]init]autorelease];
            //loginVC.tag = 5;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
} 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView//分区的个数
{
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil)//填写过简历并申请过职位
    {
        return [[[root children] objectAtIndex:1] childCount];
    }
    else//填写过简历，但没申请过职位
    {
        return [[[root children] objectAtIndex:2] childCount];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//各个分区的行数
{
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil)//填写过简历并申请过职位 
    {
        return [[[[[[[root children] objectAtIndex:1] children] objectAtIndex:section] children] objectAtIndex:1] childCount];
    }
    else//填写过简历，但没申请过职位
    {    
        return [[[[[root children] objectAtIndex:2] children] objectAtIndex:section] childCount];
    }    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行的宽度
{
    return 70;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section//表头设置
{
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil)//填写过简历并申请过职位 
    {
        GDataXMLElement *jobrecommend = [[root children] objectAtIndex:1];
        GDataXMLElement *applyjob = [[jobrecommend children] objectAtIndex:section];
        GDataXMLElement *job = [[applyjob children] objectAtIndex:0];
        GDataXMLElement *title = [[job children] objectAtIndex:1];
        
        NSString *titleForHeader1 = @"申请了【";
        NSString *titleForHeader2 = [title stringValue];
        NSString *titleForHeader3 = [titleForHeader1 stringByAppendingString:titleForHeader2];
        NSString *titleForHeader4 = [titleForHeader3 stringByAppendingString:@"】的人，还申请了以下职位"];
        
        UIView *sectionView = [[[UIView alloc]init]autorelease];
        UILabel *sectionLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 50)]autorelease];
        sectionLabel.text = titleForHeader4;
        sectionLabel.textColor = [UIColor whiteColor];
        sectionLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        sectionLabel.lineBreakMode = YES;
        sectionLabel.numberOfLines = 2;
        sectionLabel.backgroundColor = [UIColor clearColor];
        [sectionView addSubview:sectionLabel];
        return sectionView;
    }
    else//填写过简历，但没申请过职位
    {    
        UIView *sectionView = [[[UIView alloc]init]autorelease];
        UILabel *sectionLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)]autorelease];
        sectionLabel.text = @"根据你的求职意愿为你推荐如下职位";
        sectionLabel.textColor = [UIColor whiteColor];
        sectionLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        sectionLabel.lineBreakMode = YES;
        sectionLabel.numberOfLines = 2;
        sectionLabel.backgroundColor = [UIColor clearColor];
        [sectionView addSubview:sectionLabel];
        return sectionView;        
    }    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//每行的显示
{
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil)//填写过简历并申请过职位 
    {
        static NSString *identifier = @"reuseFlag";//重用标志
        ApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];              
        if (cell == nil) 
        {
            cell = [[[ApplyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;//颜色             
        }        
        
        //添加右侧小按钮
        UIImage *image= [UIImage imageNamed:@"accessoryArrow.png"];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton. frame = CGRectMake(0.0,0.0,image.size.width,image.size.height);
        [rightButton setBackgroundImage:image forState:UIControlStateNormal];
        rightButton. backgroundColor = [UIColor clearColor];
        [rightButton addTarget:self action:@selector(tableView:didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];//点击此小按钮和点击cell作用相同，都是进入职位详情界面
        cell. accessoryView = rightButton; 
                
        //避免左侧按钮因重用出现差错
        cell.btn.tag = indexPath.row + (100 * indexPath.section) + 100;//每个section行都是从0开始，如果只写indexPath.row,那么每个section第一行会相同
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];        
        if ([selectJob count] != 0)//遍历所有的cell，确保不会因为重用机制，而使选定的cell出现差错
        {
            for (NSNumber *thisRow in selectJob) 
            {
                int b = [thisRow intValue];
                if ((indexPath.row + 100 * indexPath.section) + 100 == b) 
                {
                    [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateNormal];
                    break;
                }
            }
        }
        
        
        //取出数据并显示
        GDataXMLElement *jobrecommend = [[root children] objectAtIndex:1];
        GDataXMLElement *applyjob = [[jobrecommend children] objectAtIndex:indexPath.section];
        GDataXMLElement *positionlist = [[applyjob children] objectAtIndex:1];        
        GDataXMLElement *position = [[positionlist children] objectAtIndex:indexPath.row];
        
        GDataXMLElement *title = [[position children] objectAtIndex:1];
        GDataXMLElement *company = [[position children] objectAtIndex:6];
        GDataXMLElement *ratio = [[position children] objectAtIndex:8];
        GDataXMLElement *date = [[position children] objectAtIndex:2];
        GDataXMLElement *city = [[position children] objectAtIndex:3];
                
        cell.titleLabel.text = [title stringValue]; 
        cell.companyLabel.text = [company stringValue];
        cell.ratioLabel.text = [ratio stringValue];
        cell.dateLabel.text = [date stringValue];
        cell.cityLabel.text = [city stringValue];
        
        return cell;
    }
    else//填写过简历，但没申请过职位
    {
        static NSString *identifier = @"reuseFlag";//重用标志
        UnApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) 
        {
            cell = [[[UnApplyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;//颜色 
        
        
        //添加右侧小按钮
        UIImage *image= [UIImage imageNamed:@"accessoryArrow.png"];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton. frame = CGRectMake(0.0,0.0,image.size.width,image.size.height);
        [rightButton setBackgroundImage:image forState:UIControlStateNormal];
        rightButton. backgroundColor = [UIColor clearColor];
        [rightButton addTarget:self action:@selector(tableView:didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];//点击此小按钮和点击cell作用相同，都是进入职位详情界面
        cell. accessoryView = rightButton;        
        
        //避免左侧按钮因重用出现差错
        cell.btn.tag = indexPath.row;//btn的tag值就是行数值
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];        
        if ([selectJob count] != 0)//遍历所有的cell，确保不会因为重用机制，而使选定的cell出现差错
        {
            for (NSNumber *thisRow in selectJob) 
            {
                int b = [thisRow intValue];
                if (indexPath.row == b) 
                {
                    [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateNormal];
                    break;
                }
            }
        }
        
        //取出数据并显示
        GDataXMLElement *mindrecommend = [[root children] objectAtIndex:2];
        GDataXMLElement *positionlist = [[mindrecommend children] objectAtIndex:0];
        GDataXMLElement *position = [[positionlist children] objectAtIndex:indexPath.row];
        
        GDataXMLElement *title = [[position children] objectAtIndex:1];
        GDataXMLElement *company = [[position children] objectAtIndex:6];
        GDataXMLElement *city = [[position children] objectAtIndex:2];
        
        cell.titleLabel.text = [title stringValue]; 
        cell.companyLabel.text = [company stringValue];
        cell.cityLabel.text = [city stringValue]; 
        
        return cell;
    }
}


-(void)selectButton:(UIButton *)button//点击左边小按钮的触发方法
{
    if ([selectJob count] != 0) 
    {
        for (NSNumber *thisRow in selectJob) 
        {
            int b = [thisRow intValue];
            if (button.tag == b) 
            {
                [selectJob removeObject:thisRow];//如果该button的tag已经存在数组中，当再次点击button时，应该从数组中移出，把图片设置成未选定
                [button setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
                return ;
            }
        }
    }    
    [selectJob addObject: [NSNumber numberWithInt:button.tag]];    
    [button setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateNormal];
}


-(void)apply//点击申请按钮会向自动申请职位发送一份简历，发送成功后会显示一个警示框，告知用户发送简历成功
{    
    NSMutableArray *selectJobNumber = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];        
    for (NSNumber *thisRow in selectJob) 
    {
        int b = [thisRow intValue];
        int i = b / 100 - 1;
        int j = b % 100;
        
        GDataXMLElement *jobrecommend = [[root children] objectAtIndex:1];
        GDataXMLElement *applyApplyJob = [[jobrecommend children] objectAtIndex:i];
        GDataXMLElement *applyPositionList = [[applyApplyJob children] objectAtIndex:1];
        GDataXMLElement *applyPosition = [[applyPositionList children] objectAtIndex:j];
        GDataXMLElement *applyJobNumber = [[applyPosition children] objectAtIndex:0];        
        
        [selectJobNumber addObject:[applyJobNumber stringValue]];
    }
        
    //传值
    ApplyProcess *aApply=[ApplyProcess Apply];
    self.delegate=aApply;
    
    
    if ([selectJobNumber count] == 0)//没有选择职位 
    {
        UIAlertView *zView=[[UIAlertView alloc]initWithTitle:@"" message:@"您没有选择公司" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [zView show];
    }
    if([selectJobNumber count] == 1)//选择了一个职位
    {
        NSLog(@"单个申请");
        [self.delegate singleApply:selectJobNumber];//触发单个申请的方法
    }
    if ([selectJobNumber count] > 1)//选择了多于一个职位         
    {
        NSLog(@"批量申请");
        [self.delegate moreApply:selectJobNumber];//触发批量申请的方法
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath//点击cell或者右侧按钮触发方法
{
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil)//填写过简历并申请过职位 
    {                
        //取出数据并显示
        GDataXMLElement *jobrecommend = [[root children] objectAtIndex:1];
        GDataXMLElement *applyjob = [[jobrecommend children] objectAtIndex:indexPath.section];
        GDataXMLElement *positionlist = [[applyjob children] objectAtIndex:1];        
        GDataXMLElement *position = [[positionlist children] objectAtIndex:indexPath.row];
        
        GDataXMLElement *jobnumber = [[position children] objectAtIndex:0];
        GDataXMLElement *title = [[position children] objectAtIndex:1];
        GDataXMLElement *city = [[position children] objectAtIndex:3];
        
        A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
        A1Job *job=[[A1Job alloc]initWithJobNumber:[jobnumber stringValue] JobTitle:[title stringValue] JobCity:[city stringValue] JobCityRegion:nil];
        showJobVC.job=job;
        showJobVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:showJobVC animated:YES];                   
    }
    else//填写过简历，但没申请过职位
    {                
        //取出数据并显示
        GDataXMLElement *mindrecommend = [[root children] objectAtIndex:2];
        GDataXMLElement *positionlist = [[mindrecommend children] objectAtIndex:0];
        GDataXMLElement *position = [[positionlist children] objectAtIndex:indexPath.row];
        
        GDataXMLElement *jobnumber = [[position children] objectAtIndex:0];
        GDataXMLElement *title = [[position children] objectAtIndex:1];
        GDataXMLElement *city = [[position children] objectAtIndex:2];
        
        A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
        A1Job *job=[[A1Job alloc]initWithJobNumber:[jobnumber stringValue] JobTitle:[title stringValue] JobCity:[city stringValue] JobCityRegion:nil];
        showJobVC.job=job;
        showJobVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:showJobVC animated:YES];           
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [NSMutableData data];//data:类方法，创建并返回一个空的数据对象
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [activityV hidden];
    [self.receivedData appendData:data];//拼接数据，要在上边有self.receivedData = [NSMutableData data];这句话（见上个方法） 
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:self.receivedData options:0 error:nil];
    root = [[document rootElement] retain];//获得根节点 
    
    //未填写简历，未申请过职位
    if ([root childCount] == 2) 
    {
        alertV = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"\n对不起，<实时推荐>是根据您的简历或职位申请记录向您推荐的。填写简历请登录http://www.zhaopin.com。^_^" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];  
    }  
    //填写过简历并申请过职位  
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] == nil) 
    {
        //建立UITableView
        tableV1 = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStyleGrouped]autorelease];
        tableV1.backgroundColor = [UIColor clearColor];
        tableV1.sectionHeaderHeight = 50;//设置块头大小        
        [self.view addSubview:tableV1];         
        tableV1.delegate = self;
        tableV1.dataSource = self;
    }
    //填写过简历，未申请过职位
    if ([root childCount] == 3 && [[[[[root children] objectAtIndex:2] children] objectAtIndex:0] children] != nil) 
    {
        //建立UITableView
        tableV2 = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStyleGrouped]autorelease];
        tableV2.backgroundColor = [UIColor clearColor];
        tableV2.sectionHeaderHeight = 30;//设置块头大小
        [self.view addSubview:tableV2];         
        tableV2.delegate = self;
        tableV2.dataSource = self;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error//异常时调用
{
    NSLog(@"%@",[error localizedDescription]);
}

@end
