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
+ (NSMutableArray *) getSalaryInfoFromXML:(NSString *) string;


@end


@implementation DealWithNetWorkAndXmlHelper



#pragma mark -
#pragma mark 解析xml数据 返回查询的薪酬信息  xml->>>>>>>>>查询到的薪酬数据
+ (NSMutableArray *) getSalaryInfoFromXML:(NSString *) string{
    
    
    NSMutableArray * array =[[NSMutableArray alloc] init];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:string]];
    [newRequest startSynchronous];
    
    NSError *erroe= [newRequest error];
    
    NSString *reponse;
    
    if (!erroe) {
        
        NSLog(@"请求成功");
        reponse = [newRequest responseString];
        NSLog(@"请求的数据为:%@",reponse);
        
        
        
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:reponse options:0 error:nil];
        
        GDataXMLElement *root = [doc rootElement];
        
        NSString *result =[[[[[root children] objectAtIndex:0] elementsForName:@"result"]  objectAtIndex:0] stringValue] ;
        
        NSLog(@"查询结果 result =%@",result);
        NSString *message = [[[root children] objectAtIndex:1] stringValue];
        NSLog(@"请求的message = %@",message);
        
        
        
        if ([result isEqualToString:@"0"]) {
            
            
          
            NSLog(@"查询出错"); 
            //发送服务器出错通知
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:message,ERRORMessage, nil];
            
            NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
            [center postNotificationName:ERRORRequestFORSALARYSearch object:self userInfo: dic];
            
            [dic release];
            
            return  nil;
                    
        } 
        else
        {
            //打印几个孩子
            NSLog(@"root children=%d",[root childCount]);
            
            NSString *low =[[[root nodesForXPath:@"//low" error:nil] objectAtIndex:0] stringValue];
            NSLog(@"low = %@",low);
            
            [array addObject:low];
            
            NSString *low_normal= [[[root nodesForXPath:@"//low-normal" error:nil] objectAtIndex:0] stringValue];
            NSLog(@"low_normal = %@",low_normal);
            [array addObject:low_normal];
            
            NSString *normal = [[[root nodesForXPath:@"//normal" error:nil] objectAtIndex:0] stringValue];
            NSLog(@"normal = %@",normal);
            [array addObject:normal];
            
            NSString *normal_high = [[[root nodesForXPath:@"//normal-high" error:nil] objectAtIndex:0] stringValue];
            NSLog(@"normal_high = %@",normal_high);
            
            [array addObject:normal_high];
            
            NSString *high = [[[root nodesForXPath:@"//high" error:nil] objectAtIndex:0] stringValue];
            NSLog(@"high = %@",high);
            [array addObject:high];
            
            
            NSLog(@"查询到的数据count =%d",[array count]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SUCCESSResultFORSALARYSearch object:self];
            
            
        }
        
        
    } else {
        
        NSLog(@"请求有错误");
        
        
        //发送服务器不响应通知
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:NETWORKERROR,ERRORMessage, nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ERRORRequest object:self userInfo:dict];
        
        [dict release];
        
        //发送服务器不响应通知
        return nil;

             
    }
    
    return  [array autorelease];
    
}



#pragma mark -
#pragma mark 查询薪酬信息 封装用户传进来的字典 >>>>>>url 
//根据查询条件 查询薪酬信息  返回的是 有顺序的 保存薪酬的数组
+(NSMutableArray *) getSalaryInfoFromNetWork:(NSMutableDictionary *) dictionary{
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"http://mobileinterface.zhaopin.com/iphone/payquery/query.service?"];
    NSArray *itemsKey = [[self getAllKeys] retain];
    [string appendFormat:@"%@=%d&",[itemsKey objectAtIndex:0],[[dictionary objectForKey:[itemsKey objectAtIndex:0]] intValue]];
    
    for (int i=1; i<7; i++) {
        [string appendFormat:@"%@=%@&",[itemsKey objectAtIndex:i],[dictionary objectForKey:[itemsKey objectAtIndex:i]]];
    }
    
    [string appendFormat:@"%@=%d",[itemsKey objectAtIndex:7],[[dictionary objectForKey:[itemsKey objectAtIndex:7]] intValue]];
    
    
    NSLog(@"拼接之后的网址 ：%@",string);
    
    
    return [self getSalaryInfoFromXML:string];   
    
}


#pragma mark -
#pragma mark 获得薪酬比较信息 解析xml 数据 返回 数组  xml----->>>>>薪酬数组
//从xml数据  解析薪酬比较数据
+ (NSMutableArray *) getSalaryComparingResultFromXMLString:(NSString *) urlString{
    
    
    NSMutableArray * array =[[NSMutableArray alloc] init];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    //发送请求
    [newRequest startSynchronous];
    
    NSError *erroe= [newRequest error];
    
    NSString *reponse;
    
    
    if (!erroe) {
        
        NSLog(@"请求成功");
        reponse = [newRequest responseString];
        NSLog(@"请求的数据为:%@",reponse);
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:reponse options:0 error:nil];
        
        GDataXMLElement *root = [doc rootElement];
        
        NSString *result =[[[root children] objectAtIndex:0] stringValue];
        
        NSString *message = [[[root children] objectAtIndex:1] stringValue];
        
        NSLog(@"查询结果 result =%@",result);
        
        NSLog(@"请求的message = %@",message);
        
        if ([result isEqualToString:@"0"]) {
            
            NSLog(@"查询出错"); 
            //发送服务器出错通知
            
            
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:message,ERRORMessage, nil];
            
            NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
            [center postNotificationName:ERRORRequest object:self userInfo: dic];
            
            [dic release];
            
            return nil;
            
            
        } 
        else
        {
            //打印几个孩子
            NSLog(@"root children=%d",[root childCount]);
            
            
            GDataXMLElement *compareResult =[[root children] objectAtIndex:5];
            
            
            NSLog(@"compareResult count = %d",[compareResult childCount]);
            NSString *low =[[[compareResult children] objectAtIndex:0] stringValue];            
            NSLog(@"low = %@",low);
            
            [array addObject:low];
            
            NSString *low_normal= [[[compareResult elementsForName:@"low-normal"] objectAtIndex:0] stringValue];
            NSLog(@"low_normal = %@",low_normal);
            [array addObject:low_normal];
            
            
            NSString *normal = [[[compareResult children] objectAtIndex:2]stringValue];          
            NSLog(@"normal = %@",normal);
            [array addObject:normal];
            
            NSString *normal_high = [[[compareResult children] objectAtIndex:3]  stringValue];
            NSLog(@"normal_high = %@",normal_high);
            
            [array addObject:normal_high];
            
            NSString *high = [[[compareResult children] objectAtIndex:4] stringValue];
            NSLog(@"high = %@",high);
            [array addObject:high];
            
            
            NSLog(@"查询到的数据count =%d",[array count]);
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SUCCESS object:self];
            
            
        }
        
        
    } else {
        
        NSLog(@"请求有错误");
        
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:NETWORKERROR,ERRORMessage, nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ERRORRequest object:self userInfo:dict];
        
        [dict release];
        
        //发送服务器不响应通知
        return nil;
    }
    
    return  [array autorelease];
    
    
}


#pragma mark -
#pragma mark 获得薪酬比较信息 封装用户选择的比较条件 >>>>url --->>>>xml

//根据比较条件 查询比较 薪酬比较结果 返回的是有顺序的 保存薪酬 的数组
+ (NSMutableArray *) getSalaryComparingResultFromNetwork:(NSMutableDictionary *) dictionary{
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"http://mobileinterface.zhaopin.com/iphone/payquery/comparequery.service?"];
    
    NSArray *itemsKey = [[self getAllKeys] retain];
    [string appendFormat:@"%@=%d&",[itemsKey objectAtIndex:0],[[dictionary objectForKey:[itemsKey objectAtIndex:0]] intValue]];
    
    for (int i=1; i<7; i++) {
        [string appendFormat:@"%@=%@&",[itemsKey objectAtIndex:i],[dictionary objectForKey:[itemsKey objectAtIndex:i]]];
    }
    
    [string appendFormat:@"%@=%d&",[itemsKey objectAtIndex:7],[[dictionary objectForKey:[itemsKey objectAtIndex:7]] intValue]];
    
    
    [string appendFormat:@"comparetype=%@&comparevalue=%@",[dictionary objectForKey:@"comparetype"],[dictionary objectForKey:@"comparevalue"]];
    
    
    
    NSLog(@"拼接之后的网址 ：%@",string);
    
    
    
    return [self getSalaryComparingResultFromXMLString:string];
}



#pragma mark -
#pragma mark 用户选择的 数据 封装成 数组形式 与服务器交互相关 >>>>>>>>>
+ (NSArray *) getAllKeys{
    
    NSArray *array2 = [[NSArray alloc] initWithObjects:@"experience",@"cityid",@"industryid",@"educationid",@"corppropertyid",@"jobcatid",@"joblevelid",@"salary",nil];
    
    return [array2 autorelease];
}

#pragma mark -
#pragma mark 薪酬比较的服务器信息
+ (NSArray *) getsaveallKeysArray{
    NSArray *array = [[NSArray alloc] initWithObjects:@"city", @"industry",@"corpproperty",@"jobcat",@"joblevel",@"educationid",nil];
    return  [array autorelease];
    
}
+(NSArray *) getsaveAllValuesArray{
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"地区",@"行业",@"企业性质",@"职位类型",@"职位级别",@"学历" ,nil];
    return [array autorelease];
    
    
}


+ (NSMutableDictionary *) getAllKeysForSalaryComparing{
    
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"地区" forKey:@"city"];
    [dictionary setObject:@"行业" forKey:@"industry"];
    [dictionary setObject:@"企业性质" forKey:@"corpproperty"];
    [dictionary setObject:@"职位类型" forKey:@"jobcat"];
    [dictionary setObject:@"职位类别" forKey:@"joblevel"];
    [dictionary setObject:@"学历" forKey:@"educationid"];
    
    return  [dictionary autorelease];
    
}

//从网络解析查询条件  城市 行业 等
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



#pragma mark -
#pragma mark 获得各个城市 列表

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
