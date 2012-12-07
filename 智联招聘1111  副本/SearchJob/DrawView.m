//
//  DrawView.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

@synthesize hArray,vArray,drawArray;
@synthesize salaryArr;
@synthesize salary;

- (void)dealloc {
    [self.hArray release];
    [self.vArray release];
    [self.drawArray release];
    [self.salaryArr release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        vInterval =20;
        
       self. hArray =[[NSArray alloc] initWithObjects:@"低端",@"中低端",@"中端",@"中高端",@"高端", nil];//水平轴的标签
    }
    return self;
}

//#define ZeroPoint CGPointMake(40,160)

- (void)drawRect:(CGRect)rect
{
    CGContextRef  context =UIGraphicsGetCurrentContext();//
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
   
    float basicNumber =[[self.vArray objectAtIndex:0] floatValue];//竖直间隔值
    
        self.drawArray =[[NSArray alloc] 
                     initWithObjects:[NSValue valueWithCGPoint:CGPointMake(25,[[self.salaryArr objectAtIndex:0] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(80,[[self.salaryArr objectAtIndex:1] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(135,[[self.salaryArr objectAtIndex:2] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(190,[[self.salaryArr objectAtIndex:3] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(240,[[self.salaryArr objectAtIndex:4] intValue])], nil];
    
    //先画用户输入的薪水所在点，后画每个坐标点的一个小圆圈，最后画线
    UIImage  *queryFlagImage =[UIImage imageNamed:@"queryFlag.png"];
    
    CGFloat xOffset =queryFlagImage .size.width/2;
    CGFloat yOffset =queryFlagImage.size.height;
    
    CGPoint point;
    
    if (self.salary <(int)basicNumber) {
        point =CGPointMake(25, self.salary);
    }else
        if (self.salary <[[self.vArray objectAtIndex:1]intValue]) {
            point =CGPointMake(80, self.salary);
        }else
            if (self.salary <[[self.vArray objectAtIndex:2]intValue]) {
                point =CGPointMake(135, self.salary);
            }else
                if (self.salary <[[self.vArray objectAtIndex:3]intValue]) {
                    point =CGPointMake(190, self.salary);
                }else
                    if (self.salary <[[self.vArray objectAtIndex:4]intValue]) {
                        point =CGPointMake(240, self.salary);
                    }else
                        point =CGPointMake(270, [[self.vArray objectAtIndex:4] intValue]);//大于所有值
    
    [queryFlagImage drawAtPoint:CGPointMake(point.x+40-xOffset, 160-point.y/basicNumber*20-yOffset)];
    
    CGPoint startPoint =[[ self.drawArray objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, 40+startPoint.x, 160-startPoint.y/basicNumber*20);
    
    UIImage *image =[UIImage imageNamed:@"queryPoint.png"];
    
    CGFloat  hOffset =image.size.width/2;
    CGFloat  vOffset =image.size.height/2;
    
    [image drawAtPoint:CGPointMake(40+startPoint.x-hOffset, 160-startPoint.y/basicNumber*20-vOffset)];
    
    for (int i =1; i<5; i++) {
        
        startPoint =[[self.drawArray objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, 40+startPoint.x, 160-startPoint.y/basicNumber*20);
        
        [image drawAtPoint:CGPointMake(40+startPoint.x-hOffset, 160-startPoint.y/basicNumber*20-vOffset)];
    }
    
    CGContextStrokePath(context);
}


-(void)initDrawView:(NSArray *)arr andSalary:(int)sal
{
    self.salaryArr =arr;//保存值
    self.salary =sal;//保存自己输入的值
    
    int basicNumber;
    if ([[self.salaryArr objectAtIndex:0]intValue]>=10000) {
        basicNumber =[[self.salaryArr objectAtIndex:0]intValue] /10000*10000;
        //判断一下是否要对基本分割值做一下调整
        if ((basicNumber+5000)<[[self.salaryArr objectAtIndex:0] intValue]) {
            basicNumber =basicNumber +5000;
        }
    }else{
        basicNumber =[[self.salaryArr objectAtIndex:0]intValue] /1000*1000;
        if ((basicNumber+500)<[[self.salaryArr objectAtIndex:0]intValue]) {
            basicNumber =basicNumber +500;
        }
    }
    
    //存放五个竖坐标的值
    self.vArray =[[NSArray alloc] initWithObjects:[NSNumber numberWithInt: basicNumber],[NSNumber numberWithInt: basicNumber*2],[NSNumber numberWithInt: basicNumber*3],[NSNumber numberWithInt: basicNumber*4],[NSNumber numberWithInt: basicNumber*5], nil];
    
    
        
    UILabel  *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 27, 40, 20)];
    label.text =@"月薪";
    label.backgroundColor =[UIColor clearColor];
    [self addSubview:label];
    [label release];

    //各个标签的相应坐标
    //横一
    NSArray  *labelFrames1 =[NSArray arrayWithObjects:
                            [NSValue valueWithCGRect:CGRectMake(40, 5, 50, 20)],
                            [NSValue valueWithCGRect:CGRectMake(95-4, 5, 60, 20)],
                            [NSValue valueWithCGRect:CGRectMake(155, 5, 50, 20)],
                            [NSValue valueWithCGRect:CGRectMake(205, 5, 60, 20)],
                            [NSValue valueWithCGRect:CGRectMake(265, 5, 55, 20)], nil];
    //横二
    NSArray  *labelFrames2 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 27, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95, 27, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(150, 27, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 27, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(260, 27, 60, 20)], nil];
    //横三
    NSArray  *labelFrames3 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 160, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95, 160, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(155, 160, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 160, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(265, 160, 55, 20)], nil];
    //竖直的五个label,的坐标
    NSArray  *labelFrames4 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(0, 130, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 110, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 90, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 70, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 50, 30, 20)], nil];
    
    for (int i =0; i<5; i++) {
        //横一标签值
        UILabel  *label =[[UILabel alloc] initWithFrame:[[labelFrames1 objectAtIndex:i ]CGRectValue]];
        label.text =[self.hArray objectAtIndex:i];
        label.textAlignment =UITextAlignmentCenter;
        label.adjustsFontSizeToFitWidth =YES;
        label.backgroundColor =[UIColor clearColor];
        [self addSubview:label];
        [label release];
        //横二标签值
        UILabel  *label2 =[[UILabel alloc] initWithFrame:[[labelFrames2 objectAtIndex:i ]CGRectValue]];
        label2.text =[NSString stringWithFormat:@"¥%@", [arr objectAtIndex:i]];
        label2.textAlignment =UITextAlignmentCenter;
        label2.adjustsFontSizeToFitWidth =YES;
        label2.backgroundColor =[UIColor clearColor];
        [self addSubview:label2];
        [label2 release];
        //横三标签值
        UILabel  *label3 =[[UILabel alloc] initWithFrame:[[labelFrames3 objectAtIndex:i ]CGRectValue]];
        label3.text =[self.hArray objectAtIndex:i];
        label3.adjustsFontSizeToFitWidth =YES;
        label3.textAlignment =UITextAlignmentCenter;
        label3.backgroundColor =[UIColor clearColor];
        [self addSubview:label3];
        [label3 release];
        //竖直坐标标签值
        UILabel  *label4 =[[UILabel alloc] initWithFrame:[[labelFrames4 objectAtIndex:i ]CGRectValue]];
        label4.text =[NSString stringWithFormat:@"%@",[self.vArray objectAtIndex:i]];
        label4.textAlignment =UITextAlignmentCenter;
        label4.adjustsFontSizeToFitWidth =YES;
        label4.backgroundColor =[UIColor clearColor];
        [self addSubview:label4];
        [label4 release];
    }

}

@end
