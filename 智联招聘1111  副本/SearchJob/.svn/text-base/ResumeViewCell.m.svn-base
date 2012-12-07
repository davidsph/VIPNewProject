//
//  ResumeViewCell.m
//  LogIn
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResumeViewCell.h"

@implementation ResumeViewCell
@synthesize imgv1 = _imgv1,nameLabel = _nameLabel,countLabel = _countLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imgv1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 30, 20)];
        _imgv1.backgroundColor = [UIColor clearColor];
        [self addSubview:_imgv1];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 6, 130, 30)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_nameLabel];
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 8, 40, 30)];
        //_countLabel.text = @"50";
//        UIImage *img = [UIImage imageNamed:@"accessoryArrow@2x.png"];
//        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];
//        imgv.image = img;
//        _countLabel.backgroundColor = [UIColor clearColor];
//        [_countLabel addSubview:imgv];
//        [imgv release];
        
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
