//
//  SaveDataSingleton.h
//  VIPZL
//
//  Created by david on 12-10-22.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveDataSingleton : NSObject

@property(nonatomic,retain)NSMutableDictionary *cityItemDictionary; //城市
@property(nonatomic,retain)NSMutableDictionary *IndustryItemsDictionary;//行业
@property(nonatomic,retain)NSMutableDictionary *EducationItemsDictionary;//学历
@property(nonatomic,retain)NSMutableDictionary *CompanyTypeItemsDictionary; //公司性质
@property(nonatomic,retain)NSMutableDictionary *JobTypeItemsDictionary; //职业类别
@property(nonatomic,retain)NSMutableDictionary *JobLevelItemsDictionary; //职业等级

+ (id) DefaultSaveData;
@end
