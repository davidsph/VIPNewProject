//
//  A1FilterTableVIewController.h
//  SearchJob
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchJob.h"
#import "A1ShowTable.h"
@interface A1FilterTableVIewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    int selectRow;
}

@property (retain,nonatomic)A1ShowTable *showtable;
@property (nonatomic,retain) SearchJob * search;

@property (nonatomic,retain) UITableView  * _tableView;
@property (nonatomic,retain) UITableView * _tableView1;
@property (nonatomic,retain) NSMutableArray * firstArr;
@property (nonatomic,retain) NSMutableArray * secondArr;
@property (nonatomic,retain) NSMutableArray * compareArr;
@property (nonatomic,retain) UIView * view1;//用于贴第二个tableView；
@property (nonatomic,retain) UIView * view2;

@property (nonatomic,retain) NSMutableArray * publishDateArr;//发布时间

@property (nonatomic,retain) NSMutableArray * workEXPArr;//工作经验

@property (nonatomic,retain) NSMutableArray * educationArr;//学历要求

@property (nonatomic,retain) NSMutableArray * comptypeArr;//公司性质

@property (nonatomic,retain) NSMutableArray * compsizeArr;//公司规模

@property (nonatomic,retain) NSMutableArray * salaryArr;//月薪范围


-(void)initNewTableData;

@end
