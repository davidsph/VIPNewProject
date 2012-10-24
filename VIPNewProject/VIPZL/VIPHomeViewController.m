//
//  VIPHomeViewController.m
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPHomeViewController.h"
#import "VIPLoginViewController.h"
#import "VIPMyZhilianViewController.h"
#import "IsLogin.h"
#import "VIPSalarySearchViewController.h"
#import "VIPJobSearchViewController.h"
#import "LoginWithAccount.h"
#import "VIPChannelListViewController.h"
#import "VIPHelpViewController.h"
#import "A1FindJobViewController.h"

@implementation VIPHomeViewController
@synthesize myZhilian;

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
    //隐藏navgationcontroller
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTintColor:[UIColor brownColor]];
    self.navigationItem.title = @"智联招聘";
    //self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view from its nib.
    //自动登陆
    NSString *ac;
    NSString *pw;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self filePath]]) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:[self filePath]];
        ac = [arr objectAtIndex:0];
        pw = [arr objectAtIndex:1];
        LoginWithAccount *lgwac = [[LoginWithAccount alloc] init];
        [lgwac LoginWithAccount:ac passWord:pw];
    }
}

- (void)viewDidUnload
{
    [self setMyZhilian:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)searchPosition:(id)sender {
    NSLog(@"推出职位查询界面");
//    VIPJobSearchViewController *jbschVC = [[VIPJobSearchViewController alloc] init];
//    [self.navigationController pushViewController:jbschVC animated:YES];
//    [jbschVC release];
    A1FindJobViewController *findVC = [[A1FindJobViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
    [findVC release];
}
- (IBAction)myZhilian:(id)sender {
    
    //创建IsLogin单例，用里面的属性判断是否已经登陆
    IsLogin *islg = [IsLogin defaultIsLogin];
    NSLog(@"uticket = %@",islg.uticket);
    if (islg.isLogin == NO) {
        NSLog(@"推出我的登陆界面");
        VIPLoginViewController *login = [[VIPLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
    else
    {
        NSLog(@"推出我的智联界面");
        VIPMyZhilianViewController *myzlVC = [[VIPMyZhilianViewController alloc] init];
        myzlVC.rsmArray = [[NSArray alloc] initWithArray:islg.resumeArray];
        myzlVC.someNumber = [NSArray arrayWithObjects:islg.noReadEmailNumber,islg.applyCount,islg.favCount,islg.jobSearchCount, nil];
        [self.navigationController pushViewController:myzlVC animated:YES];
        [myzlVC release];
    }
    
}

- (IBAction)realTimeRecommend:(id)sender {
    NSLog(@"推出实时推荐界面");
}

- (IBAction)paymentSearch:(id)sender {
    
    NSLog(@"推出薪酬查询界面");
    VIPSalarySearchViewController *salaryController = [[VIPSalarySearchViewController alloc] init];
    [self.navigationController pushViewController:salaryController animated:YES];
    
    
    
    
}

- (IBAction)jobSeekerGuide:(id)sender {
    NSLog(@"推出求职指导界面");
    VIPChannelListViewController *chVC = [[VIPChannelListViewController alloc] init];
    [self.navigationController pushViewController:chVC animated:YES];
    [chVC release];
}

- (IBAction)zhilianHelp:(id)sender {
    NSLog(@"推出智联助手");
    VIPHelpViewController *helpVC = [[VIPHelpViewController alloc] init];
    [self.navigationController pushViewController:helpVC animated:YES];
    [helpVC release];
}

- (void)dealloc {
    [myZhilian release];
    [super dealloc];
}

- (NSString *)filePath
{
    //document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //具体文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"account"];
    return path;
}


@end
