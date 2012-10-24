//
//  VIPArticleDetailViewController.h
//  求职指导
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHKReadItLater.h"
#import "SHKFacebook.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"

@protocol VIPArticleDetailViewControllerDelegate <NSObject>

-(void)textFont:(double)aTextFont;

@end

@interface VIPArticleDetailViewController : UIViewController<NSURLConnectionDataDelegate,UITextViewDelegate>//异步获取数据使用的代理 
{
     NSMutableData *_data;// 从网络接口上取得的xml数据
    int i;//字体大小

}

@property (nonatomic,assign) int ID;//从上一个界面传过来的ID
@property (nonatomic,retain) UILabel *titleLabel;//文章标题
@property (nonatomic,retain) UILabel *startDateLabel;//文章创建日期
@property (nonatomic,retain) UIImageView *imageView;//分割标题和内容的分割线
@property (nonatomic,retain) UITextView *contentTextView;//文章内容
@property (nonatomic,retain) UIView *endView;//最底部提示视图
@property (nonatomic,retain) UIView *topView;//最顶部视图
@property (nonatomic,assign) double textFont;//改变过的字体大小
@property (nonatomic ,assign)id<VIPArticleDetailViewControllerDelegate>delegate;

@end
