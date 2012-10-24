//
//  VIPLoginViewController.m
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPLoginViewController.h"
#import "LoginWithAccount.h"
#import "VIPFindViewController.h"
#import "VIPRegisterViewController.h"
#import "IsLogin.h"
#import "VIPMyZhilianViewController.h"

@implementation VIPLoginViewController
@synthesize imgView;
@synthesize accountTextField;
@synthesize passWordTextField;

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
    //添加向左手势返回上一个界面
    self.navigationItem.title = @"登陆界面";
    imgView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [imgView addGestureRecognizer:leftSwipe];
    
    //将密码显示星号
    passWordTextField.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setAccountTextField:nil];
    [self setPassWordTextField:nil];
    [self setImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)clickLogIn:(id)sender {
    //创建登陆实例，向服务器请求登陆
    LoginWithAccount *lwac = [[LoginWithAccount alloc] init];
    lwac.delegate = self;
    [lwac LoginWithAccount:accountTextField.text passWord:passWordTextField.text];
    [lwac release];
    IsLogin *islg = [IsLogin defaultIsLogin];
    if (islg.isLogin == YES) {
            NSLog(@"在登陆界面收到了成功的信息");
//            //属性传值，把简历，未读人事信息等传过来
//            self.resumeArr = [[NSMutableArray alloc] initWithCapacity:islg.resumeArray.count];
//            self.resumeArr = islg.resumeArray;
//            NSLog(@"传过来的简历有%d个",_resumeArr.count);
            
            //推出主界面
            VIPMyZhilianViewController *myzlvc = [[VIPMyZhilianViewController alloc] init];
            myzlvc.rsmArray = [[NSArray alloc] initWithArray:islg.resumeArray];
            myzlvc.someNumber = [NSArray arrayWithObjects:islg.noReadEmailNumber,islg.applyCount,islg.favCount,islg.jobSearchCount, nil];
            [self.navigationController pushViewController:myzlvc animated:YES];
            [myzlvc release];
        }
        else
        {
            NSLog(@"登陆失败，不推出新界面，加个layer提示一下。");
        }


}

- (IBAction)clickRegister:(id)sender {
    NSLog(@"点击了注册按钮");
    VIPRegisterViewController *regVC = [[VIPRegisterViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
    [regVC release];
}

//向左轻扫
- (void)leftSwipe
{
    [self.navigationController popViewControllerAnimated:YES];
}
//实现代理的方法

//当登陆失败时候的方法
- (void)sentError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"找回密码", nil];
    [self.view addSubview:alert];
    [alert show];
    [alert release];
}
//AlertView代理方法，找回密码用。
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"点击了找回密码");
        VIPFindViewController *findpwVC = [[VIPFindViewController alloc] init];
        [self.navigationController pushViewController:findpwVC animated:YES];
        [findpwVC release];
    }
}

- (void)dealloc {
    [accountTextField release];
    [passWordTextField release];
    [imgView release];
    [super dealloc];
}
@end
