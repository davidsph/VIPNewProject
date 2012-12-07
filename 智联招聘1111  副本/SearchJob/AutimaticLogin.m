//
//  AutimaticLogin.m
//  LogIn
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutimaticLogin.h"
#import "LoginWithAccount.h"

@implementation AutimaticLogin

- (void)autimaticLogin
{
    NSString *ac;
    NSString *pw;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self filePath]]) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:[self filePath]];
        ac = [arr objectAtIndex:0];
        pw = [arr objectAtIndex:1];
    }  
    LoginWithAccount *lgcount = [[LoginWithAccount alloc] init];
    [lgcount LoginWithAccount:ac passWord:pw];
    [lgcount release];
}

- (NSString *)filePath
{
    //document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //具体文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"account"];
    return path;
}


@end
