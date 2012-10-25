//
//  VIPTableFootView.m
//  求职指导
//
//  Created by Ibokan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPTableFootView.h"

@implementation VIPTableFootView
@synthesize activityIndicator,infoLabel,endView;

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.frame=CGRectMake(0, 0, 320, 50);
        self.infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        self.infoLabel.text=@"加载中...";
        self.infoLabel.textColor=[UIColor redColor];
        self.infoLabel.backgroundColor=[UIColor clearColor];
        self.activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(50, 15, 20, 20)];
        [self addSubview:self.infoLabel];
        [self addSubview:self.activityIndicator];
       }
    return self;
}
-(void)awakeFromNib
{
    self.backgroundColor=[UIColor brownColor];
    [super awakeFromNib];
}
-(void)dealloc
{
    [activityIndicator release];
    [infoLabel release];
    [super release];
}

@end
