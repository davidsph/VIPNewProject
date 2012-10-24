//
//  Job.h
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A1Job : NSObject
@property (retain,nonatomic)NSString *jobNumber;//职位编号
@property (retain,nonatomic)NSString *jobTitle;//职位名称
@property (retain,nonatomic)NSString *jobCity;//职位发布城市
@property (retain,nonatomic)NSString *jobCityRegion;//职位发布城市城区
@property (retain,nonatomic)NSString *companyId;//公司Id
@property (retain,nonatomic)NSString *companyNumber;//公司编号
@property (retain,nonatomic)NSString *companyName;//公司名称
@property (retain,nonatomic)NSString *countryId;//公司所在国
@property (retain,nonatomic)NSString *provinceId;//公司所在省
@property (retain,nonatomic)NSString *cityId;//公司所在城市
@property (retain,nonatomic)NSString *companyShortName;//公司简称
@property (retain,nonatomic)NSString *openingDate;//发布日期
@property (retain,nonatomic)NSString *important;//1为急聘，2为普通


-(id)initWithJobNumber:(NSString *)aJobNumber
              JobTitle:(NSString *)aJobTitle 
               JobCity:(NSString *)aJobCity
         JobCityRegion:(NSString *)aJobCityRegion
             CompanyId:(NSString *)aCompanyId
         CompanyNumber:(NSString *)aCompanyNumber
           CompanyName:(NSString *)aCompanyName
             CountryId:(NSString *)aCountryId
            ProvinceId:(NSString *)aProvinceId 
                CityId:(NSString *)aCityId
      CompanyShortName:(NSString *)aCompanyShortName
               OpeningDate:(NSString *)aOpeningDate
                Important:(NSString *)aImportant;


-(id)initWithJobNumber:(NSString *)aJobNumber JobTitle:(NSString *)aJobTitle JobCity:(NSString *)aJobCity JobCityRegion:(NSString *)aJobCityRegion;//用于展示公司其它职位


@end
