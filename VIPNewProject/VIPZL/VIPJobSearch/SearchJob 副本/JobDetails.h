//
//  JobDetails.h
//  SearchJob
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface JobDetails : NSObject<NSURLConnectionDataDelegate>

@property (retain,nonatomic)NSMutableData *receiveData;
@property (assign,nonatomic)int thisPage;

@property (retain,nonatomic)NSString *jobNumber;//职位编号
@property (retain,nonatomic)NSString *jobTitle;//职位名称
@property (retain,nonatomic)NSString *openingDate;//发布日期
@property (retain,nonatomic)NSString *jobCity;//发布城市
@property (retain,nonatomic)NSString *workingExp;//经验需求
@property (retain,nonatomic)NSString *salaryRange;//月薪
@property (retain,nonatomic)NSString *number;//招聘人数
@property (retain,nonatomic)NSString *responsibility;//职位描述
@property (retain,nonatomic)NSString *longitude;//经度
@property (retain,nonatomic)NSString *latitude;//纬度
@property (retain,nonatomic)NSString *companyNumber;//公司编号
@property (retain,nonatomic)NSString *companyName;//公司名称
@property (retain,nonatomic)NSString *companySize;//公司规模
@property (retain,nonatomic)NSString *companyProperty;//公司性质
@property (retain,nonatomic)NSString *industry;//公司所属行业
@property (retain,nonatomic)NSString *address;//公司地址
@property (retain,nonatomic)NSString *companyDesc;//公司描述
@property (retain,nonatomic)NSMutableArray *otherJobList;//公司其它职位列表


-(id)initWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize;//同步方法获取职位详情
+(void)GetJobDetailWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize;//异步获取职位详情，获取方式接收名为“职业详情”的通知，从useinfo字典中读取“jd”对象，对象类型为“JobDetails”



-(void)GetJobDetailWithJobNumber:(NSString *)aJobNumber Page:(int)aPage PageSize:(int)aPageSize;
+(JobDetails *)analysisStr:(NSString *)str toJobDetails:(JobDetails *)jobDetails;

@end
