//
//  ShowTable.m
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1ShowTable.h"
#import "A1ShowJob.h"
#import "SearchJob.h"
#import "JobDetails.h"
#import "CollectJob.h"
#import "A1FilterTableVIewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchSavedArgument.h"
#import "IsLogin.h"
#import "LoginViewController.h"
#import "A1PopMenu.h"
#import "HomeViewController.h"

@implementation A1ShowTable
@synthesize selectArr,allJobArr,searchjob,dataSourseSign,jobNumber,loadMoreLa,delegate,actionSheet;
@synthesize recordSearcherName,tableView,count;

//int isFirst=1;//用来记录是否是第一次点击保存职位搜索器的

-(void)dealloc
{
    [self.recordSearcherName release];
    [self.tableView release];
    [self.actionSheet release];
    [self.selectArr release];
    [self.allJobArr release];
    [self.searchjob release];
    [self.jobNumber release];
    [self.loadMoreLa release];
    [super dealloc];
}

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView release];
    
    //自定义返回按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 55, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn;
    [backBtn release];
    

    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 55, 44);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    if (dataSourseSign==2)//普通搜索进来时添加筛选按钮
    {
         [btn2 setTitle:@"筛选" forState:UIControlStateNormal];
         [btn2 addTarget:self action:@selector(searchAgain) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(dataSourseSign==3)//相似职位时换成申请
    {
        [btn2 setTitle:@"申请" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];  
    self.navigationItem.rightBarButtonItem=backBtn2;   
    [backBtn2 release];
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}
-(void)searchAgain
{
    A1FilterTableVIewController * filter = [[A1FilterTableVIewController alloc] init];                
    filter.search = self.searchjob;
    filter.showtable=self;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
    [self.navigationController pushViewController:filter animated:NO];
    [filter.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    //筛选
}

-(void)back//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidUnload {
	_refreshHeaderView=nil;
}

- (void)viewDidLoad
{

    //数据初始化
    count=1;
    LoadingSign=NO;
    loadingMoreSign=NO;
    popMenuSign=1;
    self.allJobArr =[[NSMutableArray alloc]initWithCapacity:20];
    self.selectArr=[[NSMutableArray alloc]initWithCapacity:5];  
    self.navigationItem.title=@"搜索结果";
    
    //表尾提示加载文字
    UIView *ActView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    CGPoint po=self.view.center;
    po.y-=80;
    ActView.center=po;
    ActView.backgroundColor=[UIColor clearColor];
    ActView.tag=101;
    UIActivityIndicatorView *actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actInd.color=[UIColor grayColor];
    actInd.tag=102;
    actInd.frame=CGRectMake(32, 20, 37, 37);
    [actInd startAnimating];
    [ActView addSubview:actInd];
    [actInd release];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(15, 65, 70, 21)];
    la.tag=103;
    la.backgroundColor=[UIColor clearColor];
    la.textColor=[UIColor grayColor];
    la.text=@"载入中...";
    [ActView addSubview:la];
    [la release];
    [self.view  addSubview:ActView];
    [ActView release];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"搜索职位结果" object:nil];
    if (self.dataSourseSign==2)//高级搜索
    {
        [self.searchjob advancedSearchWith:1 Pagesize:20];
    }
    if (self.dataSourseSign==3)//相似职位
    {
        [SearchJob alikeJob:self.jobNumber page:1 pageSize:20];
    }
    [super viewDidLoad];

}

//UIalertviewdelegate协议中的方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        if(buttonIndex==0)
        {
            [searchNameFid resignFirstResponder];
            [saveSearchView removeFromSuperview];
        }
        else
        {
            LoginViewController *loginVC=[[LoginViewController alloc]init];
            loginVC.tag=3;
            [self.navigationController pushViewController:loginVC animated:YES];
            [loginVC release];
        }
    }
}
//取消方法
-(void)cancel
{
    [searchNameFid resignFirstResponder];
    [saveSearchView removeFromSuperview];
}

//点击保存搜索器按钮触发的方法
-(void)savedSearcher
{
    
    IsLogin *logInFlag=[IsLogin defaultIsLogin];
    if(logInFlag.isLogin==YES)//如果用户已经 登陆
    {
        //先判断是否登陆了 在判断保存器是否重名或是空
        self.recordSearcherName=searchNameFid.text;
        if(self.recordSearcherName==nil||[self.recordSearcherName isEqualToString:@""])//如果搜索器名为空的话
        {
            UIAlertView *nothingAlert=[[UIAlertView alloc]init];
            nothingAlert.message=@"搜索器名不能为空";
            [nothingAlert addButtonWithTitle:@"取消"];
            [nothingAlert show];
            [nothingAlert release];
        }
        else
        {
            [searchNameFid resignFirstResponder];
            [saveSearchView removeFromSuperview];
            [SearchSavedArgument SearchSavedWithUticket:logInFlag.uticket schJobType:self.searchjob.schJobType industry:self.searchjob.industry city:self.searchjob.city keyWord:self.searchjob.keyWord dataRefresh:self.searchjob.dataRefresh eduLevel:self.searchjob.eduLevel workingexp:self.searchjob.workingExp companytype:self.searchjob.companyType companysize:self.searchjob.companySize salaryfrom:self.searchjob.salaryFrom salaryto:self.searchjob.salaryTo searchName:self.recordSearcherName];
        }
    }
    else
    {
        UIAlertView *unLogInAlert=[[UIAlertView alloc]initWithTitle:@"您尚未登陆" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil];
        unLogInAlert.tag=1;
        [unLogInAlert show];
        [unLogInAlert release];
    }
    
}
//收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)receive:(NSNotification *)not//通过通知接收初始数据
{
    
    UIView * view=[self.tableView.superview viewWithTag:101];
    UIActivityIndicatorView *act=(UIActivityIndicatorView *)[view viewWithTag:102];
    [act stopAnimating];
    [view removeFromSuperview];
    
    NSDictionary *dic=[not userInfo];
    NSMutableArray *arr=[dic objectForKey:@"arr"];
    if (arr.count==0) {
    }
    else
    {
        //弹出按钮
        if (popMenuSign==1&&dataSourseSign==2) {
            A1PopMenu *mu=[[A1PopMenu alloc]initWithButtonName:[NSMutableArray arrayWithObjects: @"首页", @"申请",@"筛选",@"保存搜索器",nil]];
            mu.delegate=self;
            mu.center=CGPointMake(290, 380);
            [self.view addSubview:mu];
            [mu release];
            popMenuSign++;
        }
    }
    if (arr.count==20) {
        loadingMoreSign=YES;
    }
    self.allJobArr=arr; 
    
    if (loadingMoreSign==YES) {
        
        UIView *footerV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        footerV.backgroundColor=[UIColor whiteColor];
        
        UIActivityIndicatorView *actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        actInd.frame=CGRectMake(113, 5, 20, 20);
        actInd.tag=1002;
        [actInd startAnimating];
        [footerV addSubview:actInd];
        
        self.loadMoreLa=[[UILabel alloc]initWithFrame:CGRectMake(141, 5, 71, 20)];
        self.loadMoreLa.text=@"加载中...";
        self.loadMoreLa.backgroundColor=[UIColor clearColor];
        self.loadMoreLa.textAlignment=UITextAlignmentCenter;
        [footerV addSubview:self.loadMoreLa];
        [self.loadMoreLa release];
        self.tableView.tableFooterView=footerV;
        [footerV release];

    }

    [self.tableView reloadData];
     [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 列表视图处理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行高
{
    return 57;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allJobArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    A1ShowTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[A1ShowTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell.btn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //判断是否已被选择
    cell.btn.tag=indexPath.row;
    selectedSign=NO;
    if (selectArr.count!=0) {
        for (NSNumber *thisRow in selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sel"]];
                break;
            }
        }
    }
    if (selectedSign==NO) {
        cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Un sel"]]; 
    }
    A1Job *job=[self.allJobArr objectAtIndex:indexPath.row];
    cell.titleLa.text=job.jobTitle;
    cell.companyLa.text=job.companyName;
    cell.detaLa.text=job.openingDate;
    cell.addressLa.text=job.jobCity;
    return cell;
}





#pragma mark - 上拉加载更多

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    if (scrollView.contentOffset.y >0) {
//        //判断拖动距离 是否已经到达指定要求
//        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
//        if ((scrollPosition < 25)&&loadingMoreSign&&!LoadingSign)
//        {
//            [self loadMore];
//        }
//    }
//    
//}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self loadMore];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


-(void)loadMore
{
    _reloading = YES;
    LoadingSign=YES;
    count++;
    self.loadMoreLa.text=@"加载中...";
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMore:) name:@"更多搜索职位结果" object:nil];
    if (self.dataSourseSign==2)//高级搜索
    {
        [self.searchjob advancedSearchWith:count Pagesize:20];
    }
    if (self.dataSourseSign==3)//相似职位
    {
        [SearchJob alikeJob:self.jobNumber page:count pageSize:20];        
    }
}
-(void)doneLoadingTableViewData
{
   
}

-(void)receiveMore:(NSNotification *)not
{
   // int row=self.allJobArr.count;
    NSDictionary *dic=[not userInfo];
    NSMutableArray * arr=[dic objectForKey:@"arr"];
    int nu=arr.count;
    if (nu==20) {
        loadingMoreSign=YES;
    }
    else
    {
        loadingMoreSign=NO;
        self.loadMoreLa.text=@"";
        UIActivityIndicatorView *actv =(UIActivityIndicatorView *)[self.loadMoreLa.superview viewWithTag:1002];
        [actv stopAnimating];
    }
    if(nu!=0)
    {
        for (int i=0; i<nu; i++) {
            [self.allJobArr addObject:[arr objectAtIndex:i]];
    }
    [self.tableView beginUpdates];
    NSMutableArray *rowArr=[[NSMutableArray alloc]initWithCapacity:5];
    for (NSUInteger i=0; i<nu; i++) {//将要操作的行的坐标存进数组
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:0];  // 下拉刷新数据加在前边
		[rowArr addObject:indexPathToInsert];
	}
    [self.tableView insertRowsAtIndexPaths:rowArr withRowAnimation:UITableViewRowAnimationBottom];    
    [self.tableView endUpdates];
    [rowArr release];
    }
    LoadingSign=NO;
    _reloading = NO;
//    [_refreshHeaderView removeFromSuperview];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - 点选table行

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    A1ShowJob *showJobVC=[[A1ShowJob alloc]init];
    showJobVC.job=[self.allJobArr objectAtIndex:indexPath.row];
    showJobVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:showJobVC animated:YES];
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [showJobVC release];
}


#pragma mark - 批量选择点选时的操作

-(void)selectMore:(UIButton *)btn
{
    if (selectArr.count!=0) {
        for (NSNumber *thisRow in selectArr) {
            int a=[thisRow intValue];
            if (btn.tag==a) {
                [self.selectArr removeObject:thisRow];
                btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Un sel"]];
                return;
            }
        }
    }
    [self.selectArr addObject: [NSNumber numberWithInt:btn.tag]];
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sel"]];
}

-(void)apply//申请职位
{
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:10];
    for (NSNumber *n in self.selectArr) {
        int i=[n intValue];
        A1Job *job=[self.allJobArr objectAtIndex:i];
        [arr addObject:job.jobNumber];
    }
    //判断用户是否已经登陆
    IsLogin *logInFlag=[IsLogin defaultIsLogin];
    if(logInFlag.isLogin==YES)//如果用户已经 登陆
    {
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
    else //用户未登录
    {
        UIAlertView *unLogInAlert=[[UIAlertView alloc]initWithTitle:@"您尚未登陆" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil];
        unLogInAlert.tag=1;
        [unLogInAlert show];
        [unLogInAlert release];
    }
}

-(void)didSelected:(int)index
{
    switch (index) {
        case 0:
            //首页
        {
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case 1:
            //申请
        {
            [self apply];
        }
            break;
        case 2:{
            A1FilterTableVIewController * filter = [[A1FilterTableVIewController alloc] init];                
            filter.search = self.searchjob;
            filter.showtable=self;
            CATransition *animation = [CATransition animation];
            animation.duration = 0.25f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.fillMode = kCAFillModeForwards;
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromBottom;
            [self.navigationController pushViewController:filter animated:NO];
            [filter.navigationController.view.layer addAnimation:animation forKey:@"animation"];
            //筛选
            break;
        }
        case 3:
            //搜索器
            saveSearchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
            saveSearchView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
            [self.view addSubview:saveSearchView];
            UIView *newView=[[UIView alloc]initWithFrame:CGRectMake(15, 10, 290, 210)];
            newView.tag=1011;
            newView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"弹出视图背景1.png"]];
            [saveSearchView addSubview:newView];
            //
            UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 260, 25)];
            titleLab.layer.cornerRadius=10.0;
            titleLab.textAlignment=UITextAlignmentCenter;
            titleLab.clipsToBounds=YES;
            titleLab.text=@"职位搜索器";
            [titleLab setTextColor:[UIColor orangeColor]];
            [titleLab setBackgroundColor:[UIColor clearColor]];
            [newView addSubview:titleLab];
            [titleLab release];
            //
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, 100, 20)];
            [label setText:@"搜索条件"];
            [label setTextColor:[UIColor blackColor]];
            [label setBackgroundColor:[UIColor clearColor]];
            [newView addSubview:label];
            [label release];
            //
            textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 55, 260, 80)];
            textView.userInteractionEnabled=NO;
            textView.font=[UIFont systemFontOfSize:16];
            textView.textColor=[UIColor blackColor];
            textView.backgroundColor=[UIColor clearColor];
            [newView addSubview:textView];
            [textView setText:[SearchSavedArgument SearchSavedWithSchJobType:self.searchjob.schJobType industry:self.searchjob.industry city:self.searchjob.city keyWord:self.searchjob.keyWord dataRefresh:self.searchjob.dataRefresh eduLevel:self.searchjob.eduLevel workingexp:self.searchjob.workingExp companytype:self.searchjob.companyType companysize:self.searchjob.companySize salaryfrom:self.searchjob.salaryFrom salaryto:self.searchjob.salaryTo]];
            [textView release];
            //
            searchNameFid=[[UITextField alloc]initWithFrame:CGRectMake(30, 140, 260, 30)];
            [saveSearchView addSubview:searchNameFid];
            searchNameFid.placeholder=@"请在此输入搜索器名";
            [searchNameFid setBackgroundColor:[UIColor clearColor]];
            searchNameFid.textAlignment=UITextAlignmentCenter;
            searchNameFid.delegate=self;
            searchNameFid.borderStyle=UITextBorderStyleRoundedRect;
            [searchNameFid release];
            //
            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"button_bg_normal"] forState:UIControlStateNormal];
            btn1.layer.cornerRadius=8.0;
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.clipsToBounds=YES;
            [btn1 setFrame:CGRectMake(15, 175, 125, 30)];
            [btn1 addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setTitle:@"取消" forState:UIControlStateNormal];
            [newView addSubview:btn1];
            //
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setTitle:@"保存" forState:UIControlStateNormal];
            btn2.layer.cornerRadius=8.0;
            btn2.clipsToBounds=YES;
            [btn2 addTarget:self action:@selector(savedSearcher) forControlEvents:UIControlEventTouchUpInside];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"button_bg_normal"] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn2 setFrame:CGRectMake(150, 175, 125, 30)];
            [newView addSubview:btn2];

            break;
        default:
            break;
    }
    
}









@end
