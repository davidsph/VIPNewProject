//
//  PromptsView.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface PromptsView : UIView

@property(nonatomic,retain)UILabel  *promptLabel;//提示文字

//显示文本的方法
- (void)show:(NSString *)showText;
//隐藏
- (void)hidden;
@end
