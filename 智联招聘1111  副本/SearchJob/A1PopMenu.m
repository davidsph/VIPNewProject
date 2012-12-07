//
//  A1PopMenu.m
//  testMenu
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1PopMenu.h"
#import "A1PopButtons.h"
#import "PopViewControllerCount.h"
#import <QuartzCore/QuartzCore.h>

@implementation A1PopMenu
@synthesize isMovedSign;
@synthesize view,imageV,imageView;
@synthesize btnArr,btnNameArr,delegate,semllView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithButtonName:(NSMutableArray *)arr
{
    self=[super init];
    self.userInteractionEnabled=YES;
    self.btnArr =[[NSMutableArray alloc]init];
    self.btnNameArr=[[NSMutableArray alloc]init];
    self.btnNameArr=arr;
    self.frame=CGRectMake(100, 100, 45, 45);
    self.image=[UIImage imageNamed:@"pop2"];
    self.isMovedSign=NO;
    PopViewControllerCount *pc=[[PopViewControllerCount alloc]init];
    [pc readData];
    popCount=[[pc.arr objectAtIndex:0] intValue];
    [pc release];
    NSTimer *t;
    t=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(popSemllView) userInfo:nil repeats:NO];
    return self;
}
-(void)popSemllView
{
    if (popCount<1) {
        self.semllView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x-115, self.frame.origin.y-115, 150, 150)];
        semllView.Image=[UIImage imageNamed:@"点击提示"];
        [self.superview addSubview:semllView];
        [semllView release];
        popCount++;
        PopViewControllerCount *pc=[[PopViewControllerCount alloc]init];
        [pc.arr removeAllObjects];
        [pc.arr addObject:[NSNumber numberWithInt:popCount]];
        [pc savaData];
        [pc release];
        
        NSTimer *tt;
        tt=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removePopSemllView) userInfo:nil repeats:NO];
    }
}


-(void)removePopSemllView
{
    [self.semllView removeFromSuperview];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.superview];
    CGPoint point1=[touch previousLocationInView:self.superview];
    self.center=CGPointMake(self.center.x+(point.x-point1.x),self.center.y+(point.y-point1.y) );
    if (isMovedSign==NO) {
        CGPoint p=self.center;
    self.frame=CGRectMake(0, 0, self.frame.size.width*1.2, self.frame.size.height*1.2);
    self.center=p;
    }
    isMovedSign=YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isMovedSign) {
        CGPoint p=self.center;
        self.frame=CGRectMake(0, 0, self.frame.size.width*1/1.2, self.frame.size.height*1/1.2);
        self.center=p;
    }
    else
    {
        
        CABasicAnimation *scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)];//缩放动画
        
        CABasicAnimation *opacityAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.toValue=[NSNumber numberWithFloat:0.0f];//不透明度动画
        
        CAAnimationGroup *animationGroup=[CAAnimationGroup animation];//综合2个动画
        animationGroup.animations=[NSArray arrayWithObjects:scaleAnimation,opacityAnimation, nil];
        animationGroup.duration=0.3;
        animationGroup.fillMode=kCAFillModeForwards;
        
        [self.layer addAnimation:animationGroup forKey:nil];  
        
        self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        self.view.backgroundColor=[UIColor clearColor];
        [self.superview addSubview:self.view];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.view addGestureRecognizer:tap];
        NSTimer *t;
        t=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(giveTime) userInfo:nil repeats:NO];
        
        [self loadMenu];
    }
    isMovedSign=NO;
}
-(void)giveTime
{
    self.alpha=0;
}
-(void)tap
{
   
    [self removeMenu];
}

-(void)loadMenu
{
  self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(self.superview.center.x, self.superview.center.y-20, 0, 0)];
  self.imageV.image=[UIImage imageNamed:@"yuan@2x"];
    self.imageV.alpha=0.75;
    [self.superview addSubview:imageV]; 
    [self.imageV release];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.superview.center.x, self.superview.center.y-20, 0, 0)];
    imageView.image=[UIImage imageNamed:@"Close"];
    [self.superview addSubview:imageView];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.imageV.frame=CGRectMake(self.superview.center.x-90, self.superview.center.y-110, 180, 180);
    imageView.frame=CGRectMake(self.superview.center.x-15, self.superview.center.y-35, 30, 30);
    [UIView commitAnimations];
    
    NSTimer *t;
    t=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(popBtn) userInfo:nil repeats:NO];

}

-(void)popBtn
{
    for (int i=0; i<self.btnNameArr.count; i++) {
        
        A1PopButtons *btn=[[A1PopButtons alloc]initWithImageName:[self.btnNameArr objectAtIndex:i] andTag:i andButtonCounts:self.btnNameArr.count andStartPoint:self.imageV.center];
        [self.superview addSubview:btn]; 
        [self.btnArr  addObject:btn];
        btn.delegate1=self;
        btn.delegate=self.delegate;
        [btn release];
        CAKeyframeAnimation *positionAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=0.4;
        CGMutablePathRef path=CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, btn.startPoint.x, btn.startPoint.y);
        CGPathAddLineToPoint(path, NULL, btn.endPoint.x, btn.endPoint.y);
        CGPathAddLineToPoint(path, NULL, btn.farPoint.x, btn.farPoint.y);
        CGPathAddLineToPoint(path, NULL, btn.endPoint.x, btn.endPoint.y);
        CGPathAddLineToPoint(path, NULL, btn.nearPoint.x, btn.nearPoint.y);
        CGPathAddLineToPoint(path, NULL, btn.endPoint.x, btn.endPoint.y);
        positionAnimation.path=path;
        CGPathRelease(path);
        [btn.layer addAnimation:positionAnimation forKey:nil];
        btn.center=btn.endPoint;
    }
}

-(void)removeMenu
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    self.imageV.frame=CGRectMake(self.superview.center.x, self.superview.center.y-20, 0, 0);
    imageView.frame=CGRectMake(self.superview.center.x, self.superview.center.y-20, 0, 0);
    for (A1PopButtons *btn in self.btnArr) {
        btn.frame=CGRectMake(self.superview.center.x, self.superview.center.y-20, 0, 0);
    }
    [UIView commitAnimations];
    NSTimer *t;
    t=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(removeBtn) userInfo:nil repeats:NO];
}
-(void)removeBtn
{
    for (A1PopButtons *btn in self.btnArr) { 
        [btn removeFromSuperview];
    }
    [self.imageV removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.view removeFromSuperview];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    self.alpha=1;
    [UIView commitAnimations];
}


-(void)shouldRemoveBtn
{
    NSTimer *t;
    t=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(removeMenu) userInfo:nil repeats:NO];
}




@end
















