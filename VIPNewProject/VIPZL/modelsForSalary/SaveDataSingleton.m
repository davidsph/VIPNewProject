//
//  SaveDataSingleton.m
//  VIPZL
//
//  Created by david on 12-10-22.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "SaveDataSingleton.h"

@implementation SaveDataSingleton

@synthesize cityItemDictionary;
@synthesize IndustryItemsDictionary;
@synthesize EducationItemsDictionary;
@synthesize CompanyTypeItemsDictionary;
@synthesize JobTypeItemsDictionary;
@synthesize JobLevelItemsDictionary;

- (id) init{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self = [super init];
    if (self) {
        
        cityItemDictionary = [[NSMutableDictionary alloc] init];
        IndustryItemsDictionary = [[NSMutableDictionary alloc] init];
        EducationItemsDictionary = [[NSMutableDictionary alloc] init];
        CompanyTypeItemsDictionary =[[NSMutableDictionary alloc] init];
        JobTypeItemsDictionary = [[NSMutableDictionary alloc] init];
        JobLevelItemsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
    
}


//单例模式
+ (id) DefaultSaveData{
    
   static SaveDataSingleton *single = nil;
    if (single==nil) {
       
        single = [[SaveDataSingleton alloc] init];
        
    }
    
    return  single;
    
}

@end
