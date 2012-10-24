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
}

@property(nonatomic,retain)NSMutableArray *salaryInfoArray;
@property(nonatomic,retain)NSMutableDictionary *salarySearchInfoDictionary;

@end
