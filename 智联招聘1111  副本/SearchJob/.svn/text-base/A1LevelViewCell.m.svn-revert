//
//  Cell2.m
//  xiangmu
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1LevelViewCell.h"

@implementation A1LevelViewCell
@synthesize nameLabel,imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 280, 40)];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLabel];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 12, 10, 14)];
        imageView.image = [UIImage imageNamed:@"accessoryArrow.png"];
        [self.contentView addSubview:imageView];

        
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
