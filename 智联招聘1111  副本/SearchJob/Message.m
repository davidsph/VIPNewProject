//
//  Message.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize subject,emailDate,emailNumber,companyName,companyNumber,isRead;
-(void)dealloc{
    [subject release];
    [emailNumber release];
    [emailDate release];
    [companyName release];
    [companyNumber release];
    [isRead release];
}
@end
