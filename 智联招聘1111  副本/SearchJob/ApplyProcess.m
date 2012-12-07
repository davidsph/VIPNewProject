//
//  ApplyProcess.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ApplyProcess.h"
#import "LogInProcess.h"
#import "GDataXMLNode.h"

#import "A1SingleApplyProcess.h"
#import "A1MoreApplyProcess.h"

@implementation ApplyProcess

@synthesize applyDic;
@synthesize isSingleOrMore;



+(id)Apply
{
    ApplyProcess *aApply=[[ApplyProcess alloc]init];
    return [aApply autorelease];
}
//各种弹出窗口
//显示是否要提交默认简历的弹出框  下标102
-(void)displayIsDefaultSubmitAlert
{
//    NSLog(@"进行判断是否要提交默认简历(显示一个弹出框)");
    UIAlertView *isDefaultSubmitAlert =[[UIAlertView alloc]initWithTitle:@"是否提交默认简历" message:@"" delegate:self cancelButtonTitle:@"提交" otherButtonTitles:@"选择其它简历",nil];
    isDefaultSubmitAlert.tag=102;
    [isDefaultSubmitAlert show];
    [isDefaultSubmitAlert release];
}
//显示简历列表的弹出框 下标101
-(void)displayShowResumeList
{
    //先要对弄出来的数组进行处理在使用
    NSDictionary *dic=[LogInProcess logIn];
    NSArray *resumeNameArr=[dic objectForKey:@"resume_name"];
    NSMutableArray *resumeNameArr2=[[NSMutableArray alloc]init];
    for(GDataXMLElement *str in resumeNameArr)
    {
        [resumeNameArr2 addObject:[str stringValue]];
    }
    resumeNameArr=[NSArray arrayWithArray:resumeNameArr2];
    //处理完毕使用
    if([resumeNameArr count]==0)
    {
        UIAlertView *zeroAlert=[[UIAlertView alloc]init];
        zeroAlert.message=@"您还没有简历";
        [zeroAlert addButtonWithTitle:@"取消"];
        [zeroAlert show];
        [zeroAlert release];
    }
    else
    {
    UIAlertView *resumeListAlert=[[UIAlertView alloc]init];
    resumeListAlert.message=@"请选择您要投的简历";
    for(int i=0;i<[resumeNameArr count];i++)
    {
        [resumeListAlert addButtonWithTitle:[resumeNameArr objectAtIndex:i]];
    }
    resumeListAlert.tag=101;
    resumeListAlert.delegate=self;
    [resumeListAlert show];
    [resumeListAlert release];
    }
}
//申请必须执行的方法
-(void)methodOfApply
{
    if(applyDic!=nil)
    {
        NSLog(@"先要判断是否有默认简历");
        NSArray *isHaveDefaultResumeArray=[self.applyDic objectForKey:@"isdefaultflag"];
        int isHaveDefaultResume=0;
        for(GDataXMLElement *str in isHaveDefaultResumeArray)
        {
            if([[str stringValue]isEqualToString:@""])
            {
//                NSLog(@"空空空");
                isHaveDefaultResume=0;
            }
            else if([[str stringValue]isEqualToString:@"1"])
            {
                isHaveDefaultResume=1;
                break;
            }
            else if([[str stringValue]isEqualToString:@"0"])
            {
//                NSLog(@"空空空");
                isHaveDefaultResume=0;
            }
        }
        if(isHaveDefaultResume==0)
        {
//            NSLog(@"无默认简历显示简历列表");
            [self displayShowResumeList];
        }
        else
        {
//            NSLog(@"有默认简历选择是否提交默认简历");
            [self displayIsDefaultSubmitAlert];
        }
        isHaveDefaultResume=0;//还原回来
    }
    else
    {
//        NSLog(@"登录时失败了什么也不做");
    }
    self.isSingleOrMore=NO;
    
}

//UIAlertViewDelegate协议中的方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int selectedbuttonIndex=0;//该处变量用来记录在选择了第几个简历时的位置
    
    if(alertView.tag==102)//是否提交默认简历的窗口
    {
        if(buttonIndex==0)
        {
//            NSLog(@"提交默认简历");
            if(self.isSingleOrMore==NO)
            {
                [A1SingleApplyProcess A1SingleSubmitDefResWithDictionary:self.applyDic];
            }
            else
            {
                [A1MoreApplyProcess A1MoreSubmitDefResWithDictionary:self.applyDic];
            }
        }
        else
        {
//            NSLog(@"选择其他简历");
            [self displayShowResumeList];
        }
    }
    else if(alertView.tag==101)//简历列表窗口
    {
        //先要对弄出来的数组进行处理在使用
        NSDictionary *dic=[LogInProcess logIn];
        NSArray *resumeNameArr=[dic objectForKey:@"resume_name"];
        NSMutableArray *resumeNameArr2=[[NSMutableArray alloc]init];
        for(GDataXMLElement *str in resumeNameArr)
        {
//            NSLog(@"%@",[str stringValue]);
            [resumeNameArr2 addObject:[str stringValue]];
        }
        resumeNameArr=[NSArray arrayWithArray:resumeNameArr2];
        //处理完毕使用
        NSString *titleStr=[NSString stringWithFormat:@"您选择了+%@.是否将此简历设为默认简历,方便以后的申请.",[resumeNameArr objectAtIndex:buttonIndex]];
        selectedbuttonIndex=buttonIndex;
        UIAlertView *isDefaultAlert=[[UIAlertView alloc]initWithTitle:@"设置默认简历" message:titleStr delegate:self cancelButtonTitle:@"设为默认简历" otherButtonTitles:@"跳过", nil];
        isDefaultAlert.tag=103;
        [isDefaultAlert show];
        [isDefaultAlert release];
    }
    else if(alertView.tag==103)//是否设为默认简历的窗口
    {
        if(buttonIndex==0)//设为默认简历
        {
//            NSLog(@"设为默认简历 开始提交默认简历");
            if(self.isSingleOrMore==NO)
            {
                [A1SingleApplyProcess A1SingleSubmitNewDefResWithDictionary:self.applyDic andIndex:selectedbuttonIndex];
            }
            else
            {
                [A1MoreApplyProcess A1MoreSubmitNewDefResWithDictionary:self.applyDic andIndex:selectedbuttonIndex];
            }
            
        }
        else//不设置默认简历开始提交
        {
//            NSLog(@"不设置默认简历 开始提交普通简历");
            if(self.isSingleOrMore==NO)
            {
                [A1SingleApplyProcess A1SingleSubmitComResWithDictionary:self.applyDic andIndex:selectedbuttonIndex];
            }
            else
            {
                [A1MoreApplyProcess A1MoreSubmitComResWithDictionary:self.applyDic andIndex:selectedbuttonIndex];
            }
        }
    }
    else if(alertView.tag==104)
    {
        if(buttonIndex==0)
        {
//            NSLog(@"放弃");
        }
        else
        {
            [self methodOfApply];
        }
    }
}

-(void)isContinue
{
    //您是否要申请职位
    UIAlertView *isApplyAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"您是否要申请职位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
    isApplyAlert.tag=104;
    [isApplyAlert show];
    [isApplyAlert release];
  
}
// NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:uticketArray,@"uticket",resumeArray,@"resume",resumeIdArray,@"resume_id",resumeNumberArray,@"resume_number",resumeVersionNumberArray,@"version_number",resumeNameArray,@"resume_name",resumeIsDefaultArray,@"isdefaultflag", nil];
//ApplyProcessProtocol协议中的两个方法
-(void)singleApply:(NSArray *)jobExtIdArr;//单个申请方法(参数是 职位编号数组)
{
    //
    NSDictionary *dic1=[LogInProcess logIn];
    //将新的职位编号数组加入到字典中
    NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithDictionary:dic1];
    [dic2 setObject:jobExtIdArr forKey:@"Job_ext_id"];
    self.applyDic=[NSMutableDictionary dictionaryWithDictionary:dic2];
    
    [self isContinue];
    //扩充字典完毕
}
//ApplyProcessProtocol 协议中的方法
-(void)moreApply:(NSArray *)jobNumber;//多个申请方法(参数是 职位编号数组)
{
    [self singleApply:jobNumber];
    self.isSingleOrMore=YES;
}


@end
