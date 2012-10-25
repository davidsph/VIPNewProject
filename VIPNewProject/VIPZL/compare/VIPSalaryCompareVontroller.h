//
//  VIPSalaryCompareVontroller.h
//  VIPZL
//
//  Created by david on 12-10-23.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface VIPSalaryCompareVontroller : UIViewController<MBProgressHUDDelegate>
{
    
//    NSMutableDictionary *thisDictionaryForPieChart;
//    NSArray *salaryLevelKeyArray;
//    //暂时保存所有比较条件数据的字典
//    NSArray *tmpSaveArray;
//    NSMutableDictionary *tmpSaveSearchDictionary;
    
   
}

@property (retain, nonatomic) IBOutlet UILabel *firstLowLabel;

@property (retain, nonatomic) IBOutlet UILabel *firstLowNormalLabel;
@property (retain, nonatomic) IBOutlet UILabel *firstNormalLabel;
@property (retain, nonatomic) IBOutlet UILabel *firstNormalHighLabel;
@property (retain, nonatomic) IBOutlet UILabel *firstHighLabel;


@property (retain, nonatomic) IBOutlet UILabel *secondLowLabel;

@property (retain, nonatomic) IBOutlet UILabel *secondLowNormalLabel;

@property (retain, nonatomic) IBOutlet UILabel *secondNormalLabel;

@property (retain, nonatomic) IBOutlet UILabel *secondNormalHighLabel;
@property (retain, nonatomic) IBOutlet UILabel *senondHighLabel;


@property (retain, nonatomic) IBOutlet UILabel *LowComparingLabel;

@property (retain, nonatomic) IBOutlet UILabel *lowNormalComparingLabel;

@property (retain, nonatomic) IBOutlet UILabel *normalComparingLabel;

@property (retain, nonatomic) IBOutlet UILabel *normalHighComparingLabel;

@property (retain, nonatomic) IBOutlet UILabel *highComparingLabel;

@property (retain, nonatomic) IBOutlet UILabel *comLabel1;

@property (retain, nonatomic) IBOutlet UILabel *comLabel2;

@property (retain, nonatomic) IBOutlet UILabel *comLabel3;
@property (retain, nonatomic) IBOutlet UILabel *comLabel4;
@property (retain, nonatomic) IBOutlet UILabel *comLabel5;

@property (retain, nonatomic) IBOutlet UIPickerView *pickerview;

@property(nonatomic,retain)NSMutableArray *salaryInfoArray; //服务器返回的薪酬信息 按照顺序 排列
@property(nonatomic,retain)NSMutableDictionary *salarySearchInfoDictionary; //这是用户选择的项目
@property(nonatomic,retain)NSMutableDictionary *AllKeysForSalaryComparing; //获取比较信息 城市等
- (IBAction)compare:(id)sender;



@end
