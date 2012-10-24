//
//  ApplyProcessProtocol.h
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApplyProcessProtocol <NSObject>

-(void)singleApply:(NSArray *)jobExtIdArr;//单个申请方法(参数是 职位编号数组)

-(void)moreApply:(NSArray *)jobNumber;//多个申请方法(参数是 职位编号数组)

@end
