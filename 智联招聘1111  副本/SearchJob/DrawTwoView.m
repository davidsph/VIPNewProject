//
//  DrawTwoView.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawTwoView.h"

@implementation DrawTwoView

@synthesize hArray,vArray;
@synthesize drawArray,drawArray2;
@synthesize salaryArray,salaryArray2;
@synthesize salary;

- (void)dealloc {
    [self.hArray release];
    [self.vArray release];
    
    [self.drawArray release];
    [self.drawArray2 release];
 
    [self.salaryArray release];
    [self.salaryArray2 release];
    
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef  context =UIGraphicsGetCurrentContext();//
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
 
     float basicNumber =[[self.vArray objectAtIndex:0] floatValue];//间隔值

//画第一条线    
    self.drawArray =[[NSArray alloc] 
                     initWithObjects:[NSValue valueWithCGPoint:CGPointMake(25,[[self.salaryArray objectAtIndex:0] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(80,[[self.salaryArray objectAtIndex:1] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(135,[[self.salaryArray objectAtIndex:2] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(190,[[self.salaryArray objectAtIndex:3] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(240,[[self.salaryArray objectAtIndex:4] intValue])], nil];
    
    CGPoint startPoint =[[ self.drawArray objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, 40+startPoint.x, 180-startPoint.y/basicNumber*20);
    
    UIImage *image =[UIImage imageNamed:@"queryPoint.png"];
    
    CGFloat  hOffset =image.size.width/2;
    CGFloat  vOffset =image.size.height/2;
    
    [image drawAtPoint:CGPointMake(40+startPoint.x-hOffset, 180-startPoint.y/basicNumber*20-vOffset)];
    
    for (int i =1; i<5; i++) {
        startPoint =[[self.drawArray objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, 40+startPoint.x, 180-startPoint.y/basicNumber*20);
        
        [image drawAtPoint:CGPointMake(40+startPoint.x-hOffset, 180-startPoint.y/basicNumber*20-vOffset)];
        
    }
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
  //画第二条线  
    self.drawArray2 =[[NSArray alloc] 
                     initWithObjects:[NSValue valueWithCGPoint:CGPointMake(25,[[self.salaryArray2 objectAtIndex:0] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(80,[[self.salaryArray2 objectAtIndex:1] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(135,[[self.salaryArray2 objectAtIndex:2] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(190,[[self.salaryArray2 objectAtIndex:3] intValue])],
                     [NSValue valueWithCGPoint:CGPointMake(240,[[self.salaryArray2 objectAtIndex:4] intValue])], nil];
    
    CGPoint startPoint2 =[[ self.drawArray2 objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, 40+startPoint2.x, 180-startPoint2.y/basicNumber*20);
   
    UIImage  *image2 =[UIImage imageNamed:@"comparePoint.png"];
    CGFloat  hOffset2 =image2.size.width/2;
    CGFloat  vOffset2 =image2.size.height/2;
    
    [image2 drawAtPoint:CGPointMake(40+startPoint2.x-hOffset2, 180-startPoint2.y/basicNumber*20-vOffset2)];
    
    for (int i =1; i<5; i++) {
        startPoint2 =[[self.drawArray2 objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, 40+startPoint2.x, 180-startPoint2.y/basicNumber*20);
        
        [image2 drawAtPoint:CGPointMake(40+startPoint2.x-hOffset2, 180-startPoint2.y/basicNumber*20-vOffset2)];
        
    }
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
    
    [queryFlagImage drawAtPoint:CGPointMake(point.x+40-xOffset, 180-point.y/basicNumber*20-yOffset)];

    
    CGContextStrokePath(context);
}

-(void)initDrawView:(NSArray *)arr andView:(NSArray *)arr2 andSalary:(int)sal
{
    //保存两个存储工资的数组
    self.salaryArray =arr;
    self.salaryArray2 =arr2;
    self.salary =sal;
    
    int basicNumber;
    if ([[self.salaryArray2 objectAtIndex:4] intValue]>[[self.salaryArray objectAtIndex:4]intValue]) {
        if ([[self.salaryArray2 objectAtIndex:0]intValue]>=10000) {
            basicNumber =[[self.salaryArray2 objectAtIndex:0]intValue] /10000*10000;
            if (basicNumber +5000<[[self.salaryArray2 objectAtIndex:0]intValue]) {
                basicNumber +=5000;
            }
            
        }else{
            basicNumber =[[self.salaryArray2 objectAtIndex:0]intValue] /1000*1000;
            if (basicNumber +500<[[self.salaryArray2 objectAtIndex:0]intValue]) {
                basicNumber +=500;
            }
        }
    }else{
        if ([[self.salaryArray objectAtIndex:0]intValue]>=10000) {
            basicNumber =[[self.salaryArray objectAtIndex:0]intValue] /10000*10000;
            if (basicNumber +5000<[[self.salaryArray objectAtIndex:0]intValue]) {
                basicNumber +=5000;
            }
        }else{
            basicNumber =[[self.salaryArray objectAtIndex:0]intValue] /1000*1000;
            
            if (basicNumber +500<[[self.salaryArray objectAtIndex:0]intValue]) {
                basicNumber +=500;
            }
        }
    }
      
    self.vArray =[[NSArray alloc] initWithObjects:[NSNumber numberWithInt: basicNumber],[NSNumber numberWithInt: basicNumber*2],[NSNumber numberWithInt: basicNumber*3],[NSNumber numberWithInt: basicNumber*4],[NSNumber numberWithInt: basicNumber*5], nil];
    
    
    UILabel  *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 26, 40, 20)];
    label.text =@"初次";
    label.backgroundColor =[UIColor clearColor];
    [self addSubview:label];
    [label release];
    
    UILabel  *label2 =[[UILabel alloc] initWithFrame:CGRectMake(0, 49, 40, 20)];
    label2.text =@"比较";
    label2.backgroundColor =[UIColor clearColor];
    [self addSubview:label2];
    [label2 release];

    //标题
    NSArray  *labelFrames1 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 3, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95-4, 3, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(155, 3, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 3, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(265, 3, 55, 20)], nil];
    //初次
    NSArray  *labelFrames2 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 26, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95, 26, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(150, 26, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 26, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(260, 26, 60, 20)], nil];
    //比较
    NSArray  *labelFrames22 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 49, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95, 49, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(150, 49, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 49, 55, 20)],
                             [NSValue valueWithCGRect:CGRectMake(260, 49, 60, 20)], nil];
    NSArray  *labelFrames3 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(40, 180, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(95, 180, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(155, 180, 50, 20)],
                             [NSValue valueWithCGRect:CGRectMake(205, 180, 60, 20)],
                             [NSValue valueWithCGRect:CGRectMake(265, 180, 55, 20)], nil];
    //竖直的五个label,的坐标
    NSArray  *labelFrames4 =[NSArray arrayWithObjects:
                             [NSValue valueWithCGRect:CGRectMake(0, 150, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 130, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 110, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 90, 30, 20)],
                             [NSValue valueWithCGRect:CGRectMake(0, 70, 30, 20)], nil];
    for (int i =0; i<5; i++) {
        UILabel  *label =[[UILabel alloc] initWithFrame:[[labelFrames1 objectAtIndex:i ]CGRectValue]];
        label.text =[self.hArray objectAtIndex:i];
        label.textAlignment =UITextAlignmentCenter;
        label.adjustsFontSizeToFitWidth =YES;
        label.backgroundColor =[UIColor clearColor];
        [self addSubview:label];
        [label release];
    
        //初次
        UILabel  *label2 =[[UILabel alloc] initWithFrame:[[labelFrames2 objectAtIndex:i ]CGRectValue]];
        label2.text =[NSString stringWithFormat:@"¥%@", [arr objectAtIndex:i]];
        label2.textAlignment =UITextAlignmentCenter;
        label2.adjustsFontSizeToFitWidth =YES;
        label2.backgroundColor =[UIColor clearColor];
        [self addSubview:label2];
        [label2 release];
        //比较
        UILabel  *label22 =[[UILabel alloc] initWithFrame:[[labelFrames22 objectAtIndex:i ]CGRectValue]];
        label22.text =[NSString stringWithFormat:@"¥%@", [arr2 objectAtIndex:i]];
        label22.textAlignment =UITextAlignmentCenter;
        label22.adjustsFontSizeToFitWidth =YES;
        label22.backgroundColor =[UIColor clearColor];
        [self addSubview:label22];
        [label22 release];
        
        UILabel  *label3 =[[UILabel alloc] initWithFrame:[[labelFrames3 objectAtIndex:i ]CGRectValue]];
        label3.text =[self.hArray objectAtIndex:i];
        label3.adjustsFontSizeToFitWidth =YES;
        label3.textAlignment =UITextAlignmentCenter;
        label3.backgroundColor =[UIColor clearColor];
        [self addSubview:label3];
        [label3 release];
        
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
