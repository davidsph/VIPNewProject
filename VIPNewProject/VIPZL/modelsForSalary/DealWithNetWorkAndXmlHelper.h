//
//  DealWithNetWorkAndXmlHelper.h
//  VIPZL
//
//  Created by david on 12-10-21.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealWithNetWorkAndXmlHelper : NSObject


//获得城市列表
+ (NSMutableDictionary *) getCityItems;
//获得行业列表
+ (NSMutableDictionary *) getIndustryItems;
//获得学历列表
+ (NSMutableDictionary *) getEducationItems;
//获得公司性质列表
+ (NSMutableDictionary *) getCompanyTypeItems;
//获得职业列表
+ (NSMutableDictionary *) getJobTypeItems;
//获得职位级别
+ (NSMutableDictionary *) getJobLevelItems;

//所有的参数 查询的时候
+(NSArray *) getAllKeys;
//这是比较的时候
+ (NSMutableDictionary *) getAllKeysForSalaryComparing;
+(NSMutableArray *) getSalaryInfoFromNetWork:(NSMutableDictionary *) dictionary;

@end

@interface SaveItemsWithDictionary : NSObject {
@private
    NSMutableDictionary *cityItemDictionary; //城市
    NSMutableDictionary *IndustryItemsDictionary; //行业
    NSMutableDictionary *EducationItemsDictionary; //学历
    NSMutableDictionary *CompanyTypeItemsDictionary;//公司性质
    NSMutableDictionary *JobTypeItemsDictionary;//职业类别
    NSMutableDictionary *JobLevelItemsDictionary; //职业等级
    
 }

+ (id) DefaultSaveItems;
@end