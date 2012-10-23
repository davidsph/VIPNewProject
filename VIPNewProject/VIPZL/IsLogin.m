//
//  IsLogin.m
//  LogIn
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//  edit by taocy at 20121022/4:22

//  edit by taocy ...


// test edit 2012  by djy
// delete all by default daijunyou 2012


// add something more

#import "IsLogin.h"

@implementation IsLogin
@synthesize isLogin = _isLogin,uticket = _uticketm,resumeArray = _resumeArray,noReadEmailNumber = _noReadEmailNumber,applyCount = _applyCount,favCount = _favCount,jobSearchCount = _jobSearchCount;

- (id)setValue:(BOOL)isLogin1 utkt:(NSString *)utkt rsmArray:(NSMutableArray *)rsmArr nrdEmal:(NSString *)nrdEmail aplct:(NSString *)aplct favct:(NSString *)favct jbsc:(NSString *)jbsc
{
    self = [super init];
    if (self) {
        self.isLogin = isLogin1;
        if (_isLogin == YES) {
            self.uticket = utkt;
            self.resumeArray = rsmArr;
            self.noReadEmailNumber = nrdEmail;
            self.applyCount = aplct;
            self.favCount = favct;
            self.jobSearchCount = jbsc;
        }
        else
        {
            self.uticket = nil;
            self.resumeArray = nil;
            self.noReadEmailNumber = nil;
            self.applyCount = nil;
            self.favCount = nil;
            self.jobSearchCount = nil;
        }
    }
    return self;
}

+ (id)defaultIsLogin
{
    static IsLogin *sl = nil;
    if (sl == nil) {
        sl = [[IsLogin alloc] init];
    }
    return sl;
}
@end
