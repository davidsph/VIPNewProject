//
//  IsLogin.h
//  LogIn
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// test edit by taocy 2012/10/22

#import <Foundation/Foundation.h>

@interface IsLogin : NSObject

{
    BOOL _isLogin;
}
@property(nonatomic,assign)BOOL isLogin;//是否已经登陆
@property(nonatomic,retain)NSString *uticket;//uticket参数
@property(nonatomic,retain)NSMutableArray *resumeArray;//简历数组
@property(nonatomic,retain)NSString *noReadEmailNumber;//未读邮件数目
@property(nonatomic,retain)NSString *applyCount;//申请职位数
@property(nonatomic,retain)NSString *favCount;//收藏职位数
@property(nonatomic,retain)NSString *jobSearchCount;//工作搜索数目

- (id)setValue:(BOOL)isLogin1 utkt:(NSString *)utkt rsmArray:(NSMutableArray *)rsmArr nrdEmal:(NSString *)nrdEmail aplct:(NSString *)aplct favct:(NSString *)favct jbsc:(NSString *)jbsc;
+ (id)defaultIsLogin;//初始化参数为NO，表示没有登陆

@end
