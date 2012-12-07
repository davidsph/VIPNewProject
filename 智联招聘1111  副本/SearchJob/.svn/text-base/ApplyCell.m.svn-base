//
//  ApplyCell.m
//  Real-time recommend
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ApplyCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ApplyCell

@synthesize btn,titleLabel,companyLabel,ratioLabel,dateLabel,cityLabel;

-(void)dealloc
{
    [titleLabel release];
    [companyLabel release];
    [ratioLabel release];
    [dateLabel release];
    [cityLabel release];
    [super dealloc];
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5, 14, 30, 30);
        [[btn layer] setCornerRadius:15.0];
        [self.contentView addSubview:btn];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 170, 30)];
        titleLabel.highlightedTextColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        titleLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域
        [self.contentView addSubview:titleLabel];
        
        companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 35, 170, 15)];
        companyLabel.highlightedTextColor = [UIColor blackColor];
        companyLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        companyLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域        
        companyLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:companyLabel];
        
        ratioLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 55, 170, 15)];
        ratioLabel.highlightedTextColor = [UIColor blackColor];
        ratioLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        ratioLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域        
        ratioLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:ratioLabel];        
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 60, 30)];
        dateLabel.highlightedTextColor = [UIColor blackColor];
        dateLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
        dateLabel.backgroundColor = [UIColor clearColor];//设置为透明色，否则在label区域会呈现不一样的白色区域        
        dateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:dateLabel];        
        
        cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 35, 60, 15)];
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
