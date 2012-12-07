//
//  CompanyDetail.m
//  SearchJob
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompanyDetail.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"
#import "A1Job.h"


@implementation CompanyDetail

@synthesize receiveData,thisPage;
@synthesize companyNumber,companyName,companySize,companyProperty,industry,address,companyDesc,otherJobList;

-(id)initWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize//同步方法获取公司详情
{
    NSString *companyDetails=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/company/showcompanydetail.aspx?Company_number=%@&Page=%d&Pagesize=%d",aCompanyNumber,aPage,aPageSize];
    companyDesc=[DNWrapper getMD5String:companyDetails];
    
    
    NSURL *url=[[NSURL alloc]initWithString:companyDetails];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *receivedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    
    NSString *str=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    return  [CompanyDetail analysisStr:str toCompanyDetails:self];
}
+(void)GetCompanyDetailWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize//异步获取公司详情，获取方式接收名为“公司详情”的通知，从useinfo字典中读取“cd”对象，对象类型为“CompanyDetails”
{
    CompanyDetail *cd=[[[CompanyDetail alloc]init]autorelease];
    cd.otherJobList=[[NSMutableArray alloc]init];
    cd.thisPage=aPage;
    [cd GetCompanyDetailWithCompanyNumber:aCompanyNumber Page:aPage PageSize:aPageSize];
}


-(void)GetCompanyDetailWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize
{
    
    NSString *companyDetails=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/company/showcompanydetail.aspx?Company_number=%@&Page=%d&Pagesize=%d",aCompanyNumber,aPage,aPageSize];
    companyDesc=[DNWrapper getMD5String:companyDetails];
    NSURL *url=[[NSURL alloc]initWithString:companyDetails];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection;
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}
+(CompanyDetail *)analysisStr:(NSString *)str toCompanyDetails:(CompanyDetail *)CompanyDetails
{
    CompanyDetails.otherJobList=[[NSMutableArray alloc]init];
    
    
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    GDataXMLElement *result=[[root children]objectAtIndex:0];
    
    if ([[result stringValue]isEqualToString:@"1"]) {
        
               
        //公司详情
        GDataXMLElement *company=[[root children]objectAtIndex:1];        
        
        GDataXMLElement *company_number=[[company elementsForName:@"company_number"]objectAtIndex:0];        
        CompanyDetails.companyNumber=[company_number stringValue];         
        
        GDataXMLElement *company_name=[[company elementsForName:@"company_name"]objectAtIndex:0];        
        CompanyDetails.companyName=[company_name stringValue];  
        
        GDataXMLElement *company_size=[[company elementsForName:@"company_size"]objectAtIndex:0];        
        CompanyDetails.companySize=[company_size stringValue];
        
        GDataXMLElement *company_property=[[company elementsForName:@"company_property"]objectAtIndex:0];        
        CompanyDetails.companyProperty=[company_property stringValue];
        
        GDataXMLElement *industry=[[company elementsForName:@"industry"]objectAtIndex:0];        
        CompanyDetails.industry=[industry stringValue];
        
        GDataXMLElement *address=[[company elementsForName:@"address"]objectAtIndex:0];        
        CompanyDetails.address=[address stringValue];
        
        GDataXMLElement *company_desc=[[company elementsForName:@"company_desc"]objectAtIndex:0];        
        CompanyDetails.companyDesc=[company_desc stringValue];  
        
        
        
        //公司其他职位
        GDataXMLElement *jobList=[[root children]objectAtIndex:2]; 
        
        for (int i=0;i<[jobList childCount];i++) 
        {
            GDataXMLElement *job=[[jobList children]objectAtIndex:i];
            
            GDataXMLElement *jobnumber1=[[job elementsForName:@"job_number"]objectAtIndex:0];        
            NSString *jobNumber=[jobnumber1 stringValue];
            GDataXMLElement *jobtitle1=[[job elementsForName:@"job_title"]objectAtIndex:0];        
            NSString *jobTitle=[jobtitle1 stringValue];
            
            A1Job *aJob=[[A1Job alloc]initWithJobNumber:jobNumber JobTitle:jobTitle JobCity:nil JobCityRegion:nil];
            
            [CompanyDetails.otherJobList addObject:aJob];
        }
    }
    return CompanyDetails;

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData=[NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *str=[[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    CompanyDetail *cd=[[[CompanyDetail alloc]init]autorelease];
    cd=[CompanyDetail analysisStr:str toCompanyDetails:cd];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:cd,@"cd", nil];
    NSNotification *not=nil;
    if (self.thisPage>1) {
        not=[NSNotification notificationWithName:@"更多公司详情" object:self userInfo:dic];
    }
    else
    {
        not=[NSNotification notificationWithName:@"公司详情" object:self userInfo:dic];
    }
    [[NSNotificationCenter defaultCenter]postNotification:not];
    
}






@end
