//
//  SalarySearchInfoSingleton.h
//  VIPZL
//
//  Created by david on 12-10-21.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalarySearchInfoSingleton : NSObject

//工作经验
@property(nonatomic,assign)NSInteger experence;
//城市ID
@property(nonatomic,retain)NSString *cityId;
@property(nonatomic,retain)NSString *industryId;
@property(nonatomic,retain)NSString *companyTypeId;
@property(nonatomic,retain)NSString *jobTypeId;
@property(nonatomic,retain)NSString *jobLevelId;
@property(nonatomic,assign)NSInteger *salary;
@property(nonatomic,retain)NSString *educationId;

+(id) DefaultSalarySearch;
@end
