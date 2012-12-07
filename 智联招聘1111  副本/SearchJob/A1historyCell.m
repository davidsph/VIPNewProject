//
//  A1historyCell.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1historyCell.h"
#define FONT_SIZE 14.0f
@implementation A1historyCell

@synthesize firstLabel;
@synthesize sencondLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        firstLabel.lineBreakMode = UILineBreakModeWordWrap;
        firstLabel.textAlignment = UITextAlignmentLeft;
        firstLabel.font = [UIFont systemFontOfSize:15];
        firstLabel.numberOfLines = 0;
        firstLabel.minimumFontSize = FONT_SIZE;
        firstLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        firstLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:firstLabel];
        [firstLabel release];
        
        sencondLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 35, 300, 25)];
        sencondLabel.textAlignment = UITextAlignmentLeft;
        sencondLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:sencondLabel];
        [sencondLabel release];
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
