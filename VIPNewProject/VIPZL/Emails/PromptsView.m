//
//  PromptsView.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PromptsView.h"

@implementation PromptsView

@synthesize promptLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius =5;
        self.backgroundColor =[UIColor blackColor];
       
        
        //label
        self.promptLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.promptLabel.backgroundColor = [UIColor clearColor];
        self.promptLabel.textColor = [UIColor whiteColor];
        self.promptLabel .numberOfLines =2;
        self.promptLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.promptLabel];
        
    }
    return self;
}

-(void)show:(NSString *)showText
{
    if (self.alpha ==0) {
        self.alpha =0.8;//由隐藏变为ban透明
        self.promptLabel.text =showText;
    }
    
}
-(void)hidden
{
    self.alpha =0;//隐藏
}
- (void)dealloc {
    [self.promptLabel release];
    [super dealloc];
}
@end
