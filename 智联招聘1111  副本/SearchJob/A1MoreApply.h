//
//  A1MoreApply.h
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A1MoreApply : NSObject<NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
    UIAlertView *sucAlert;//申请成功时弹出的
    UIAlertView *failAlert;//申请失败弹出的
}

@property(nonatomic,retain) NSMutableData *receivedData;//在异步的时候获取数据用的
@property(nonatomic,retain) NSString *resultStr;//处理结果的

//接口要求的6个参数都为必须
@property (nonatomic ,retain) NSString *uticket;//用户验证码
@property (nonatomic ,assign) int  ResumeId;//简历编号
@property (nonatomic ,retain) NSString *resumeNumber;//扩展编号
@property (nonatomic ,assign) int VersionNumber;//版本号
@property (nonatomic ,retain) NSString *JobNumber;//职位编号
@property (nonatomic ,assign) int needSetDefResume;//1表示需要将该简历设置成默认简历；0表示不设置.

+(id)A1MoreWithUticket:(NSString *)aUticket resumeid:(int)aResumeId resumeNumber:(NSString *)aResumeNumberArray VersionNumber:(int)aVersionNumber JobNumber:(NSString *)aJobNumber needSetDefResume:(int)aNeedSetDefResume;

@end
