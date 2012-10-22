//
//  VIPJobSearchViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPIndustryViewController.h"
@interface VIPJobSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,IndustryProtocl>
{
    NSMutableArray *cellName;
    NSArray *cellOption;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView1;

@property(retain,nonatomic)NSString *industry;//行业类别；

@end
