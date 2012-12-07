//
//  ArticleDetailVC.h
//  JobGuide
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityView.h"

@interface ArticleDetailVC  : UIViewController<NSURLConnectionDataDelegate> //异步获取数据使用的代理 
{
    ActivityView *activityV;
    NSMutableData *_data;// 从网络接口上取得的xml数据
}
@property (assign, nonatomic) int ID;//从上一个界面传过来的ID
@property (retain, nonatomic)  UILabel *titleLabel;//文章标题
@property (retain, nonatomic)  UILabel *startDateLabel;//文章创建日期
@property (retain, nonatomic)  UITextView *contentTextView;//文章内容

@end
