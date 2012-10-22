//
//  CustomCell.m
//  VIPZL
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize label1,label5,label4,label3,label2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bu.frame = CGRectMake(9, 25, 30, 30);
        [self.contentView addSubview:bu];
        label1 = [[UILabel alloc]init];
        label1.frame = CGRectMake(45, 5, 150, 30);
        label1.text = @"市场推广专员";
        [self.contentView addSubview:label1];
        

        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
