//
//  PositionFavoriteViewController.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PositionFavoriteViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "GDataXMLNode.h"
#import "PositionCell.h"
#import "Position.h"
#import "DNWrapper.h"
#import "Position_detailViewController.h"
#import "A1Job.h"
#import "A1ShowJob.h"
#import "IsLogin.h"
@implementation PositionFavoriteViewController

@synthesize favoriteData;
@synthesize root;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    
    [favoriteData release];
    [root release];
    [uTicket release];
    [jobArray release];
    [selectJob release];
    [root release];
    [tableV release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



- (void)loadView
{
    self.navigationItem.title=@"职位收藏夹";
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-49)];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"纸纹.png"]];
    
    IsLogin *islogin=[IsLogin defaultIsLogin];
    uTicket=islogin.uticket;
    NSString *urlString=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_list.aspx?uticket=%@",uTicket];
    [self setURL:urlString];
    
    
    //加载时页面
    activityV = [[ActivityView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    [self.view addSubview:activityV];
    [activityV show];     
    
    positionArray=[[NSMutableArray alloc]init];
    selectJob=[[NSMutableArray alloc]init];
    a=0;
}
-(void)viewDidLoad
{
    // set the self.navigationItem.rightBarButtonItem
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =  CGRectMake(0, 0, 50, 44);
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.titleLabel.adjustsFontSizeToFitWidth =YES;
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"方形按钮.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    // set the self.navigationItem.rightBarButtonItem
    UIButton  *  leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =  CGRectMake(0, 0, 50, 44);
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.titleLabel.adjustsFontSizeToFitWidth =YES;
    [leftBtn setTitle:@"首页" forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back ) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backBarButton;
    [backBarButton release];
    [super viewDidLoad];
}
-(void)back
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)setURL:(NSString *)string{
    NSString *urlstr=[DNWrapper getMD5String:string];
    NSURL *url = [NSURL URLWithString:urlstr];//多个之间用&隔开，如：do?type=focus-c&sdef=hnulik 
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    
    NSURLConnection  *connection2 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection2 release];
}


-(void)connection:(NSURLConnection *)connect didFailWithError:(NSError *)error{
    
    NSLog(@"数据未获取到");    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.favoriteData=[[NSMutableData alloc]init];//初始化
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.favoriteData appendData:data];//拼接数据
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [activityV hidden];
    [self setPosition];
    //显示tableview，并指定代理，执行代理方法
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-49) style:UITableViewStyleGrouped];
    tableV.backgroundColor=[UIColor clearColor];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    
    jobArray=[[NSMutableArray alloc]initWithArray:[root nodesForXPath:@"joblist/job" error:nil]];
    
}

-(void)setPosition{
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithData:self.favoriteData options:0 error:nil];
    root=[[document rootElement] retain];//取到根结点
    NSArray *List=[root nodesForXPath:@"joblist/job" error:nil];
    
    for (int i=0; i<[List count]; i++) {
        
        GDataXMLElement *positionE=[List objectAtIndex:i];
        Position *position=[[Position alloc]init];
        position.jobNumber=[[[positionE nodesForXPath:@"job_number" error:nil] objectAtIndex:0]stringValue];
        position.jobTitle=[[[positionE nodesForXPath:@"job_title" error:nil] objectAtIndex:0]stringValue];
        position.jobCity=[[[positionE nodesForXPath:@"job_city" error:nil] objectAtIndex:0]stringValue];
        position.applyCount=[[[positionE nodesForXPath:@"applied_count" error:nil] objectAtIndex:0]stringValue];
        position.companyNumber=[[[positionE nodesForXPath:@"company_number" error:nil] objectAtIndex:0]stringValue];
        position.companyName=[[[positionE nodesForXPath:@"company_name" error:nil] objectAtIndex:0]stringValue];
        [positionArray addObject:position];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [positionArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"Cell";
    PositionCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[[PositionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    Position *positon=[positionArray objectAtIndex:indexPath.row];
    
    cell.positionName.text=positon.jobTitle;
    cell.companyName.text=positon.companyName;
    cell.companyAddress.text=positon.jobCity;
    
    
    //添加右侧小按钮
    UIImage *image= [UIImage imageNamed:@"accessoryArrow.png"];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton. frame = CGRectMake(0.0,0.0,image.size.width,image.size.height);
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    rightButton. backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(tableView:didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];//点击此小按钮和点击cell作用相同，都是进入职位详情界面
    cell. accessoryView = rightButton; 
    
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
    cell.btn.tag=indexPath.row;
    [cell.btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if ([selectJob count]!=0)//遍历所有的cell，确保不会因为从用机制，而使选定的cell出现差错
    {
        for (NSNumber *thisRow in selectJob) {
            int b=[thisRow intValue];
            if (indexPath.row==b) {
                //choose=YES;
                [cell.btn setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateNormal];
                break;
            }
        }
    }
    return cell;
}


-(void)selectButton:(UIButton *)button//选择cell，并改变编辑按钮
{
    if (selectJob .count!=0) {
        for (NSNumber *thisRow in selectJob) {
            int b=[thisRow intValue];
            if (button.tag==b) {
                [selectJob removeObject:thisRow];//如果该button的tag已经存在数组中，当再次点击button时，应该从数组中移出，把图片设置成未选定
                [button setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
                if ([selectJob count]==0)//在这儿判断一下数组中的元素的个数是不是为零，是否需要改变右上角的button的功能
                {
                    
                    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
                    
                    
                }else{
                    
                    [rightBtn setTitle:@"申请" forState:UIControlStateNormal];
                    
                    
                }
                return;
            }else{
                
            }
        }
    }
    
    [selectJob addObject: [NSNumber numberWithInt:button.tag]];
    
    [button setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateNormal];
    if ([selectJob count]==0) {
        
        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        
    }else{
        
        [rightBtn setTitle:@"申请" forState:UIControlStateNormal];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath//点击cell触发方法
{
    
    A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
    Position *position=[positionArray objectAtIndex:indexPath.row];
    A1Job *job=[[A1Job alloc]initWithJobNumber:position.jobNumber JobTitle:position.jobTitle JobCity:position.jobCity JobCityRegion:nil];
    showJobVC.job=job;
    showJobVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:showJobVC animated:YES];
    
}
-(void)doSomething:(UIButton *)btn
{
    NSString  *string1 =[btn titleForState:UIControlStateNormal];
    
    if ([string1 isEqualToString:@"编辑"]) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        // allow  deleting 
        [self setEditing:YES animated:YES];
    }else{
        // forbid deleting
        if ([string1 isEqualToString:@"完成"]) {
            [btn setTitle:@"编辑" forState:UIControlStateNormal];
            // no editing  but has animation
            [self setEditing:NO animated:YES];
        }else
            //apply
            [self performSelector:@selector(apply)];
    }
}

-(void)apply//:(id)sender
{
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:10];
    for (NSNumber *n in selectJob) {
        int i=[n intValue];
        Position *position=[positionArray objectAtIndex:i];
        [arr addObject:position.jobNumber];
    }
    ApplyProcess *aApply=[ApplyProcess Apply];
    self.delegate=aApply;
    if([arr count]==0)
    {
        UIAlertView *zView=[[UIAlertView alloc]initWithTitle:@"" message:@"您没有选择公司" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [zView show];
    }
    else if([arr count]==1)
    {
        [self.delegate singleApply:arr];//触发单个申请的方法
    }
    else
    {
        [self.delegate moreApply:arr];//触发批量申请的方法
    }
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [tableV setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //向服务器发送删除请求，删除收藏的职位
        
        GDataXMLElement *job=[[root nodesForXPath:@"joblist/job" error:nil] objectAtIndex:indexPath.row];
        GDataXMLElement *job_number=[[job nodesForXPath:@"job_number" error:nil] objectAtIndex:0];
        
        //同步get请求
        NSString *str=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_del.aspx?job_number=%@&uticket=%@",[job_number stringValue],uTicket];
        
        NSString *url1=[DNWrapper getMD5String:str];
        NSURL *url=[NSURL URLWithString:url1];
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        //第三步，连接服务器
        NSURLResponse *response = nil;
        NSError *err = nil;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
        [positionArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    
}
@end

