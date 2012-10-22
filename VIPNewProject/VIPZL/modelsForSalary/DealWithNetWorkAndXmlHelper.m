//
//  DealWithNetWorkAndXmlHelper.m
//  VIPZL
//
//  Created by david on 12-10-21.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "DealWithNetWorkAndXmlHelper.h"
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
@interface DealWithNetWorkAndXmlHelper (network)

//得到xml文件
+(NSString *) getXMlStringFromNet;

//解析XMl文件
+(NSMutableArray *) getItemsFromXML;

@end


@implementation DealWithNetWorkAndXmlHelper

//得到xml文件
+(NSString *) getXMlStringFromNet{
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *urlString = @"http://mobileinterface.zhaopin.com/iphone/payquery/querylist.service ";
    
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [newRequest startSynchronous];
    
    NSError *erroe= [newRequest error];
    
    NSString *reponse;
    
    if (!erroe) {
        NSLog(@"请求成功");
        reponse = [newRequest responseString];
        
    } else {
        
        NSLog(@"请求有错误");
    }
    
    
    return reponse;
    
    
}

//解析XMl文件
+(NSMutableArray *) getItemsFromXML{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    return nil;        
}


+ (NSMutableDictionary *) getItemsWthIndex:(int) index{
    
    NSString *xmlString = [self getXMlStringFromNet];
    
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    GDataXMLElement *root = [doc rootElement];
    //打印几个孩子
    NSLog(@"root children=%d",[root childCount]);
    
    GDataXMLElement *cityElement = [[root children] objectAtIndex:index];
    
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    for (GDataXMLElement  * cityItem in [cityElement children]) {
        
        NSString *cityId = [[[cityItem elementsForName:@"id"] objectAtIndex:0] stringValue];
        NSString *city = [[[cityItem elementsForName:@"name"] objectAtIndex:0] stringValue];
        
        
        [dictionary setObject:city forKey:cityId];
        
    }
    
    
    return [dictionary autorelease];
    
    
}



//获得城市列表
+ (NSMutableDictionary *) getCityItems{
    
    return  [self getItemsWthIndex:0]; 
    
}
//获得行业列表
+ (NSMutableDictionary *) getIndustryItems{
    
    
    return  [self getItemsWthIndex:5];
}
//获得学历列表
+ (NSMutableDictionary *) getEducationItems{
    
    return  [self getItemsWthIndex:2];
}
//获得公司性质列表
+ (NSMutableDictionary *) getCompanyTypeItems{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    return [self getItemsWthIndex:1];
    
}
//获得职业列表
+ (NSMutableDictionary *) getJobTypeItems{
    
    return  [self getItemsWthIndex:3];
}
//获得职位级别
+ (NSMutableDictionary *) getJobLevelItems{
    
    return [self getItemsWthIndex:4];
}

@end


//之前是想用单利传值 但是后来又发现了一个好方法 故此处 策略放在这里仅供留念
@implementation SaveItemsWithDictionary

+ (id) DefaultSaveItems{
    SaveItemsWithDictionary *saveSingle = nil;
    
    if (saveSingle==nil) {
        saveSingle = [[SaveItemsWithDictionary alloc] init];
    }
    
    return  saveSingle;
    
}
@end
