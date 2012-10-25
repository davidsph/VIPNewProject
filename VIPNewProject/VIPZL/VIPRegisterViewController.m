//
//  VIPRegisterViewController.m
//  VIPZL
//
//  Created by Ibokan on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPRegisterViewController.h"
#import "GDataXMLNode.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"
#import "RegisterScrollView.h"
#import "VIPFindViewController.h"
#import "LoginWithAccount.h"
#import "IsLogin.h"
#import "VIPMyZhilianViewController.h"

@implementation VIPRegisterViewController

@synthesize resumeArr = _resumeArr,tag = _tag;

-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];  
    [super dealloc];
}

//通知执行的方法
- (void)handleKeyboardWillHide:(NSNotification *)notification 
{
    if (doneInKeyboardButton.superview) 
    {
        [doneInKeyboardButton removeFromSuperview];
    }
    
}

- (void)handleKeyboardDidShow:(NSNotification *)notification  
{  
    
    
    
    
    
    // create custom button
    if (doneInKeyboardButton == nil) 
    {
        doneInKeyboardButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up.png"] forState:UIControlStateNormal];
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down.png"] forState:UIControlStateHighlighted];
        
        [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    
    
    
}  
//doneBtn的方法
-(void)finishAction
{
    [passTF becomeFirstResponder];
    
}
// 限制数字键盘的自定义按钮值出现在数字键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField != phoneTF)
    {
        
        if(doneInKeyboardButton)
        {
            
            [doneInKeyboardButton removeFromSuperview];
        }       
    }
    else
    { 
        
        if (!doneInKeyboardButton.superview)
        {
            
            
            [tempWindow addSubview:doneInKeyboardButton];
        }
        
    }
    return YES;
}

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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.navigationItem.title = @"新用户注册";
    self.tag = 1;
    
    UIImageView *groupImv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 308, 211)];
    [groupImv setImage:[UIImage imageNamed:@"registerBg.png"]];
    RegisterScrollView *SView = [[RegisterScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
    SView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home.jpg"]];
    SView.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
    self.view = SView;
    [SView release];
    [self.view addSubview:groupImv];
    [groupImv release];
    // textfield
    phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(90,79, 215, 31)];
    mailTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 27, 215, 31)];
    passTF = [[UITextField alloc] initWithFrame:CGRectMake(90, 131, 215, 31)];
    confirmTF = [[UITextField alloc] initWithFrame:CGRectMake(90,183, 215, 31)];
    phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    mailTF.borderStyle = UITextBorderStyleRoundedRect;
    passTF.borderStyle = UITextBorderStyleRoundedRect;
    confirmTF.borderStyle = UITextBorderStyleRoundedRect;
    //设置是否自动大写
    mailTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    confirmTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    //设置提示文字
    [phoneTF setPlaceholder:@"请输入手机号"];
    [mailTF setPlaceholder:@"请输入邮箱"];
    [passTF setPlaceholder:@"输入至少六位密码"];
    [confirmTF setPlaceholder:@"再次输入密码"];
    //设置键盘样式
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    mailTF.keyboardType = UIKeyboardTypeEmailAddress;
    
    //设置return键
    phoneTF.returnKeyType = UIReturnKeyNext;
    mailTF.returnKeyType = UIReturnKeyNext;
    passTF.returnKeyType = UIReturnKeyNext;
    confirmTF.returnKeyType = UIReturnKeyDone;
    
    //设置clearBtn
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    mailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    //设置代理
    phoneTF.delegate =self;
    mailTF.delegate = self;
    passTF.delegate =self;
    confirmTF.delegate = self;
    
    passTF.secureTextEntry = YES;
    confirmTF.secureTextEntry = YES;
    
    
    
    [self.view addSubview:phoneTF];
    [self.view addSubview:mailTF];
    [self.view addSubview:passTF];
    [self.view addSubview:confirmTF];
    [phoneTF release];
    [mailTF release];
    [passTF release];
    [confirmTF release];
    
    
    //添加button（注册，及已有用户）
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(40, 300, 100, 40);
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"loginNormal.png"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *existBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    existBtn.frame = CGRectMake(200, 300, 100, 40);
    [existBtn setBackgroundImage:[UIImage imageNamed:@"loginNormal.png"] forState:UIControlStateNormal];
    [existBtn setTitle:@"已有账户" forState:UIControlStateNormal];
    [existBtn addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerBtn];
    [self.view addSubview:existBtn];
    
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
//俩按钮的方法
//注册

-(void)signIn
{
    //判断每一个textfield输入的是否符合规范
    if (mailTF.text==nil||phoneTF.text.length!=11||passTF.text.length<6||confirmTF.text.length<6) 
    {
        NSLog(@"请完整输入数据");
        UIAlertView *judgeAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [judgeAlert show];
        [judgeAlert release];
    }
    else{
        NSString *mail = [NSString stringWithFormat:mailTF.text];
        NSString *phone = [NSString stringWithFormat:phoneTF.text];
        NSString *passWord = [NSString stringWithFormat:passTF.text];
        NSString *confirmWord = [NSString stringWithFormat:confirmTF.text];
        
        NSString *email = [NSString stringWithFormat:mail];
        BOOL isEmail = [email isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
        if (isEmail == NO)
        {
            UIAlertView *mailAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
            [mailAlert show];
            [mailAlert release];
            
        }
        else
        {
            
            
            
            if ([passWord isEqualToString:confirmWord]==NO)
            {
                UIAlertView *passAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认密码错误" delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
                [passAlert show];
                [passAlert release];
                
                
            }
            
            else
            {
                
                NSString *urlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/register.aspx?email=%@&password=%@&mobile=%@",mail,passWord,phone];
                NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSString *newStr = [self getMD5String:encodeStr];
                //设置访问的URl
                NSURL *url = [NSURL URLWithString:newStr];
                NSLog(@"%@",url);
                
                
                //创建请求
                NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
                //第三步，连接服务器
                NSURLResponse *response = nil;
                NSError *err = nil;
                NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                
                NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
                NSLog(@"%@",str);
                //把解析结果放进document
                GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
                GDataXMLElement *root = [document rootElement];//获得根节点
                
                
                NSArray *arr = [root nodesForXPath:@"//result" error:nil];
                for(GDataXMLElement *result in arr)
                {
                    NSString *resultStr = [result stringValue];
                    NSLog(@"resultStr = %@",resultStr);
                    //邮箱注册失败
                    if ([resultStr isEqualToString:@"0"]==YES)
                    {
                        UIAlertView *lastAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱已存在" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"重新注册", nil];
                        [lastAlert show];
                        
                        [lastAlert release];
                        
                    }
                    else
                    {
                        NSLog(@"注册成功");
                        LoginWithAccount *lgwc = [[LoginWithAccount alloc] init];
                        [lgwc LoginWithAccount:mailTF.text passWord:passTF.text];
                        
                        IsLogin *islg = [IsLogin defaultIsLogin];
                        NSLog(@"isLogin = %d",islg.isLogin);
                        NSLog(@"self.tag = %d",self.tag);
                        if (islg.isLogin == YES) {
                            if (self.tag == 1) {//如果是从我的智联打开登陆界面
                                NSLog(@"在登陆界面收到了成功的信息");
                                //属性传值，把简历，未读人事信息等传过来
                                self.resumeArr = [[NSMutableArray alloc] initWithCapacity:islg.resumeArray.count];
                                self.resumeArr = islg.resumeArray;
                                NSLog(@"传过来的简历有%d个",_resumeArr.count);
                                
                                //推出主界面
                                VIPMyZhilianViewController *a2myzlvc = [[VIPMyZhilianViewController alloc] init];
                                a2myzlvc.rsmArray = [[NSArray alloc] initWithArray:_resumeArr];
                                a2myzlvc.someNumber = [NSArray arrayWithObjects:islg.noReadEmailNumber,islg.applyCount,islg.favCount,islg.jobSearchCount, nil];
                                NSLog(@"推出主界面");
                                [self.navigationController pushViewController:a2myzlvc animated:YES];
                                [a2myzlvc release];
                            }
                            else
                            {
                                NSLog(@"登陆失败，不推出新界面，加个layer提示一下。");
                            }
                        }
                    }
                    
                }
                
                
                
            }
        }
    }
    
}
-(void)getBack
{
    NSLog(@"333333333");
    [self.navigationController popViewControllerAnimated:YES];
}

//设置url方法
- (NSString *) getMD5String:(NSString *)url {
	
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];
	
	NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];
	NSString *md5Result = [self md5:md5src];
	NSLog(@"md5:%@", md5Result);
	
	NSString *result = nil;
	if (NSNotFound == [url rangeOfString:@"?"].location) {
        //		result = [NSString stringWithFormat:@"?t=%@&e=%@", paramT, md5Result];
        result = [NSString stringWithFormat:@"%@?t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];
	}else {
        //		result = [NSString stringWithFormat:@"&t=%@&e=%@", paramT, md5Result];
        result = [NSString stringWithFormat:@"%@&t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];
	}
	
	return result;
	
}

-(NSString *)md5:(NSString *)str { 
    const char *cStr = [str UTF8String]; 
    unsigned char result[32]; 
    CC_MD5( cStr, strlen(cStr), result ); 
    return [NSString stringWithFormat: 
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7], 
            result[8], result[9], result[10], result[11], 
            result[12], result[13], result[14], result[15] 
            ]; 
}

//return键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == mailTF)
    {
        
        [phoneTF becomeFirstResponder];
    }
    else if(textField == passTF)
    {
        [confirmTF becomeFirstResponder];
    }
    else 
    {
        [textField resignFirstResponder];
    }
    
    
    return YES;
    
}
//输入限制
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField == mailTF)
    {
        
        //判断是否是邮箱格式
        NSString *email = [NSString stringWithFormat:textField.text];
        NSLog(@"email = %@",email);
        BOOL isEmail = [email isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
        if ( [mailTF.text isEqualToString:@""]==NO && isEmail == NO)
        {
            doneAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱格式错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [doneAlert show];
            [doneAlert release];
            
            
        }
        
    }
    else if(textField ==phoneTF )
    {
        NSString *phone = [NSString stringWithFormat:textField.text];
        NSLog(@"phone=%@",phone);
        NSLog(@"%d",phone.length);
        if (phone.length != 11 && [phoneTF.text isEqualToString:@""]==NO ) 
        {
            doneAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [doneAlert show];
            [doneAlert release];
            
            
        }
        
    }
    else if(textField == passTF  )
    {
        NSLog(@"pass =  %@",passTF.text);
        if (textField.text.length<6 && passTF.text !=nil) {
            
            doneAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入至少六位密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [doneAlert show];
            [doneAlert release];
            
            
        }
    }
    
    //   [self performSelector:@selector(performDismiss) withObject:nil afterDelay:1.0f];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{ 
    
    
    if (buttonIndex == 0)
    {
        NSLog(@"重新登录呗");
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}


//输入限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneTF) //手机允许输入11个字符
    {
        if (range.location >=11)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    else if (textField == mailTF)
    {
        if (range.location >=255)
        {
            return NO;
        }
        else
        {
            return YES;
        }
        
    }
    else if (textField == passTF)
    {
        if (range.location >= 255)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        if (range.location >= 255)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
