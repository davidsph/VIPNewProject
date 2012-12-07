//
//  ArticleListVC.h
//  JobGuidance
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"
#import "ActivityView.h"

@interface ArticleListVC : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    ActivityView *activityV;
    NSMutableData *_data;// 从网络接口上取得的xml数据
   
    Channel *channel;
//    UIActivityIndicatorView *indicator;//网络指示器
//    UIImageView *indicatorImage;//加载指示器的View
}
@property (assign, nonatomic) int ID;
@property(retain,nonatomic)UITableView *tableView;
@end
