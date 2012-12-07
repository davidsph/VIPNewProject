//
//  JobDetails.m
//  SearchJob
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JobDetails.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"
#import "A1Job.h"

@implementation JobDetails
@synthesize receiveData,thisPage;
@synthesize jobNumber,jobTitle,openingDate,jobCity,workingExp,salaryRange,number,responsibility,longitude,latitude,companyNumber,companyName,companySize,companyProperty,industry,address,companyDesc,otherJobList;


-(void)dealloc
{
    [self.receiveData release];
    [self.jobNumber release];//职位编号
    [self.jobTitle release];//职位名称
    [self.openingDate release];//发布日期
    [self.jobCity release];//发布城市
    [self.workingExp release];//经验需求
    [self.salaryRange release];//月薪
    [self.number release];//招聘人数
    [self.responsibility release];//职位描述
    [self.longitude release];//经度
    [self.latitude release];//纬度
    [self.companyNumber release];//公司编号
    [self.companyName release];//公司名称
    [self.companySize release];//公司规模
    [self.companyProperty release];//公司性质
    [self.industry release];//公司所属行业
    [self.address release];//公司地址
    [self.companyDesc release];//公司描述
    [self.otherJobList release];//公司其它职位列表
    [super dealloc];
}





-(id)initWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize//同步方法获取职位详情
{
    NSString *jobDetails=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx?Job_number=%@&Page=%d&Pagesize=%d",aJobNumber,aPage,aPageSize];
    jobDetails=[DNWrapper getMD5String:jobDetails];
    
    
    NSURL *url=[[NSURL alloc]initWithString:jobDetails];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *receivedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    
    NSString *str=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    return  [JobDetails analysisStr:str toJobDetails:self];
}



+(void)GetJobDetailWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize
{
    
    JobDetails *jd=[[[JobDetails alloc]init]autorelease];
    jd.otherJobList=[[NSMutableArray alloc]init];
    jd.thisPage=aPage;
    [jd GetJobDetailWithJobNumber:aJobNumber Page:aPage PageSize:aPageSize];
}

-(void)GetJobDetailWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize
{
    NSString *jobDetails=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx?Job_number=%@&Page=%d&Pagesize=%d",aJobNumber,aPage,aPageSize];
    jobDetails=[DNWrapper getMD5String:jobDetails];
    
    
    NSURL *url=[[NSURL alloc]initWithString:jobDetails];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
     [url release];
    NSURLConnection *connection;
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

+(JobDetails *)analysisStr:(NSString *)str toJobDetails:(JobDetails *)jobDetails
{
    jobDetails.otherJobList=[[NSMutableArray alloc]init];
    
    
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    GDataXMLElement *result=[[root children]objectAtIndex:0];

    if ([[result stringValue]isEqualToString:@"1"]) {
        
        //职位详情
        GDataXMLElement *currentJob=[[root children]objectAtIndex:1];
        
        GDataXMLElement *job_number=[[currentJob elementsForName:@"job_number"]objectAtIndex:0];        
        jobDetails.jobNumber=[job_number stringValue];
        
        GDataXMLElement *job_title=[[currentJob elementsForName:@"job_title"]objectAtIndex:0];        
        jobDetails.jobTitle=[job_title stringValue];
        
        GDataXMLElement *opening_date=[[currentJob elementsForName:@"opening_date"]objectAtIndex:0];        
        jobDetails.openingDate=[opening_date stringValue];
        
        GDataXMLElement *job_city=[[currentJob elementsForName:@"job_city"]objectAtIndex:0];        
        jobDetails.jobCity=[job_city stringValue];
        
        GDataXMLElement *working_exp=[[currentJob elementsForName:@"working_exp"]objectAtIndex:0];        
        jobDetails.workingExp=[working_exp stringValue];
        
        GDataXMLElement *salary_range=[[currentJob elementsForName:@"salary_range"]objectAtIndex:0];        
        jobDetails.salaryRange=[salary_range stringValue];
        
        GDataXMLElement *number=[[currentJob elementsForName:@"number"]objectAtIndex:0];        
        jobDetails.number=[number stringValue];
        
        GDataXMLElement *responsibilty=[[currentJob elementsForName:@"responsibilty"]objectAtIndex:0];        
        jobDetails.responsibility=[responsibilty stringValue];
        
        GDataXMLElement *longitude=[[currentJob elementsForName:@"longitude"]objectAtIndex:0];        
        jobDetails.longitude=[longitude stringValue];
        
        GDataXMLElement *latitude=[[currentJob elementsForName:@"latitude"]objectAtIndex:0];        
        jobDetails.latitude=[latitude stringValue];        
        
        
        
        //公司详情
        GDataXMLElement *company=[[root children]objectAtIndex:2];        
        
        GDataXMLElement *company_number=[[company elementsForName:@"company_number"]objectAtIndex:0];        
        jobDetails.companyNumber=[company_number stringValue];         
        
        GDataXMLElement *company_name=[[company elementsForName:@"company_name"]objectAtIndex:0];        
        jobDetails.companyName=[company_name stringValue];  
        
        GDataXMLElement *company_size=[[company elementsForName:@"company_size"]objectAtIndex:0];        
        jobDetails.companySize=[company_size stringValue];
        
        GDataXMLElement *company_property=[[company elementsForName:@"company_property"]objectAtIndex:0];        
        jobDetails.companyProperty=[company_property stringValue];
        
        GDataXMLElement *industry=[[company elementsForName:@"industry"]objectAtIndex:0];        
        jobDetails.industry=[industry stringValue];
        
        GDataXMLElement *address=[[company elementsForName:@"address"]objectAtIndex:0];        
        jobDetails.address=[address stringValue];
        
        GDataXMLElement *company_desc=[[company elementsForName:@"company_desc"]objectAtIndex:0];        
        jobDetails.companyDesc=[company_desc stringValue];  
        
    
        
        //公司其他职位
        GDataXMLElement *jobList=[[root children]objectAtIndex:3]; 
        
        for (int i=0;i<[jobList childCount];i++) 
        {
            GDataXMLElement *job=[[jobList children]objectAtIndex:i];
            
            GDataXMLElement *jobnumber1=[[job elementsForName:@"job_number"]objectAtIndex:0];        
            NSString *jobNumber=[jobnumber1 stringValue];
            GDataXMLElement *jobtitle1=[[job elementsForName:@"job_title"]objectAtIndex:0];        
            NSString *jobTitle=[jobtitle1 stringValue];
            GDataXMLElement *jobcity1=[[job elementsForName:@"job_city"]objectAtIndex:0];        
            NSString *jobcity=[jobcity1 stringValue];
            GDataXMLElement *job_city_region1=[[job elementsForName:@"job_city_region"]objectAtIndex:0];        
            NSString *jobCityRegion=[job_city_region1 stringValue];
            
            A1Job *aJob=[[A1Job alloc]initWithJobNumber:jobNumber JobTitle:jobTitle JobCity:jobcity JobCityRegion:jobCityRegion];
            [jobDetails.otherJobList addObject:aJob];
            [aJob release];
        }
    }
    return jobDetails;
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
     JobDetails *jd=[[JobDetails alloc]init];
    jd=[JobDetails analysisStr:str toJobDetails:jd];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:jd,@"jd", nil];
    [jd release];
    NSNotification *not=nil;
    if (self.thisPage>1) {
        not=[NSNotification notificationWithName:@"更多职位详情" object:self userInfo:dic];
    }
    else
    {
        not=[NSNotification notificationWithName:@"职位详情" object:self userInfo:dic];
    }
    [dic release];
    [[NSNotificationCenter defaultCenter]postNotification:not];
    
}



@end
