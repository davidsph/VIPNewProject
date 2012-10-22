//
//  SecOptionCell.m
//  VIPZL
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecOptionCell.h"

@implementation SecOptionCell
@synthesize optionLabel = _optionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _optionLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 13, 150, 25)];
        _optionLabel.backgroundColor = [UIColor clearColor];
        _optionLabel.textColor = [UIColor grayColor];
        _optionLabel.font = [UIFont fontWithName:@"HiraMinProN-W3" size:14];
        _optionLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_optionLabel];
        [_optionLabel release];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 15, 15)];
        imgV.image = [UIImage imageNamed:@"accessoryArrow@2x.png"];
        [self addSubview:imgV];
        [imgV release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
