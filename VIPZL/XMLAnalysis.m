//
//  XMLAnalysis.m
//  XMLAnalysis
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XMLAnalysis.h"
#import "GDataXMLNode.h"


@implementation XMLAnalysis

+(NSMutableArray*)XMLAnalysisProvince
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/city/firstLevel/item" error:nil];
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 
    return marr; 
}
+(NSMutableArray*)XMLAnalysisCity:(NSString*)city
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/city/firstLevel/item" error:nil];
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 
    
    
    for(int i=0;i<[marr count];i++)
    {
        NSMutableArray *marr1 = [[NSMutableArray alloc]initWithCapacity:10];
        if([city isEqualToString:@"无锡"])
    {
        [marr1 addObject:@"无锡"];
        return marr1;
    }
        
        if([city isEqualToString:@"宁波"])
        {
            [marr1 addObject:@"宁波"];
            return marr1;
        }
        
        if([city isEqualToString:[marr objectAtIndex:i]]==YES)
        {
            NSArray *arr1 = [root nodesForXPath:@"basedata/city/secondLevel/item" error:nil];
            //NSMutableArray *marr1 = [NSMutableArray arrayWithCapacity:10];
            
            for(int i=0;i<[arr1 count];i++)
            {
                if([[[arr1 objectAtIndex:i]stringValue]isEqualToString:city]==YES)
                {
                    for(int j = i;j<[arr1 count];j++)
                    {
                            [marr1 addObject:[[arr1 objectAtIndex:j]stringValue]];
                        //NSLog(@"%@",[marr1 lastObject]);
                        if([marr1 count]>=2)
                        {
                            NSLog(@"%d",j);
                            NSString *str = [[arr1 objectAtIndex:j]stringValue];
                            NSLog(@"%@",str);
                            NSString *str1 = [str stringByAppendingFormat:@","];
                            NSLog(@"%@",str1);
                            NSArray *array = [str1 componentsSeparatedByString:@","];
                            NSLog(@"%@",[array objectAtIndex:0]);
                            
                            if([[array objectAtIndex:0]isEqual:city]==NO)
                            {
                                [marr1 removeLastObject];
                                return marr1;
                            }

                            
                        }
 
                    }
                }
            }
            return marr1;
            
            
        }
    }
    
    
    
    
    
}



+ (NSMutableArray*)XMLAnalysisJob
{
    
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/jobtype/item" error:nil];
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 
    return marr;

    
}

+ (NSMutableArray*)XMLAnalysisSmallJob:(NSString*)samllJob
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/jobtype/item" error:nil];
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 

    for(int i=0;i<[marr count];i++)
    {
    
    if([samllJob isEqualToString:[marr objectAtIndex:i]]==YES)
    {
        NSArray *arr1 = [root nodesForXPath:@"basedata/small_Job_type/item" error:nil];
        NSMutableArray *marr1 = [NSMutableArray arrayWithCapacity:10];

        for(int i=0;i<[arr1 count];i++)
        {
            if([[[arr1 objectAtIndex:i]stringValue]isEqualToString:samllJob]==YES)
            {
                for(int j = i;j<[arr1 count];j++)
                {
                [marr1 addObject:[[arr1 objectAtIndex:j]stringValue]];
                if([[[arr1 objectAtIndex:j]stringValue]isEqualToString:@"其他"]==YES)
                {
                    return marr1;
                }
                }
            }
        }

        
    }
    }
    
 

   
    return marr;
    
    
    
}

+(NSMutableArray*)XMLAnalysisIndustry
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/industry/item" error:nil] ;
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 

    return marr;
    
}

+(NSMutableArray*)XMLAnalysisPublishTime
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"今天",@"最近三天",@"最近一周",@"最近一个月", nil];
    return arr;
}
+(NSMutableArray*)XMLAnalysisWorkExperience
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"无经验",@"1年以下",@"1-3年",@"3-5年",@"5-10年",@"10年以上", nil];
    return arr;
}
+(NSMutableArray*)XMLAnalysisDegree
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"大专",@"本科",@"硕士",@"博士",@"MBA",@"EMBA",@"中专",@"高技",@"高中",@"初中",@"其他", nil];
    return arr;
}
+(NSMutableArray*)XMLAnalysisCompanyQuality
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"国企",@"外商独资",@"代表处",@"合资",@"民营",@"国家机关",@"其他",@"股份制企业",@"上市公司"@"事业单位", nil];
    return arr;
}
+(NSMutableArray*)XMLAnalysisCompanyScale
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"20人以下",@"20-99人",@"100-499人",@"500-999人",@"1000-9999人",@"10000人以上", nil];
    return arr;
}
+(NSMutableArray*)XMLAnalysismonthPay
{
    NSMutableArray *arr = [NSArray arrayWithObjects:@"不限",@"1000元/月以下",@"1000-2000元/月",@"2001-4000元/月",@"4001-6000元/月",@"6001-8000元/月",@"8001-10000元/月",@"10001-15000元/月",@"15000-25000元/月",@"25000元/月以上",@"面议", nil];
    return arr;
}


@end
