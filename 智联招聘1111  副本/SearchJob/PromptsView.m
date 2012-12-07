//
//  PromptsView.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PromptsView.h"

@implementation PromptsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius =5;
        self.backgroundColor =[UIColor blackColor];
       
        
        //label
        promptLabel = [[UILabel alloc] initWithFrame:self.bounds];
        promptLabel.backgroundColor = [UIColor clearColor];
       promptLabel.textColor = [UIColor whiteColor];
        promptLabel .numberOfLines =2;
        promptLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:promptLabel];
        
    }
    return self;
}

-(void)show:(NSString *)showText
{
    if (self.alpha ==0) {
        self.alpha =0.8;//由隐藏变为ban透明
        promptLabel.text =showText;
    }
    
}
-(void)hidden
{
    self.alpha =0;//隐藏
}
- (void)dealloc {
    [promptLabel release];
    [super dealloc];
}
@end
