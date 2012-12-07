//
//  SearchSavedArgument.m
//  searchSave
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchSavedArgument.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"
@implementation SearchSavedArgument
@synthesize receivedData;

@synthesize uticket;
@synthesize type;
@synthesize schJobType;
@synthesize industry;
@synthesize city;
@synthesize keyWord;
@synthesize dataRefresh;
@synthesize eduLevel;
@synthesize companytype;
@synthesize companysize;
@synthesize salaryfrom;
@synthesize salaryto;
@synthesize searchName;
@synthesize emplType;
@synthesize workingexp;

//快速搜索的方法
+(id)SearchSavedWithUticket:(NSString *)aUticket 
                 schJobType:(NSString *)aSchJobType 
                   industry:(NSString *)aIndustry 
                       city:(NSString *)aCity
                    keyWord:(NSString *)aKeyWoard
{
    return nil;
}
//NSURLConnectionDatadelegate的协议方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"错误的原因！");
    NSLog(@"%@",[error localizedDescription]);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData=[NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr=[[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    //数据处理
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:receiveStr options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    NSArray *chlidren=[root children];
    GDataXMLElement *channelName = [chlidren objectAtIndex:0];
    NSString *RESULT=[channelName stringValue];
//    NSLog(@"result=%@",RESULT);
    if([RESULT isEqualToString:@"1"])
    {
        NSLog(@"搜索器保存成功");
        UIAlertView *sucAlert=[[UIAlertView alloc]init];
        sucAlert.message=@"搜索器保存成功!";
        [sucAlert addButtonWithTitle:@"确定"];
        [sucAlert show];
        [sucAlert release];
    }
    else
    {
        NSLog(@"搜索器保存失败");
        UIAlertView *faiAlert=[[UIAlertView alloc]init];
        faiAlert.message=@"搜索器保存失败";
        [faiAlert addButtonWithTitle:@"取消"];
        [faiAlert show];
        [faiAlert release];
    }
    
}
//高级搜素的方法
+(id)SearchSavedWithUticket:(NSString *)aUticket 
                 schJobType:(NSString *)aSchJobType 
                   industry:(NSString *)aIndustry 
                       city:(NSString *)aCity 
                    keyWord:(NSString *)aKeyWoard
                dataRefresh:(int)aDataRefresh 
                   eduLevel:(int)aEduLevel 
                 workingexp:(NSString *)aWorkingexp 
                companytype:(NSString *)aCompanytype 
                companysize:(NSString *)aCompanysize
                 salaryfrom:(int)aSalaryfrom
                   salaryto:(int)aSalaryto 
                 searchName:(NSString *)aSearchName
{
//    NSLog(@"高级搜索 保存搜索器");
    
    SearchSavedArgument *s=[[[SearchSavedArgument alloc]init]autorelease];
    s.uticket=aUticket;
    s.schJobType=[aSchJobType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.industry=[aIndustry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.city=[aCity stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.keyWord=[aKeyWoard stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.dataRefresh=aDataRefresh;
    s.eduLevel=aEduLevel;
    s.workingexp=[aWorkingexp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.companytype=[aCompanytype stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.companysize=[aCompanysize stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    s.salaryfrom=aSalaryfrom;
    s.salaryto=aSalaryto;
    s.searchName=[aSearchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //先对所有数据处理一下
    //
    NSMutableString *returnStr=[NSMutableString stringWithString:@""];
    if(s.schJobType!=nil)
    {
        [returnStr appendFormat:@"&schJobType=%@",s.schJobType];
    }
    if(s.industry!=nil)
    {
        [returnStr appendFormat:@"&industry=%@",s.industry];
    }
    if(s.city!=nil)
    {
        [returnStr appendFormat:@"&city=%@",s.city];
    }
    if(s.keyWord!=nil)
    {
        [returnStr appendFormat:@"&key_word=%@",s.keyWord];
    }
    if(s.dataRefresh!=0)
    {
        [returnStr appendFormat:@"&data_refresh=%d",s.dataRefresh];
    }
    if(s.eduLevel!=0)
    {
        [returnStr appendFormat:@"&edu_level=%d",s.eduLevel];
    }
    if(s.workingexp!=nil)
    {
        [returnStr appendFormat:@"&Workingexp=%@",s.workingexp];
    }
    if(s.companytype!=nil)
    {
        [returnStr appendFormat:@"&companytype=%@",s.companytype];
    }
    if(s.companysize!=nil)
    {
        [returnStr appendFormat:@"&companysize=%@",s.companysize];
    }

    if(s.salaryfrom!=0)
    {
        [returnStr appendFormat:@"&salaryfrom=%d",s.salaryfrom];
    }
   if(s.salaryto!=0)
   {
       [returnStr appendFormat:@"&salaryto=%d",s.salaryto];
   }
    [returnStr appendFormat:@"&searcher_name=%@",s.searchName];
    [returnStr appendFormat:@"&uticket=%@",s.uticket];
//    NSLog(@"uticket=%@",s.uticket);
    
    //服务器地址：http://wapinterface.zhaopin.com/iphone/search/saveresult.aspx
    NSString *serverStr=[NSString stringWithString:@"http://wapinterface.zhaopin.com/iphone/search/saveresult.aspx"];
    NSString *resultString=[NSString stringWithFormat:@"%@?%@",serverStr,returnStr];
    NSString *urlStr=[DNWrapper getMD5String:resultString];
//    NSLog(@"urlStr=%@",urlStr);
    NSURL *url=[NSURL URLWithString:urlStr];
    //第二步 ，创建请求
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //连接服务器
    [NSURLConnection connectionWithRequest:request delegate:s];
    return nil;
}
//返回字符串在显示框显示的
+(id)SearchSavedWithSchJobType:(NSString *)aSchJobType 
                      industry:(NSString *)aIndustry 
                          city:(NSString *)aCity 
                       keyWord:(NSString *)aKeyWoard
                   dataRefresh:(int)aDataRefresh 
                      eduLevel:(int)aEduLevel 
                    workingexp:(NSString *)aWorkingexp 
                   companytype:(NSString *)aCompanytype 
                   companysize:(NSString *)aCompanysize
                    salaryfrom:(int)aSalaryfrom
                      salaryto:(int)aSalaryto
{
    SearchSavedArgument *s=[[[SearchSavedArgument alloc]init]autorelease];
    s.schJobType=aSchJobType;
    s.industry=aIndustry;
    s.city=aCity;
    s.keyWord=aKeyWoard;
    s.dataRefresh=aDataRefresh;
    s.eduLevel=aEduLevel;
    s.workingexp=aWorkingexp;
    s.companytype=aCompanytype;
    s.companysize=aCompanysize;
    s.salaryfrom=aSalaryfrom;
    s.salaryto=aSalaryto;
    
    NSMutableString *returnStr=[NSMutableString stringWithString:@""];
    if(s.schJobType!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendString:s.schJobType];
    }
    if(s.industry!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }        
        [returnStr appendString:s.industry];
    }
    if(s.city!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendString:s.city];
    }
    if(s.keyWord!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendString:s.keyWord];
    }
    if(s.dataRefresh!=0)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendFormat:@"发布时间:最近%d天",s.dataRefresh];
    }
    if(s.eduLevel!=0)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendFormat:@"学历:%d年",s.eduLevel];
    }
    if(s.workingexp!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendFormat:@"经验:%@",s.workingexp];
    }
    if(s.companytype!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendString:s.companytype];
    }
    if(s.companysize!=nil)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendFormat:@"%@",s.companysize];
    }
    if(s.salaryfrom!=0)
    {
        if(![returnStr isEqualToString:@""])
        {
            [returnStr appendString:@"+"];
        }
        [returnStr appendFormat:@"%d",s.salaryfrom];
        
         if(s.salaryto!=0)
         {
             [returnStr appendFormat:@"~%d人民币",s.salaryto];
         }
    }
    else
    {
        if(s.salaryto!=0)
        {
            [returnStr appendFormat:@"%d人民币",s.salaryto];
        }
    }
    
    return returnStr;
}

@end
