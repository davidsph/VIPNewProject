//
//  DrawView.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SalaryQueryHome.h"
@interface DrawView : UIView
{
    NSInteger  vInterval;//竖直间间距
}

@property(nonatomic,retain)NSArray  *hArray;//水平坐标轴的值
@property(nonatomic,retain)NSArray  *vArray;//竖直坐标轴的值

@property(nonatomic,retain)NSArray  *drawArray;//需要绘画的点

@property(nonatomic,retain)NSArray *salaryArr;//存放得到的五个薪水值

@property(nonatomic,assign)int  salary;//查询的薪水值

-(void)initDrawView:(NSArray *)arr andSalary:(int)salay;

@end
