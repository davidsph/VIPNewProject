//
//  Position.m
//  SearchJob
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Position.h"

@implementation Position
@synthesize jobNumber,jobCity,jobTitle,applyCount,companyName,companyNumber;
-(void)dealloc{
    [jobCity release];
    [jobNumber release];
    [jobTitle release];
    [applyCount release];
    [companyName release];
    [companyNumber release];
}
@end
