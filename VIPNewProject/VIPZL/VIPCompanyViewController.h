//
//  VIPCompanyViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPCompanyViewController : UITableViewController

{
    NSArray *companyArray;
}
@property(retain,nonatomic)NSString *position;//当前位置
@property(retain,nonatomic)NSString *industry;//行业类别；
@property(retain,nonatomic)NSString *postName;//职位名称
@property(retain,nonatomic)NSString *workPositon;//工作地点
@property(retain,nonatomic)NSString *keyWord;//关键词
@property(retain,nonatomic)NSString *range;//定位范围

- (void)getCompanys;
@end
