//
//  DealWithNetworkAndXMLHelper.m
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "DealWithNetworkAndXMLHelper.h"
#import "LIistItemsForCompany.h"
#import "Resume.h"
#import "LIistItemsForCompany.h"
#import "IsLogin.h"
#import "DNWrapper.h"
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
@interface DealWithNetworkAndXMLHelper (network)


//得到xml文件
+(NSString *) getXMlStringFromNet:(Resume *) resume;

//解析XMl文件
+(NSMutableArray *) getCompanyListFromXML:(Resume *) resume;
@end

@implementation DealWithNetworkAndXMLHelper

//从网络获得数据
+(NSString *) getXMlStringFromNet:(Resume *) resume{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    IsLogin *login = [IsLogin defaultIsLogin];
    NSString *uTicket =login.uticket;
    NSString *resumeId = resume.rsmID;
    NSString *resumeNumber=resume.rsmNumber;
    NSString *versionNumber=resume.rsmVersion;
    
    
    NSMutableString * url =[[NSMutableString alloc] initWithString:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/getcompanylist_showresume.aspx?"];
    [url appendFormat:@"resume_id=%@&resume_number=%@&version_number=%@&uticket=%@",resumeId,resumeNumber,versionNumber,uTicket];
    
    NSString *getString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"苹果自带的编码 %@",getString);
    
    NSString *newString=[DNWrapper getMD5String:getString];
    
    
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:newString]];
    
    NSLog(@"编码之后的url = %@",newString);
    
    [newRequest startSynchronous];
    
    NSError *erroe= [newRequest error];
    
    NSString *reponse;
    
    if (!erroe) {
        
        reponse = [newRequest responseString];
        
        NSLog(@"接收到的数据为：%@",reponse);
        
    } else {
        
        NSLog(@"请求有错误");
    }
    
    
    return reponse;
    
}


+(NSMutableArray *) getCompanyListFromXML:(Resume *) resume{
     NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *xmlString =[[self getXMlStringFromNet:resume] retain];
    NSLog(@"传进来的xmlString =%@",xmlString);
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    GDataXMLElement *root = [doc rootElement];
    //打印几个孩子
    NSLog(@"root children=%d",[root childCount]);
    
    GDataXMLElement *firstElement =[[root children] objectAtIndex:0];
    
    int result =[[[[firstElement children] objectAtIndex:0] stringValue] intValue];
    
    NSLog(@"result = %d",result);
    
    //保存公司列表的数组
    NSMutableArray *companyList = nil;
    
    if (result==1) {
        NSLog(@"有数据，解析xml数据");
        
        companyList =[[NSMutableArray alloc] initWithCapacity:5];
        
        GDataXMLElement *jobListElement =[[root children] objectAtIndex:1];
        
        for(GDataXMLElement *jobItem in [jobListElement children])
        
        {
            NSString *companyNumber = [[[jobItem elementsForName:@"company_number"] objectAtIndex:0] stringValue];
            NSString *companyName = [[[jobItem elementsForName:@"company_name"] objectAtIndex:0] stringValue];
            NSString *companySize = [[[jobItem elementsForName:@"company_size"] objectAtIndex:0] stringValue];
            NSString *companyLocation = [[[jobItem elementsForName:@"resume_name"] objectAtIndex:0] stringValue];
            NSString *date_show = [[[jobItem elementsForName:@"date_show"] objectAtIndex:0] stringValue];
            
            
            
            NSLog(@"companyNumber =%@",companyNumber);
            
            
            LIistItemsForCompany *tmp =[[LIistItemsForCompany alloc] initCompanyNumber:companyNumber andCompamyName:companyName andCompanySize:companySize andCompany_location:companyLocation andDate_show:date_show];
            
            [companyList addObject:tmp];
            [tmp release];
        }
        
        
        NSLog(@"得到的公司列表数目为：%d",[companyList count]);
        
        
        
    }
    
    
    return [companyList autorelease];  
    
}

+(NSArray *) getCompanyList:(Resume *) resume{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    return [self getCompanyListFromXML:resume];
    
}



@end
