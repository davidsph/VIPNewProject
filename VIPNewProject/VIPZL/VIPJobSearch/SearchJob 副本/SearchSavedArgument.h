//
//  SearchSavedArgument.h
//  searchSave
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSavedArgument : NSObject<NSURLConnectionDataDelegate>

//
@property (nonatomic ,retain) NSMutableData *receivedData;
//
@property (nonatomic ,retain) NSString *uticket;//用户验证码
@property (nonatomic ,assign) int  type;//搜索类型
@property (nonatomic ,retain) NSString *schJobType;//职业
//@property (nonatomic ,assign) int subJobType;
@property (nonatomic ,retain) NSString *industry;//行业
@property (nonatomic ,retain) NSString *city;//地区
@property (nonatomic ,retain) NSString *keyWord;//关键字
//高级搜索
@property (nonatomic ,assign) int dataRefresh;//发布时间
@property (nonatomic ,assign) int eduLevel;//学历要求
@property (nonatomic ,retain) NSString *workingexp;//工作经验
@property (nonatomic, retain) NSString *companytype;//公司性质
@property (nonatomic ,retain) NSString *companysize;//公司规模
@property (nonatomic ,assign) int salaryfrom;//月薪开始范围
@property (nonatomic ,assign) int salaryto;//月薪结束范围;
@property (nonatomic ,retain) NSString *emplType;//职位类型（兼职，全职）
//搜索器名
@property (nonatomic ,retain) NSString *searchName;

//快速搜索的方法
+(id)SearchSavedWithUticket:(NSString *)aUticket 
                 schJobType:(NSString *)aSchJobType 
                   industry:(NSString *)aIndustry 
                       city:(NSString *)aCity
                    keyWord:(NSString *)aKeyWoard;
//高级搜素的方法
+(id)SearchSavedWithUticket:(NSString *)aUticket 
                 schJobType:(NSString *)aSchJobType 
                   industry:(NSString *)aIndustry 
                       city:(NSString *)aCity 
                    keyWord:(NSString *)aKeyWoard
                dataRefresh:(int)aDataRefresh 
                   eduLevel:(int)aEduLevel 
                 workingexp:(NSString *)aWorkingexp 
                companytype:(NSString *)aCompanytype 
                companysize:(NSString *)aCompanysize
                 salaryfrom:(int)aSalaryfrom
                   salaryto:(int)salaryto 
                 searchName:(NSString *)aSearchName;
//返回字符串
//返回字符串在显示框显示的
+(id)SearchSavedWithSchJobType:(NSString *)aSchJobType 
                      industry:(NSString *)aIndustry 
                          city:(NSString *)aCity 
                       keyWord:(NSString *)aKeyWoard
                   dataRefresh:(int)aDataRefresh 
                      eduLevel:(int)aEduLevel 
                    workingexp:(NSString *)aWorkingexp 
                   companytype:(NSString *)aCompanytype 
                   companysize:(NSString *)aCompanysize
                    salaryfrom:(int)aSalaryfrom
                      salaryto:(int)aSalaryto;


@end
