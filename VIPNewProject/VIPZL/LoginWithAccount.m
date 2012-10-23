//
//  LoginWithAccount.m
//  LogIn
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginWithAccount.h"
#import "GDataXMLNode.h"
#import <CommonCrypto/CommonDigest.h>
#import "Resume.h"
#import "DNWrapper.h"
#import "IsLogin.h"

@implementation LoginWithAccount
@synthesize delegate = _delegate;

- (void)LoginWithAccount:(NSString *)accout passWord:(NSString *)passWord
{
    
    NSString *urlstr1 = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?loginname=%@&password=%@",accout,passWord];
    NSString *urlstr2 = [DNWrapper getMD5String:urlstr1];
    NSURL *url = [NSURL URLWithString:urlstr2];

    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
    //第三步， 连接服务器
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
   
    //讲网页内容获取放到document里面
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root = [document rootElement];//获得根节点

    NSArray *children = [root children];
    GDataXMLElement *resultValue = [children objectAtIndex:0];
    
    result = [resultValue stringValue];//验证登陆失败与否的属性
       
    //登陆成功
    if ([result isEqual:@"1"] == YES) {
        //如果登陆成功，将用户名和密码保存到本地以便下次自动登陆
        NSArray *accounts = [NSArray arrayWithObjects:accout,passWord, nil];
        [accounts writeToFile:[self filePath] atomically:YES];
        
        //把里面的各个参数信息解析出来
        //获取uticket参数
        GDataXMLElement *uticketValue = [children objectAtIndex:1];
        NSString *utckt = [uticketValue stringValue];
        
        //简历列表
        GDataXMLElement *resumeList = [children objectAtIndex:2];
        NSArray *resumeChildren = [resumeList children];
        int resumeCount = [resumeChildren count];
       
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:resumeCount];
        //遍历每一个简历，生成Resume类的对象，将每一个简历的名字，id,浏览数，等信息采集
        for (int i = 0; i<resumeCount; i++) {
            Resume *currentResume = [[Resume alloc] init];
            GDataXMLElement *aboutResume = [resumeChildren objectAtIndex:i];//取第i个简历
            NSArray *resumes = [aboutResume children];
            
            GDataXMLElement *resumeIDValue = [resumes objectAtIndex:0];
            currentResume.rsmID = [resumeIDValue stringValue];
            GDataXMLElement *resumeNumberValue = [resumes objectAtIndex:1];
            currentResume.rsmNumber = [resumeNumberValue stringValue];
            GDataXMLElement *resumeVersionValue = [resumes objectAtIndex:2];
            currentResume.rsmVersion = [resumeVersionValue stringValue];
            GDataXMLElement *resumeNameValue = [resumes objectAtIndex:3];
            currentResume.rsmName = [resumeNameValue stringValue];
            GDataXMLElement *languageValue = [resumes objectAtIndex:4];
            currentResume.rsmLanguage = [languageValue stringValue];
            GDataXMLElement *showCountValue = [resumes objectAtIndex:5];
            currentResume.rsmShowCount = [showCountValue stringValue];
            
            //放到数组里面
            [array addObject:currentResume];
        }
        GDataXMLElement *noReadEmalValue = [children objectAtIndex:3];
        GDataXMLElement *applyCountValue = [children objectAtIndex:4];
        GDataXMLElement *favCountValue = [children objectAtIndex:5];
        GDataXMLElement *jobSearchCountValue = [children objectAtIndex:6];
        NSLog(@"登陆成功");
        
        //登陆成功的isLogin单例
        IsLogin *islg = [IsLogin defaultIsLogin];
        [islg setValue:YES utkt:utckt rsmArray:array nrdEmal:[noReadEmalValue stringValue] aplct:[applyCountValue stringValue] favct:[favCountValue stringValue] jbsc:[jobSearchCountValue stringValue]];
        IsLogin *ll = [IsLogin defaultIsLogin];
        NSLog(@"单例单例单例单例：%d",ll.isLogin);
        NSLog(@"%@",islg);
    }
    
    //登陆失败
    else
    {
        
        NSLog(@"有错误,登陆失败");
        GDataXMLElement *error = [children objectAtIndex:1];
        NSLog(@"error = %@",[error stringValue]);
        
        IsLogin *islg = [IsLogin defaultIsLogin];
        [islg setValue:NO utkt:nil rsmArray:nil nrdEmal:nil aplct:nil favct:nil jbsc:nil];
        NSLog(@"%@",_delegate);
        if (_delegate!=nil && [_delegate respondsToSelector:@selector(sentError:)]) {
            NSLog(@"代理实现了吗？");
            [_delegate sentError:[error stringValue]];
        }
    }
}

//将用户名和密码存入本地文件以便自动登陆
//文件路径
- (NSString *)filePath
{
    //document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //具体文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"account"];
    return path;
}
@end
