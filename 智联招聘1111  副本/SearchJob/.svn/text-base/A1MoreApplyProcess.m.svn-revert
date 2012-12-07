//
//  A1MoreApplyProcess.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1MoreApplyProcess.h"
#import "A1MoreApply.h"
#import "GDataXMLNode.h"

@implementation A1MoreApplyProcess

//字典的键值对
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:uticketArray,@"uticket",resumeArray,@"resume",resumeIdArray,@"resume_id",resumeNumberArray,@"resume_number",resumeVersionNumberArray,@"version_number",resumeNameArray,@"resume_name",resumeIsDefaultArray,@"isdefaultflag", nil];[dic2 setObject:jobExtIdArr forKey:@"Job_ext_id"];

//直接提交默认简历
+(id)A1MoreSubmitDefResWithDictionary:(NSMutableDictionary *)dictionary
{
    NSLog(@"直接提交默认简历");
    //查找默认简历的位置
    int defResPosition=0;
    //
    NSArray *isDefaultflagArr=[dictionary objectForKey:@"isdefaultflag"];
    for(GDataXMLElement *str in isDefaultflagArr)
    {  
        static int i=0;
        if([[str stringValue]isEqualToString:@""])
        {
            NSLog(@"nothing");
            i++;
        }
        else
        {
            defResPosition=i;
            break;
        }
    }
    //获取用户验证编码
    NSArray *uticketArr=[dictionary objectForKey:@"uticket"];
    NSString *uticket=[uticketArr objectAtIndex:0];
    NSLog(@"uticket=%@",uticket);
    //获取简历编号数组
    NSArray *resumeIdArr1=[dictionary objectForKey:@"resume_id"];
    //需要经过处理
    NSMutableArray *resumeIdArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeIdArr1)
    {
        [resumeIdArr2 addObject:[str stringValue]];
    }
    int resumr_id=[[resumeIdArr2 objectAtIndex:defResPosition]intValue];
    NSLog(@"resume_id=%d",resumr_id);
    //获取扩展编号
    NSArray *resumeNumberArr=[dictionary objectForKey:@"resume_number"];
    NSString *resume_number=[[resumeNumberArr objectAtIndex:defResPosition] stringValue];
    NSLog(@"resume_number=%@",resume_number);
    //获取简历版本号
    NSArray *resumeVersionNumberArr1=[dictionary objectForKey:@"version_number"];
    //需要经过处理
    NSMutableArray *resumeVersionNumberArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeVersionNumberArr1)
    {
        [resumeVersionNumberArr2 addObject:[str stringValue]];
    }
    int version_number=[[resumeVersionNumberArr2 objectAtIndex:defResPosition]intValue];
    NSLog(@"version_number=%d",version_number);
    //获取职位编号数组
    NSArray *resumeJobExtIdArr=[dictionary objectForKey:@"Job_ext_id"];
    NSMutableString *str1=[resumeJobExtIdArr objectAtIndex:0];
    for(int i=1;i<[resumeJobExtIdArr count];i++)
    {
        NSString *str2=[resumeJobExtIdArr objectAtIndex:1];
        [str1 stringByAppendingFormat:@",%@",str2];
    }
    NSString *Job_number=str1;
    //获取是否为默认简历是
    int needSetDefResume=1;
    NSString *resultString = [A1MoreApply A1MoreWithUticket:uticket resumeid:resumr_id resumeNumber:resume_number VersionNumber:version_number JobNumber:Job_number needSetDefResume:needSetDefResume];
    //再处理以下结果数据
    defResPosition=100;//返回原初
    return resultString;
    
}

//重新设为默认简历 并且提交默认简历的方法
+(id)A1MoreSubmitNewDefResWithDictionary:(NSMutableDictionary *)dictionary andIndex:(int )Index
{
    NSLog(@"A1方法重新设置默认简历再提交");
    //先把默认出needSetDefResume进行修改
    NSArray *resumeIsDefaultArr=[dictionary objectForKey:@"isdefaultflag"];
    int number=[resumeIsDefaultArr count];
    NSMutableArray *resumeIsdefaultArr1=[NSMutableArray arrayWithCapacity:1];
    for(int i=0;i<number;i++)
    {
        if(i==Index)
        {
            [resumeIsdefaultArr1 addObject:@"1"];
        }
        else
        {
            [resumeIsdefaultArr1 addObject:@"0"];
        }
    }
    NSArray *resumeIsdefauleArr2=[NSArray arrayWithArray:resumeIsdefaultArr1];
    [dictionary removeObjectForKey:@"isdefaultflag"];
    [dictionary setObject:resumeIsdefauleArr2 forKey:@"isdefaultflag"];
    //处理完毕
    //获取用户验证编码
    NSArray *uticketArr=[dictionary objectForKey:@"uticket"];
    NSString *uticket=[uticketArr objectAtIndex:0];
    NSLog(@"uticket=%@",uticket);
    //获取简历编号数组
    NSArray *resumeIdArr1=[dictionary objectForKey:@"resume_id"];
    //需要经过处理
    NSMutableArray *resumeIdArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeIdArr1)
    {
        [resumeIdArr2 addObject:[str stringValue]];
    }
    int resumr_id=[[resumeIdArr2 objectAtIndex:Index]intValue];
    NSLog(@"resume_id=%d",resumr_id);
    //获取扩展编号
    NSArray *resumeNumberArr=[dictionary objectForKey:@"resume_number"];
    NSString *resume_number=[[resumeNumberArr objectAtIndex:Index]stringValue];
    NSLog(@"resume_number=%@",resume_number);
    //获取简历版本号
    NSArray *resumeVersionNumberArr1=[dictionary objectForKey:@"version_number"];
    //需要经过处理
    NSMutableArray *resumeVersionNumberArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeVersionNumberArr1)
    {
        [resumeVersionNumberArr2 addObject:[str stringValue]];
    }
    int version_number=[[resumeVersionNumberArr2 objectAtIndex:Index]intValue];
    NSLog(@"version_number=%d",version_number);
    //获取职位编号数组
//    NSArray *resumeJobExtIdArr=[dictionary objectForKey:@"Job_ext_id"];
//    NSString *Job_number=[resumeJobExtIdArr objectAtIndex:0];
//    NSLog(@"Job_number=%@",Job_number);
    NSArray *resumeJobExtIdArr=[dictionary objectForKey:@"Job_ext_id"];
    NSMutableString *str1=[resumeJobExtIdArr objectAtIndex:0];
    for(int i=1;i<[resumeJobExtIdArr count];i++)
    {
        NSString *str2=[resumeJobExtIdArr objectAtIndex:1];
        [str1 stringByAppendingFormat:@",%@",str2];
    }
    NSString *Job_number=str1;
    //获取是否为默认简历是
    int needSetDefResume=1;
    NSString *resultString = [A1MoreApply A1MoreWithUticket:uticket resumeid:resumr_id resumeNumber:resume_number VersionNumber:version_number JobNumber:Job_number needSetDefResume:needSetDefResume];
    //再处理以下结果数据
    return resultString;


    
}

//不设为默认简历 并且提交普通简历的方法
+(id)A1MoreSubmitComResWithDictionary:(NSMutableDictionary *)dictionary andIndex:(int )Index
{
    NSLog(@"提交普通简历");
    //获取用户验证编码
    NSArray *uticketArr=[dictionary objectForKey:@"uticket"];
    NSString *uticket=[uticketArr objectAtIndex:0];
    NSLog(@"uticket=%@",uticket);
    //获取简历编号数组
    NSArray *resumeIdArr1=[dictionary objectForKey:@"resume_id"];
    //需要经过处理
    NSMutableArray *resumeIdArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeIdArr1)
    {
        [resumeIdArr2 addObject:[str stringValue]];
    }
    int resumr_id=[[resumeIdArr2 objectAtIndex:Index]intValue];
    NSLog(@"resume_id=%d",resumr_id);
    //获取扩展编号
    NSArray *resumeNumberArr=[dictionary objectForKey:@"resume_number"];
    NSString *resume_number=[[resumeNumberArr objectAtIndex:Index]stringValue];
    NSLog(@"resume_number=%@",resume_number);
    //获取简历版本号
    NSArray *resumeVersionNumberArr1=[dictionary objectForKey:@"version_number"];
    //需要经过处理
    NSMutableArray *resumeVersionNumberArr2=[NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *str in resumeVersionNumberArr1)
    {
        [resumeVersionNumberArr2 addObject:[str stringValue]];
    }
    int version_number=[[resumeVersionNumberArr2 objectAtIndex:Index]intValue];
    NSLog(@"version_number=%d",version_number);

    //获取职位编号数组
//    NSArray *resumeJobExtIdArr=[dictionary objectForKey:@"Job_ext_id"];
//    NSString *Job_number=[resumeJobExtIdArr objectAtIndex:0];
//    NSLog(@"Job_number=%@",Job_number);
    NSArray *resumeJobExtIdArr=[dictionary objectForKey:@"Job_ext_id"];
    NSMutableString *str1=[resumeJobExtIdArr objectAtIndex:0];
    for(int i=1;i<[resumeJobExtIdArr count];i++)
    {
        NSString *str2=[resumeJobExtIdArr objectAtIndex:1];
        [str1 stringByAppendingFormat:@",%@",str2];
    }
    NSString *Job_number=str1;
    //获取是否为默认简历是
    int needSetDefResume=0;
    NSString *resultString = [A1MoreApply A1MoreWithUticket:uticket resumeid:resumr_id resumeNumber:resume_number VersionNumber:version_number JobNumber:Job_number needSetDefResume:needSetDefResume];
    //再处理以下结果数据
    return resultString;
}

@end
