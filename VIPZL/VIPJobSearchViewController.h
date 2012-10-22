//
//  VIPJobSearchViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPSearchOptionViewController.h"
@interface VIPJobSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SearchOptionProtocl>
{
    NSMutableArray *cellName;
    NSMutableArray *cellOption;
    
    BOOL selectPositon;//是否选中了当前位置
    BOOL selectPostName;//是否选中了职位名称
    BOOL selectIndustry;//是否选中了行业类别
    BOOL selectWorkPositon;//是否选中了工作地点
    BOOL selectRange;//是否选中了定位范围
    
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView1;

@property(retain,nonatomic)NSString *industry;//行业类别；
@property(retain,nonatomic)NSString *position;//当前位置
@property(retain,nonatomic)NSString *postName;//职位名称
@property(retain,nonatomic)NSString *workPositon;//工作地点
@property(retain,nonatomic)NSString *range;//定位范围


@end
