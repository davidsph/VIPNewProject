//
//  ApplyProcess.h
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplyProcessProtocol.h"

@interface ApplyProcess : NSObject<UIAlertViewDelegate>


@property (nonatomic ,retain) NSMutableDictionary *applyDic;//其中包括所有要用的数据

@property (nonatomic ,assign) BOOL isSingleOrMore;//NO是single  YES是More

+(id)Apply;//初始化

//显示是否要提交默认简历的弹出框  下标102
-(void)displayIsDefaultSubmitAlert;

//显示简历列表的弹出框 下标101
-(void)displayShowResumeList;

@end
