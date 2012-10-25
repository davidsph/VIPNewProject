//
//  CompanyCell.m
//  LogIn
//
//  Created by Ibokan on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
        nameLabel.text = @"北京博看文思有限公司";
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 100, 10)];
        dateLabel.text = @"2012-10-15";
        peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 100, 10)];
        peopleLabel.text = @"20-99人";
        
        [self addSubview:nameLabel];
        [nameLabel release];
        [self addSubview:dateLabel];
        [dateLabel release];
        [self addSubview:peopleLabel];
        [peopleLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
