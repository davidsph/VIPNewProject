//
//  Cell.m
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1FindJobViewCell.h"

@implementation A1FindJobViewCell
@synthesize advancedName,grayName,imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        advancedName = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 100, 40)];
        advancedName.textAlignment = UITextAlignmentLeft;
        advancedName.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:advancedName];
        [advancedName release];
        
        grayName = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 150, 40)];
        grayName.textColor = [UIColor grayColor];
        grayName.backgroundColor = [UIColor clearColor];
        grayName.font = [UIFont systemFontOfSize:15];
        grayName.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:grayName];
        [grayName release];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 12, 10, 14)];
        imageView.image = [UIImage imageNamed:@"accessoryArrow.png"];
        [self.contentView addSubview:imageView];
        [imageView release];
        
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
