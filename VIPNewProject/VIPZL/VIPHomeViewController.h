//
//  VIPHomeViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPHomeViewController : UIViewController
//职位查询按钮方法
- (IBAction)searchPosition:(id)sender;
//我的智联按钮属性
@property (retain, nonatomic) IBOutlet UIButton *myZhilian;
//我的智联按钮方法
- (IBAction)myZhilian:(id)sender;
//实时推荐方法
- (IBAction)realTimeRecommend:(id)sender;
//薪酬查询方法
- (IBAction)paymentSearch:(id)sender;
//求职指导方法
- (IBAction)jobSeekerGuide:(id)sender;
@end
