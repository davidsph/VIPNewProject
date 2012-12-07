//
//  A1ShowOtherJob.h
//  SearchJob
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDetails.h"
#import "CompanyDetail.h"
#import "A1Job.h"

@interface A1ShowOtherJob : UITableViewController

{
    int newCount;
    BOOL  LoadingSign,loadingMoreSign;
}
@property (assign,nonatomic)int dataSourceSign;//数据来源 1：职业详情  2：公司详情 

@property (retain,nonatomic)JobDetails *jd;//职业详情

@property (retain,nonatomic)CompanyDetail *cd;//公司详情

@property (retain,nonatomic)NSMutableArray *allArr;//列表数组

@property (retain,nonatomic)UILabel *loadMoreLa;//是否正在加载


-(void)loadMore;
@end
