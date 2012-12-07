//
//  Asvanced.h
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1FirstLevelViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "PromptsView.h"
@interface A1FindJobViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,A1FirstLevelViewControllerDelegate,UITextFieldDelegate,UISearchBarDelegate,UIAlertViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray * grayArr;    // 下边四个数组用来存放客户端显示的原始数据
    NSMutableArray * advancedArr;
    NSMutableArray * historyArr;
    NSMutableArray * originQuickGrayArr;
    
    NSString *pickerValues;//pickerView输入的值
    
    int selectedRow;    // 记录选择的是哪一行的cell
    NSMutableArray * dataArr;
    
    NSMutableDictionary * history; //控制历史分区
    
    
    NSMutableArray * today ; // 存放分类的历史数据
    NSMutableArray * yesterday ;
    NSMutableArray * earlier ;    
    NSMutableArray * tempArr;  // 替换数组
    
    int flag; // 判断点击的是哪一个历史按钮
    
    PromptsView * promptView;   // 点击历史时出现的 黑色的弹出view

    UIActionSheet *actionSheet;   
    NSString * textString;   // 记录searchBar上边贴上的textFiled的内容

    
}
@property (retain,nonatomic)NSMutableArray *grayArr, *advancedArr,*historyArr,*historyArrList;
@property(nonatomic,retain)NSMutableArray *contents;
@property (nonatomic,retain) UITextField * textField_;

@property(nonatomic,assign)BOOL historyMark,flagToday,flagYesterday,flagErlier;  // 历史列表是否打开的标记位// 昨天几天更早的历史的标记为，用于历史搜索使用
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic,retain)CLLocation *checkinLocation;
@property (nonatomic,retain) NSMutableDictionary * allDataDic;  // 存放历史库数据的字典

@property (nonatomic,retain) NSString *  databaseStr;//保存每一次的记录

-(void)changeHistoryArrList;   

-(void)historyStretch;
-(void)yesterdayHistoryStretch;
-(void)todayHistoryStretch;
-(void)earlierHistoryStretch;

@end
