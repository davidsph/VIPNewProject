//
//  ABC.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectQueryConditons.h"
#import "GDataXMLNode.h"
#import "SalaryCompareResult.h"
#import "QueryCell.h"
#import "PromptsView.h"
#import "ActivityView.h"

@interface SalaryQueryResult : UIViewController<UITableViewDataSource,UITableViewDelegate,SelectQueryConditonsDelegate,NSURLConnectionDataDelegate>
{
    int selectedRow;
    int tempNum;//
    
    PromptsView  *promptView;
    ActivityView  *activityView;//比较时缓冲视图
}


@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,assign)int exper;//是否有经验

@property(nonatomic,retain)NSString  *queryString;//第一个比较的条件
@property(nonatomic,retain)NSString  *compareQueryStringID;//第二个比较的条件
@property(nonatomic,retain)NSString  *compareQueryString;//

@property (nonatomic,retain)NSMutableData  *compareResultData;

//以下七个属性接收查询条件ID 
@property(nonatomic,retain)NSString  *cityID;//
@property(nonatomic,retain)NSString  *industryID;//
@property(nonatomic,retain)NSString  *corpropertyID;//
@property(nonatomic,retain)NSString  *jobcatID;//
@property(nonatomic,retain)NSString  *joblevelID;//
@property(nonatomic,retain)NSString  *educationID;//

@property(nonatomic,retain)NSString  *city;//
@property(nonatomic,retain)NSString  *industry;//
@property(nonatomic,retain)NSString  *corproperty;//
@property(nonatomic,retain)NSString  *jobcat;//
@property(nonatomic,retain)NSString  *joblevel;//
@property(nonatomic,retain)NSString  *education;//

@property(nonatomic,retain)NSString *salary;//

@property(nonatomic,retain)NSMutableArray  *queryResultArray;//存放解析得到的查询的五个工资
@property(nonatomic,retain)NSMutableArray  *compareResultArray;//存放解析得到的比较后 的五个工资

//向比较薪酬接口发出请求
-(void)requestForCompare;

//解析从接口获得的XMl数据
-(void)readXMLString;

//根据xml的根节点解析相关数据
-(void)parseFromXMLNodeRoot:(GDataXMLElement *)root;
@end
