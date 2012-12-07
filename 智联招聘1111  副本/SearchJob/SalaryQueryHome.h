//
//  SalaryQueryHome.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectQueryConditons.h"
#import "PromptsView.h"
#import "GDataXMLNode.h"
#import "ActivityView.h"

//****************************************//
//********************薪酬查询的首页设置********************//
//****************************************//

@interface SalaryQueryHome : UITableViewController<UITextFieldDelegate,SelectQueryConditonsDelegate,NSURLConnectionDataDelegate>
{    
    NSMutableArray  *textLabelArray;//显示查询条件的数组
    NSMutableArray  *detailLabelArray;//显示选择的查询条件提示
    
    // 记录本界面的选中行
    int selectedRow;
    
    //记录选择条件页面的选中行，用于视图间传值
    int num ;
    
    //选择条件的ID，用于网络请求时的参数传递
    NSString  *cityID;//地区ID
    NSString  *industryID;//行业ID
    NSString  *corpropertyID;//企业性质ID
    NSString  *jobcatID;//职业类别ID
    NSString  *joblevelID;//职业级别ID
    NSString  *educationID;//学历ID

    //选择的条件，用于布局第二个界面时提供显示的数据源
    NSString  *city;//地区
    NSString  *industry;//行业
    NSString  *corproperty;//企业性质
    NSString  *jobcat;//职业类别
    NSString  *joblevel;//职业级别
    NSString  *education;//学历
    NSString  *salary;//薪酬
    
    //提示视图，当用户未输入完整的查询条件时会提示用户的一个小黑条
    PromptsView  *promptView;
    
    //点击查询时整个界面被一个起缓冲作用的视图覆盖，禁止用户做其他的操作
    ActivityView  *activityView;
}

//1表示有工作经验 ，2表示无工作经验
@property(nonatomic,assign)int experience;  

//记录请求到的网络数据
@property(nonatomic,retain)NSMutableData  *queryData;

//向薪酬查询接口发出请求
-(void)requestForQuery;

//解析从接口获得的XMl数据（解析根节点）
-(void)readXMLString;

//根据xml的根节点解析相关数据
-(NSMutableArray *)parseFromXMLNodeRoot:(GDataXMLElement *)root;


@end
