//
//  MessageCell.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize imageView,companyLabel,resumeLabel,dateLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 25, 25)];
        [self.contentView addSubview:imageView];
        
        self.resumeLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 180, 30)];
        [self.contentView addSubview:resumeLabel];
        self.resumeLabel.backgroundColor=[UIColor clearColor];
        
        self.companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 40, 180, 15)];
        self.companyLabel.font=[UIFont fontWithName:@"Arial" size:12.0];
        self.companyLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:companyLabel];
        
        self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(240, 40, 65, 15)];
        self.dateLabel.font=[UIFont fontWithName:@"Arial" size:12.0];
        self.dateLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:dateLabel];
    }
    return self;
}

-(void)dealloc{
    
    [imageView release];
    [companyLabel release];
    [resumeLabel release];
    [dateLabel release];
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
