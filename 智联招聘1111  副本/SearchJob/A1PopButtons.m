//
//  A1PopButtons.m
//  testMenu
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1PopButtons.h"
#import <QuartzCore/QuartzCore.h>


@implementation A1PopButtons

@synthesize contentImageView=_contentImageView,startPoint=_startPoint,endPoint=_endPoint,nearPoint=_nearPoint,farPoint=_farPoint;
@synthesize delegate,delegate1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(id)initWithImageName:(NSString *)imageName andTag:(int )aTag andButtonCounts:(int)aBtnCount andStartPoint:(CGPoint)apoint;
{
    self=[super init];
    self.userInteractionEnabled=YES;
    self.image=[UIImage imageNamed:imageName];
    btnCount=aBtnCount;
    self.tag=aTag;
    self.frame=CGRectMake(0, 0, 50, 50);
    self.startPoint=apoint;
    self.center=self.startPoint;
    [self setPostion];

    return self;
}

-(void)setPostion
{
        CGFloat angle=self.tag * (2*M_PI / btnCount);
        //通过数学方法算出最终位置
        CGPoint endPoint=CGPointMake(self.startPoint.x + 60 * sinf(angle), self.startPoint.y - 60 * cosf(angle));
        self.endPoint=endPoint; 
    
        //弹跳的最近端
        CGPoint nearPoint=CGPointMake(self.startPoint.x+55*sinf(angle), self.startPoint.y-55*cosf(angle));
        self.nearPoint=nearPoint;
        
        //弹跳的最远端
        CGPoint farPoint=CGPointMake(self.startPoint.x+65*sinf(angle), self.startPoint.y-65*cosf(angle));
        self.farPoint=farPoint;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];//缩放动画
    
    CABasicAnimation *opacityAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue=[NSNumber numberWithFloat:0.0f];//不透明度动画
    
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];//综合2个动画
    animationGroup.animations=[NSArray arrayWithObjects:scaleAnimation,opacityAnimation, nil];
    animationGroup.duration=0.1;
    animationGroup.fillMode=kCAFillModeForwards;
    
    [self.layer addAnimation:animationGroup forKey:nil];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate1 shouldRemoveBtn];
    [self.delegate didSelected:self.tag];
}






@end
