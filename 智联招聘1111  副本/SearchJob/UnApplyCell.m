//
//  UnApplyCell.m
//  Real-time recommend
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UnApplyCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation UnApplyCell

@synthesize btn,titleLabel,companyLabel,cityLabel;

-(void)dealloc
{
    [titleLabel release];
    [companyLabel release];
    [cityLabel release];
    [super dealloc];
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5, 20, 30, 30);
        [[btn layer] setCornerRadius:15.0];
        [self.contentView addSubview:btn];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 170, 35)];
        titleLabel.highlightedTextColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        titleLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域
        [self.contentView addSubview:titleLabel];
        
        companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, 170, 25)];
        companyLabel.highlightedTextColor = [UIColor blackColor];
        companyLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        companyLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域        
        companyLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:companyLabel];
        
        cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 40, 60, 25)];
        cityLabel.highlightedTextColor = [UIColor blackColor];                
        cityLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        cityLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域        
        cityLabel.textColor = [UIColor grayColor];
        cityLabel.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:cityLabel];
        
    }
    return self;
}

@end
