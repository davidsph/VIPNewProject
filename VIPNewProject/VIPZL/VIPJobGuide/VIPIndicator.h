//
//  VIPIndicator.h
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIPIndicator : NSObject

//添加网络指示器
+ (void)addIndicator:(UIView *)view;
//移除网络指示器
+ (void)removeIndicator:(UIView *)view;

@end
