//
//  VIPArticleListViewController.h
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPTableFootView.h"
#import "VIPArticleDetailViewController.h"

@class VIPChannel;

@interface VIPArticleListViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate>
{
    NSMutableData *_data;// 从网络接口上取得的xml数据
    UIView *_connectionView;//网络连接状况说明视图
    UILabel *_connectionLabel;//网络连接状况说明label
    VIPChannel *channel;
    int hight;//到达这一数值，就进行加载
    BOOL canreload;//判断是否已经全部加载完毕
    VIPTableFootView *footView;

}
@property (nonatomic,assign)int i;//每个表的行数
@property (nonatomic,assign)int ID;
@property (nonatomic,retain)UITableView *articleListTableView;
@property (nonatomic,retain)UIButton *topButton;
@end
