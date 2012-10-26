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
    

    
   
}



@property(nonatomic,retain)NSArray *itemsAllKeys;



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


@property (retain, nonatomic) IBOutlet UILabel *cityLabel;

@property (retain, nonatomic) IBOutlet UILabel *industryLabel;

@property (retain, nonatomic) IBOutlet UILabel *educationLabel;

@property (retain, nonatomic) IBOutlet UILabel *companyType;

@property (retain, nonatomic) IBOutlet UILabel *jobType;

@property (retain, nonatomic) IBOutlet UILabel *jobLevel;

@property (retain, nonatomic) IBOutlet UILabel *compareCon1;

@property (retain, nonatomic) IBOutlet UILabel *compareCon2;

@property (retain, nonatomic) IBOutlet UILabel *compareConditionLabel;


@property(nonatomic,retain)NSMutableArray *salaryInfoArray; //服务器返回的薪酬信息 按照顺序 排列
@property(nonatomic,retain)NSMutableDictionary *salarySearchInfoDictionary; //这是用户选择的项目  
@property(nonatomic,retain)NSMutableDictionary *salarySearchInfoDictionaryForshow; //这是为显示封装的数据

@property(nonatomic,retain)NSMutableDictionary *AllKeysForSalaryComparing; //获取比较信息 城市等
- (IBAction)compare:(id)sender;



@end
