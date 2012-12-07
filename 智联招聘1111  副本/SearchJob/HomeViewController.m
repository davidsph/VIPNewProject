//
//  HomeViewController.m
//  SearchAndSubscribe
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "PersonnelMessageViewController.h"
#import "Real_time_recommendViewController.h"
#import "SalaryQueryHome.h"
#import "JobGuidanceHomeVC.h"
#import "A1FindJobViewController.h"
#import "PersonnelMessageViewController.h"
#import "Position_recordViewController.h"
#import "LoginViewController.h"
#import "A2MyzlViewController.h"
#import "PositionFavoriteViewController.h"
#import "IsLogin.h"
#import "SearchJob.h"
#import "A1ShowTable.h"
@implementation HomeViewController

int flag = 10;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"智联招聘";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 50, 44);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.rightBarButtonItem=backBtn; 
    [backBtn release];
    
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(3, 5, 314, 40)]; //关键字搜索的创建
    searchBar.delegate = self;  // UISearchDelegate代理
    searchBar.tag = 1;
    searchBar.placeholder = @"请输入关键字进行职位搜索";
    [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    searchBar.backgroundColor = [UIColor clearColor]; // 背景设置
    searchBar.barStyle = UIBarStyleDefault;  //barStyle设置
    [self.view addSubview:searchBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeButton) name:@"zhuxiao" object:nil];
    
           
    // Do any additional setup after loading the view from its nib.
}
-(void)changeButton{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 50, 44);
    [btn setTitle:@"注销" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [btn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
}
//注销zhanghao
- (void)logOut
{
    IsLogin *islg = [IsLogin defaultIsLogin];
    [islg setValue:NO utkt:nil rsmArray:nil nrdEmal:nil aplct:nil favct:nil jbsc:nil];
    NSArray *accounts = [NSArray arrayWithObjects:@"",@"", nil];
    [accounts writeToFile:[self filePath] atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSString *)filePath
{
    //document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //具体文件路径
    NSString *path1 = [docPath stringByAppendingPathComponent:@"account"];
    return path1;
}
-(void)login
{
    LoginViewController *logVC=[[[LoginViewController alloc]init] autorelease];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:logVC];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:navigation animated:YES];
   
}
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)PushToSearchJob:(id)sender {
    A1FindJobViewController *findJobVC=[[[A1FindJobViewController alloc]init]autorelease];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:findJobVC];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:navigation animated:YES];
    
}

- (IBAction)PushToPersonMessage:(id)sender {
    IsLogin *islg = [IsLogin defaultIsLogin];
    
    if (islg.isLogin == YES){
        PersonnelMessageViewController *personMessageVC=[[[PersonnelMessageViewController alloc]init]autorelease];
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:personMessageVC];
        navigation.navigationBar.barStyle=UIBarStyleDefault;
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
        [self presentModalViewController:navigation animated:YES];
        
    }else{
        loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" 
                                                message:@"您尚未登录，无法查看来信" 
                                               delegate:self 
                                      cancelButtonTitle:@"放弃" 
                                      otherButtonTitles:@"登录", nil];
        [loginAlertV show];
        [activityV hidden];
    }
    
}

- (IBAction)PushToMyZhiLian:(id)sender
{
    IsLogin *islg = [IsLogin defaultIsLogin];
    if (islg.isLogin == YES){
        A2MyzlViewController *myZL=[[[A2MyzlViewController alloc]init]autorelease];
        
        myZL.rsmArray = [[NSArray alloc] initWithArray:islg.resumeArray];
        myZL.someNumber = [NSArray arrayWithObjects:islg.noReadEmailNumber,islg.applyCount,islg.favCount,islg.jobSearchCount, nil];
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:myZL];
        navigation.navigationBar.barStyle=UIBarStyleDefault;
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
        [self presentModalViewController:navigation animated:YES];
    }
    else{
        loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" 
                                                message:@"请登录" 
                                               delegate:self 
                                      cancelButtonTitle:@"放弃" 
                                      otherButtonTitles:@"登录", nil];
        [loginAlertV show];
        [activityV hidden];
    }
}


- (IBAction)PushToSalaryQuery:(id)sender {
    SalaryQueryHome *salaryHome=[[[SalaryQueryHome alloc]init] autorelease];
    
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:salaryHome];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
    
    [self presentModalViewController:navigation animated:YES];
}

- (IBAction)PushToJobGuide:(id)sender {
    JobGuidanceHomeVC *jobGuide=[[[JobGuidanceHomeVC alloc]init]autorelease];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:jobGuide];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
    [self presentModalViewController:navigation animated:YES];
    }

- (IBAction)PushToReal_time:(id)sender {
    Real_time_recommendViewController *real_time=[[[Real_time_recommendViewController alloc]init]autorelease];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:real_time];
    navigation.navigationBar.barStyle=UIBarStyleDefault;
    [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];    
    [self presentModalViewController:navigation animated:YES];
}

- (IBAction)PushToSetting:(id)sender {
    
}



- (IBAction)PushToFavicons:(id)sender {
    IsLogin *islg = [IsLogin defaultIsLogin];
    if (islg.isLogin == YES){
        PositionFavoriteViewController *position=[[[PositionFavoriteViewController alloc]init]autorelease];
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:position];
        navigation.navigationBar.barStyle=UIBarStyleDefault;
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];    
        [self presentModalViewController:navigation animated:YES];
    }else{
        loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" 
                                                message:@"请登录" 
                                               delegate:self 
                                      cancelButtonTitle:@"放弃" 
                                      otherButtonTitles:@"登录", nil];
        [loginAlertV show];
        [activityV hidden];
    }
        
    
    
}

- (IBAction)PushToRecord:(id)sender {
    IsLogin *islg = [IsLogin defaultIsLogin];
    if (islg.isLogin == YES){
        Position_recordViewController *position=[[[Position_recordViewController alloc]init]autorelease];
      //  position.mm = flag;
        UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:position];
        navigation.navigationBar.barStyle=UIBarStyleDefault;
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];    
        [self presentModalViewController:navigation animated:YES];
    }else{
        loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" 
                                                message:@"请登录" 
                                               delegate:self 
                                      cancelButtonTitle:@"放弃" 
                                      otherButtonTitles:@"登录", nil];
        [loginAlertV show];
        [activityV hidden];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//警示框的按钮触发方法
{      
    if (alertView == loginAlertV)//如果是登录警示框 
    {  
        if(buttonIndex == 0) 
        {
            //[loginAlertV dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissModalViewControllerAnimated:YES];
        }
        if(buttonIndex == 1)
        {
            LoginViewController *loginVC = [[[LoginViewController alloc]init]autorelease];
            loginVC.tag = 5;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
} 
- (void)dealloc {
    
    [super dealloc];
}

#pragma mark searchBar 代理
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar;
{
    //键盘消失
    [searchbar resignFirstResponder];
    
    SearchJob * seachJob = [[SearchJob alloc] initWithType:1 schJobType:nil subJobType:005 industry:nil city:nil keyWord:searchbar.text dataRefresh:5 eduLevel:2 jobLocation:nil pointRanger:nil workingExp:nil companyType:nil companySize:nil emplType:nil salaryFrom:1000 salaryTo:100000 sort:nil date:nil]; // 数据的初始化
    
    
    A1ShowTable *vc=[[A1ShowTable alloc]init]; // 点击搜索按钮以后要进去的页面
    vc.searchjob=seachJob; // 两个界面之间用代理进行传值
    vc.dataSourseSign=2;   // 搜索的标记位
    vc.hidesBottomBarWhenPushed=YES;  // 隐藏最下边的tabar的标记为
    [self.navigationController pushViewController:vc animated:YES]; // 推进到下一个页面
	
    
}

@end
