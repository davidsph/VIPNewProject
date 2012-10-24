//
//  CompanyDetail.h
//  SearchJob
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface CompanyDetail : NSObject<NSURLConnectionDataDelegate>

@property (retain,nonatomic)NSMutableData *receiveData;
@property (assign,nonatomic)int thisPage;

@property (retain,nonatomic)NSString *companyNumber;//公司编号
@property (retain,nonatomic)NSString *companyName;//公司名称
@property (retain,nonatomic)NSString *companySize;//公司规模
@property (retain,nonatomic)NSString *companyProperty;//公司性质
@property (retain,nonatomic)NSString *industry;//公司所属行业
@property (retain,nonatomic)NSString *address;//公司地址
@property (retain,nonatomic)NSString *companyDesc;//公司描述
@property (retain,nonatomic)NSMutableArray *otherJobList;//公司其它职位列表

-(id)initWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize;//同步方法获取公司详情
+(void)GetCompanyDetailWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize;//异步获取公司详情，获取方式接收名为“公司详情”的通知，从useinfo字典中读取“cd”对象，对象类型为“CompanyDetails”





-(void)GetCompanyDetailWithCompanyNumber:(NSString *)aCompanyNumber Page:(int)aPage PageSize:(int)aPageSize;
+(CompanyDetail *)analysisStr:(NSString *)str toCompanyDetails:(CompanyDetail *)CompanyDetails;

@end
