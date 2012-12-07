//
//  SearchJob.h
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNWrapper.h"
#import "A1Job.h"
#import "sqlite3.h"
#import "A1HistroyDB.h"
@interface SearchJob : NSObject<NSURLConnectionDataDelegate>

@property (retain,nonatomic)NSMutableData *receiveData;
@property (retain,nonatomic)NSURLConnection *connection1,*connection2;


@property (nonatomic,assign)int type;//搜索类型
@property (nonatomic,retain)NSString *schJobType;//职位类型。。。。
@property (nonatomic,assign)int subJobType;//
@property (nonatomic,retain)NSString *industry;//行业类型。。。。
@property (nonatomic,retain)NSString *city;//地区。。。。。。。。
@property (nonatomic,retain)NSString *keyWord;//关键字。。。。。
@property (nonatomic,assign)int dataRefresh;//职位发布日期。。。。。
@property (nonatomic,assign)int eduLevel;//学历......
@property (nonatomic,retain)NSString *jobLocation;//当前坐标....
@property (nonatomic,retain)NSString *pointRanger;//地图范围。。。。
@property (nonatomic,retain)NSString *workingExp;//工作经验.....
@property (nonatomic,retain)NSString *companyType;//公司性质。。。。
@property (nonatomic,retain)NSString *companySize;//公司规模....
@property (nonatomic,retain)NSString *emplType;//职位类型....
@property (nonatomic,assign)int salaryFrom;//月薪开始范围......
@property (nonatomic,assign)int salaryTo;//月薪结束范围......
@property (nonatomic,retain)NSString *sort;//排序字段。。。。
@property (nonatomic,assign)int pageSize;//返回记录数
@property (nonatomic,assign)int page;//当前页数

@property (nonatomic,retain)NSString * date;// 记录计入数据库时候的时间

-(id)initWithType:(int)type
       schJobType:(NSString *)schJobType
       subJobType:(int) subJobType
         industry:(NSString *) industry
             city:(NSString *) city 
          keyWord:(NSString *)keyWord 
      dataRefresh:(int)dataRefresh
         eduLevel:(int) eduLevel
      jobLocation:(NSString *) jobLocation
      pointRanger:(NSString *) pointRanger
       workingExp:(NSString *) workingExp
      companyType:(NSString *) companyType
      companySize:(NSString *) companySize
         emplType:(NSString *) emplType
       salaryFrom:(int) salaryFrom
         salaryTo:(int) salaryTo
             sort:(NSString *) sort
             date:(NSString *) date
         ;

-(id)initWithschJobType:(NSString *) schJobType
               industry:(NSString *) industry
                   city:(NSString *) city
                keyWord:(NSString *) keyWord
            pointRanger:(NSString *) pointRanger
                   sort:(NSString *) sort
               ;
-(NSMutableArray *)quickSearchBySYNWith:(int)aPage Pagesize:(int)aPageSize;//快速搜索（同步）
-(NSMutableArray *)advancedSearchBySYNWith:(int)aPage Pagesize:(int)aPageSize;//高级搜索（同步）
+(NSMutableArray *)alikeJobBySYN:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize;//查找相似职位（同步）

//异步 数据的获取方式为接收名为“搜索结果”以及“更多搜索结果”的通知，从通知的useInfo字典中提取“arr”可变数组
-(void)quickSearchWith:(int)aPage Pagesize:(int)aPageSize;//快速搜索（异步）
-(void)advancedSearchWith:(int)aPage Pagesize:(int)aPageSize;//高级搜索（异步）
+(void)alikeJob:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize;//查找相似职位（异步）



//外部无需调用的方法
+(NSMutableArray *)analysisStr:(NSString *)str;//搜索解析数据
-(void)alikeJob:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize;
+(NSMutableArray *)analysisStrForAlikeJob:(NSString *)str;//相似职位解析数据

+(NSMutableArray *)findAllJobInDataBase;
+(void)addSearchJobINDataBaseofschJobType:(NSString *) schJobType  industry:(NSString *) industry city:(NSString *) city keyWord:(NSString *) keyWord dataRefresh:(NSString *)dataRefresh  pointRanger:(NSString *) pointRanger workingExp:(NSString *) workingExp companyType:(NSString *) companyType companySize:(NSString *) companySize salaryFrom:(NSString *) salaryFrom salaryTo:(NSString *) salaryTo sort:(NSString *) sort date:(NSString *)date;
+(void)deleteAllINDatabase;
@end
