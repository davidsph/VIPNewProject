//
//  SalarySearchInfoSingleton.m
//  VIPZL
//
//  Created by david on 12-10-21.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "SalarySearchInfoSingleton.h"

@implementation SalarySearchInfoSingleton

@synthesize experence;
@synthesize cityId;
@synthesize industryId;
@synthesize companyTypeId;
@synthesize jobTypeId;
@synthesize jobLevelId;
@synthesize salary;
@synthesize educationId;
+(id) DefaultSalarySearch{
    
    static SalarySearchInfoSingleton *single = nil;
    
    if (single == nil) {
        single = [[SalarySearchInfoSingleton alloc] init];
    }
    
    return single;
    
}



@end
