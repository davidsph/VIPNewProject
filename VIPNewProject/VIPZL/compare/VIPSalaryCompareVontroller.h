//
//  VIPSalaryCompareVontroller.h
//  VIPZL
//
//  Created by david on 12-10-23.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPSalaryCompareVontroller : UIViewController
{
    
    NSMutableDictionary *thisDictionaryForPieChart;
    NSArray *salaryLevelKeyArray;
    //暂时保存所有比较条件数据的字典
    NSArray *tmpSaveArray;
    NSMutableDictionary *tmpSaveSearchDictionary;
  
}

@property(nonatomic,retain)NSMutableArray *salaryInfoArray;
@property(nonatomic,retain)NSMutableDictionary *salarySearchInfoDictionary;
@property(nonatomic,retain)NSMutableDictionary *AllKeysForSalaryComparing; //获取比较信息 城市等
@end
