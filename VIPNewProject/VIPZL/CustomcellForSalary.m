//
//  CustomcellForSalary.m
//  SalarySearch
//
//  Created by david on 12-10-20.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "CustomcellForSalary.h"

@implementation CustomcellForSalary
@synthesize selectedLabel;
@synthesize tipTextField;
@synthesize stateImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [selectedLabel release];
    [tipTextField release];
    [stateImageView release];
    [super dealloc];
}
@end
