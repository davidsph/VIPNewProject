//
//  VIPChannelListViewController.h
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPArticleDetailViewController.h"

@interface VIPChannelListViewController : UITableViewController<NSURLConnectionDataDelegate,VIPArticleDetailViewControllerDelegate>
{
    NSMutableData *_data;// 从网络接口上取得的xml数据
    NSMutableArray *channelList;//用于存放解析xml数据得到的数据
    
    double  txtFont;//文章默认的字体大小
}

@property (nonatomic,retain)UITableView *channelListTableView;
@property (nonatomic,assign)double txtFont;//文章默认的字体大小

@end
