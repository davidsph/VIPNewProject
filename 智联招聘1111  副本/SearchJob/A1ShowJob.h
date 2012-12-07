//
//  A1ShowJob.h
//  A1ShowJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1Job.h"
#import "JobDetails.h"
#import "ApplyProcess.h"
#import "ApplyProcessProtocol.h"
#import "A1PopMenuPro.h"


@interface A1ShowJob : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate,A1PopMenuPro>
{
    UIPageControl *pageC;//指示滚动视图页码
    UILabel *introduceLabel;//第一个界面标题名
    UILabel *introduceLabel2;//第二个界面的标题名
    UIScrollView *scrollV;
    UIButton *button;
}

@property (retain ,nonatomic) id delegate;
@property (assign ,nonatomic) int applyTapnumber;

@property (retain,nonatomic)A1Job *job;
@property (retain,nonatomic)JobDetails *jD;
@property (retain,nonatomic)UIImageView *promptView;
@property (assign,nonatomic)int promptCount;

//@property(retain ,nonatomic)UIImage *selcetedPoint;

-(void)joinjob;//申请职位方法

@end
