//
//  ActivityView.m
//  Real-time recommend
//
//  Created by Ibokan on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ActivityView

@synthesize label, activi;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        //背景，出现为了防止误操作
        UIView *backView = [[[UIView alloc] initWithFrame:frame]autorelease];
        backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"QQ20121016-1.png"]];
        backView.alpha = 0.7;
        [self addSubview:backView];
                   
        //风火轮
        self.activi = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        self.activi.center =CGPointMake(160, 170);
        [backView addSubview:self.activi];
        
        //label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(110, 90, 100, 100)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = UITextAlignmentCenter;
        self.label.text = @"载入中...";
        [backView addSubview:self.label];        
    }
    return self;
}
//显示方法
- (void)show
{
    self.alpha =0.7;
    [self.activi startAnimating];
}
//隐藏方法
- (void)hidden
{
    self.alpha = 0;
    [self.activi stopAnimating];
}

- (void)dealloc 
{
    [super dealloc];
}


@end
