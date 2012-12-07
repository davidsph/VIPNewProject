//
//  Job.m
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1Job.h"

@implementation A1Job
@synthesize jobNumber,jobTitle,jobCity,jobCityRegion,companyId,companyName,companyNumber,cityId,companyShortName,countryId,openingDate,provinceId,important;


-(void)dealloc
{
    [self.jobNumber release];//职位编号
    [self.jobTitle release];//职位名称
    [self.jobCity release];//职位发布城市
    [self.jobCityRegion release];//职位发布城市城区
    [self.companyId release];//公司Id
    [self.companyNumber release];//公司编号
    [self.companyName release];//公司名称
    [self.countryId release]; //公司所在国
    [self.provinceId release];//公司所在省
    [self.cityId release];//公司所在城市
    [self.companyShortName release];//公司简称
    [self.openingDate release];//发布日期
    [self.important release];//1为急聘，2为普通
    [super dealloc];
}

-(id)initWithJobNumber:(NSString *)aJobNumber JobTitle:(NSString *)aJobTitle JobCity:(NSString *)aJobCity JobCityRegion:(NSString *)aJobCityRegion CompanyId:(NSString *)aCompanyId CompanyNumber:(NSString *)aCompanyNumber CompanyName:(NSString *)aCompanyName CountryId:(NSString *)aCountryId ProvinceId:(NSString *)aProvinceId CityId:(NSString *)aCityId CompanyShortName:(NSString *)aCompanyShortName OpeningDate:(NSString *)aOpeningDate Important:(NSString *)aImportant
{
    
    self=[super init];
    if (self) {
        self.jobNumber=aJobNumber;
        self.jobTitle=aJobTitle;
        self.jobCity=aJobCity;
        self.jobCityRegion=aJobCityRegion;
        self.companyId=aCompanyId;
        self.companyNumber=aCompanyNumber;
        self.companyName=aCompanyName;
        self.countryId=aCountryId;
        self.provinceId=aProvinceId;
        self.cityId=aCityId;
        self.companyShortName=aCompanyShortName;
        self.openingDate=aOpeningDate;
        self.important=aImportant;
    }
    return self;
}

-(id)initWithJobNumber:(NSString *)aJobNumber JobTitle:(NSString *)aJobTitle JobCity:(NSString *)aJobCity JobCityRegion:(NSString *)aJobCityRegion
{
    self=[super init];
    if (self) {
        self.jobNumber=aJobNumber;
        self.jobTitle=aJobTitle;
        self.jobCity=aJobCity;
        self.jobCityRegion=aJobCityRegion;
    }
    return self;
}

@end
