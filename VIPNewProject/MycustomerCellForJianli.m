//
//  MycustomerCellForJianli.m
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "MycustomerCellForJianli.h"

@implementation MycustomerCellForJianli
@synthesize selectedButtonState;
@synthesize companySize;
@synthesize companyName;
@synthesize companyLocation;
@synthesize date_show;
@synthesize rightSideImageView;

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
    [selectedButtonState release];
    [companySize release];
    [companyName release];
    [companyLocation release];
    [date_show release];
    [rightSideImageView release];
    [super dealloc];
}
@end
