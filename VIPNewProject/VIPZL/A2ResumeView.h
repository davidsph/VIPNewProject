//
//  A2ResumeView.h
//  LogIn
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resume.h"
@class Uticket;
@protocol tapShowProtocol <NSObject>
- (void)pushNewPage:(Resume *)resume;//点击浏览按钮让controller推出新界面
- (void)setDefaultResume:(NSString *)msg;//点击设置默认简历,失败时在界面弹出alert提示，成功的话将之前的默认简历的标志设为灰色标志。
- (void)sentNumber:(int)nmb;//代理传值，传默认简历的下标。

@end
@interface A2ResumeView : UIImageView

{
    NSString *showCount;
    int _number;
}
@property(nonatomic,assign)int number;//每个视图的标志，在srcollview里属于第几个
@property(nonatomic,assign)BOOL isDefault;//是否是默认简历
@property(nonatomic,retain)id<tapShowProtocol>delegate;
@property(nonatomic,retain)Resume *theResume;//这个view的简历实例
@property(nonatomic,retain)UIButton *setDefalutResumebt;


- (id)initWithFrame:(CGRect)frame resume:(Resume *)currentRsm;

@end
