//
//  SalaryCompareResult.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawTwoView.h"
#import "GDataXMLNode.h"
#import "PromptsView.h"
#import "SelectQueryConditons.h"
#import "SalaryCompareResult2.h"
#import "ActivityView.h"

@interface SalaryCompareResult : UIViewController<UITableViewDataSource,UITableViewDelegate,SelectQueryConditonsDelegate>
{
    int selectedRow;//选中的行
    
    int  tempNum;//tempNum保存 选择第一个比较条件时选中的条件索引
    
    PromptsView  *promptView;
    
    ActivityView  *activityView;//
}
@property(nonatomic ,assign)int tempNumFromLastClass;//从上一个类中获得的数值

//以下七个属性接收查询条件
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
@property(nonatomic,retain)NSString *salary;////输入的薪水值

@property(nonatomic,retain)UITableView  *tableView;//

@property(nonatomic,assign)int experience;//是否有经验

@property(nonatomic,retain)NSString  *queryString;//第一个比较条件
@property(nonatomic,retain)NSString  *compareQueryString;//第二个（即详细比较条件）
@property(nonatomic,retain)NSString  *compareQueryStringID;

@property(nonatomic,retain)NSMutableData  *data;//存储网络请求数据

@property(nonatomic,retain)NSMutableArray  *querySalary;//查询薪水
@property(nonatomic,retain)NSMutableArray *compareSalary;//比较薪水


-(void)requestForCompare;//进行网络请求
-(void)readXMLString;//解析从接口获得的XMl数据

//根据xml的根节点解析相关数据
-(void)parseFromXMLNodeRoot:(GDataXMLElement *)root;
@end
