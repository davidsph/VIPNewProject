//
//  LogInProcess.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LogInProcess.h"
#import "GDataXMLNode.h"
#import "DNWrapper.h"

//#import "LoginWithAccount.h"
//#import "IsLogin.h"

@implementation LogInProcess

+(NSDictionary *)logIn
{

//    LoginWithAccount *a=[[LoginWithAccount alloc]init];
//    NSLog(@"accounStr=%@",a.accountStr);
//    NSLog(@"passWord=%@",a.passwordStr);
    
//    IsLogin *logInFlag=[[IsLogin alloc]init];
//    NSLog(@"logInFlag.isLogin=%@",logInFlag.isLogin);
    
//    if(logInFlag.isLogin==YES)
//    {
//        NSLog(@"用户已登陆");
//        NSString *name=a.accountStr;
//        NSString *passwordStr=a.passwordStr;
        //在引入下边的代码
//    }
//    else 
//    {
//        NSLog(@"用户未登陆");
//    }
    
    
    
    NSString *name=@"lishaopeng881022@sohu.com";
    NSString *password=@"123456";
    name=[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    password=[password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *logInStr=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?loginname=%@&password=%@",name,password];
    NSString *logInStr1=[DNWrapper getMD5String:logInStr];
    
    NSURL *url=[NSURL URLWithString:logInStr1];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //采用同步
    NSURLResponse *respose=nil;
    NSError *error=nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&respose error:&error];
    NSString *receiveStr=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",receiveStr);
    //解析xml
    //解析XML,把结果放到Document中
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:receiveStr options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    //解析数据
    //获取是否成功登陆的信息
    NSArray *resultArray=[root nodesForXPath:@"//result" error:nil];
    //获取用户验证码uticket()
    NSArray *uticketArray1=[root nodesForXPath:@"//uticket" error:nil];
    NSMutableArray *uticketArray2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in uticketArray1)
    {
//        NSLog(@"%@",[str stringValue]);
        [uticketArray2 addObject:[str stringValue]];
    }
    NSArray *uticketArray=[NSArray arrayWithArray:uticketArray2];
    //获取简历所有信息，简历标题在第3位，默认简历在第4位，第0位是简历编号（对应简历名称），第1位是扩展编号，第2位是版本号。第5位是show count没用（浏览次数）
    NSArray *resumeArray=[root nodesForXPath:@"//resume" error:nil];
    //显示简历信息的
    for(GDataXMLElement *str in resumeArray)
    {
        NSLog(@"%@",[str stringValue]);
    }
    //只是用来记录各简历的Version版本号
    NSArray *resumeVersionNumberArray =[root nodesForXPath:@"//version_number" error:nil];
    //只是用来记录各简历的number扩展编号
    NSArray *resumeNumberArray =[root nodesForXPath:@"//resume_number" error:nil];
    //只是用来记录各简历的id简历编号
    NSArray *resumeIdArray =[root nodesForXPath:@"//resume_id" error:nil];
    //只是用来记录各简历的标题
    NSArray *resumeNameArray =[root nodesForXPath:@"//resume_name" error:nil];
    //这个用来判断是否存在默认简历
    NSArray  *resumeIsDefaultArray=[root nodesForXPath:@"//isdefaultflag" error:nil];
    int setDefResume=0;
    for(GDataXMLElement *str in resumeIsDefaultArray)
    {
        if([[str stringValue]isEqualToString:@""]||[[str stringValue]isEqualToString:@"0"])
        {
            setDefResume=0;
        }
        else if([[str stringValue]isEqualToString:@"1"])
        {
            setDefResume=1;
            break;
        }
    }
    //能够判断出是否有默认简历
//    NSLog(@"needsetdefresume=%d",setDefResume);
    //解析完
    NSString *result=[[resultArray objectAtIndex:0] stringValue];//取出来了
    if([result isEqualToString:@"1"])
    {
        NSLog(@"用户登录成功");
        NSMutableDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:uticketArray,@"uticket",resumeArray,@"resume",resumeIdArray,@"resume_id",resumeNumberArray,@"resume_number",resumeVersionNumberArray,@"version_number",resumeNameArray,@"resume_name",resumeIsDefaultArray,@"isdefaultflag", nil];
        return dic;
    }
    else
    {
        NSLog(@"用户登陆失败");
        return nil;
    }

}

@end
