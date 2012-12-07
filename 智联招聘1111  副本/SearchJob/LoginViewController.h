//
//  LoginViewController.h
//  LogIn
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginWithAccount.h"

@protocol loginViewControllerProtocol <NSObject>
//定义一个协议，让我的智联主页实现协议方法，以实现简历数组的传值
- (void)getResumeArray2:(NSMutableArray *)arr;
@end

@interface LoginViewController : UIViewController<LoginWithAccountProtocol,UIAlertViewDelegate,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *account;//账户输入框
@property (retain, nonatomic) IBOutlet UITextField *passWord;//密码输入眶
@property (nonatomic,retain) NSMutableArray *resumeArr;//简历数组
@property (nonatomic,assign)id<loginViewControllerProtocol>delegate;//传简历的代理
@property (nonatomic,assign)int tag;//1我的智联用,2收藏职位用
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)Login:(id)sender;

- (IBAction)registers:(id)sender;
- (NSString *)filePath;
@end
