//
//  DrawTwoView.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SalaryQueryResult.h"
@interface DrawTwoView : UIView
{
    NSInteger  vInterval;//竖直间间距
}
@property(nonatomic,retain)NSArray  *hArray;//水平坐标轴的值
@property(nonatomic,retain)NSArray  *vArray;//竖直坐标轴的值

@property(nonatomic,retain)NSArray  *drawArray;//需要绘画的点(查询工资的点)
@property(nonatomic,retain)NSArray  *drawArray2;//（比较工资的点）
@property(nonatomic,retain)NSArray *salaryArray;//存放得到的五个查询工资
@property(nonatomic,retain)NSArray *salaryArray2;//存放得到的五个比较工资
@property(nonatomic,assign)int salary;//
-(void)initDrawView:(NSArray *)arr andView:(NSArray *)arr2 andSalary:(int)sal;



@end
