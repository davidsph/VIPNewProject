//
//  A1MoreApply.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1MoreApply.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"
@implementation A1MoreApply

@synthesize receivedData;
@synthesize resultStr;
//接口要求的6个参数
@synthesize uticket;
@synthesize ResumeId;
@synthesize resumeNumber;
@synthesize VersionNumber;
@synthesize JobNumber;
@synthesize needSetDefResume;


+(id)A1MoreWithUticket:(NSString *)aUticket resumeid:(int)aResumeId resumeNumber:(NSString *)aResumeNumber VersionNumber:(int)aVersionNumber JobNumber:(NSString *)aJobNumber needSetDefResume:(int)aNeedSetDefResume;
{
    A1MoreApply *more=[[A1MoreApply alloc]init];
    more.uticket=aUticket;
    more.ResumeId=aResumeId;
    more.resumeNumber=[aResumeNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    more.VersionNumber=aVersionNumber;
    more.JobNumber=[aJobNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    more.needSetDefResume=aNeedSetDefResume;
    // 服务器地址
    NSString *serverStr=@"http://wapinterface.zhaopin.com/iphone/job/batchaddposition.aspx";
    NSString *serverStr1=[NSString stringWithFormat:@"%@?Resume_id=%d&Resume_number=%@&Version_number=%d&Job_number=%@&needSetDefResume=%d&uticket=%@",serverStr,more.ResumeId,more.resumeNumber,more.VersionNumber,more.JobNumber,more.needSetDefResume,more.uticket];
    NSString *serverStr2=[DNWrapper getMD5String:serverStr1];
//    NSLog(@"连接的服务器 %@",serverStr1);           
    NSURL *serverUrl=[NSURL URLWithString:serverStr2];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:serverUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];            
    //采用异步 连接服务器
    [NSURLConnection connectionWithRequest:request delegate:more];
    return nil;
}

//显示申请成功
-(void)showSuccess
{
    sucAlert=[[UIAlertView alloc]init];
    sucAlert.tag=2;
    sucAlert.message=@"申请成功，您可以进入我的智联查看申请过的职位";
    [sucAlert addButtonWithTitle:@"知道了"];
    [sucAlert show];
}
//显示申请失败
-(void)showFail
{
    failAlert=[[UIAlertView alloc]init];
    failAlert.tag=3;
    failAlert.message=@"申请失败";
    [failAlert addButtonWithTitle:@"取消"];
    [failAlert show];
}
//异步的时候用的
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData=[NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}
-(void)doSome
{
    //解析XML,把结果放到Document中
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:self.resultStr options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    //解析数据
    //获取是否成功登陆的信息
    NSArray *resultArray1=[root nodesForXPath:@"//finish" error:nil];
    NSMutableArray *resultArray2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resultArray1)
    {
        [resultArray2 addObject:[str stringValue]];
    }
    int result=[[resultArray2 objectAtIndex:0]intValue];
    if(result==1)
    {
        [self showSuccess];
    }
    else
    {
        [self showFail];
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{   
    self.resultStr=[[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    [self doSome];
}



@end
