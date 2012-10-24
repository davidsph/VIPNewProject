//
//  VIPMyZhilianViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A2ResumeView.h"
#import "GetPath.h"
@interface VIPMyZhilianViewController : UIViewController<tapShowProtocol,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UINavigationBarDelegate>
{
    GetPath *path;
}

@property (retain, nonatomic) IBOutlet UILabel *resumeNameLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *resumeScrollView;

@property (nonatomic,retain)UIPageControl *pageControl;

@property(nonatomic,retain)NSArray *rsmArray;//简历的数组
@property(nonatomic,retain)NSArray *someNumber;//存放未读数等，传到表
@property(nonatomic,retain)NSMutableArray *rsmViewArray;//存放简历视图的数组，以便设置默认简历时使其他简历的图标改为灰色。
@property(nonatomic,assign)int beforeDefaultNumber;//前一个默认简历下标
-(void)changePageCtrl:(UIPageControl *)p;//pagecontrol改变值的时候


@end
