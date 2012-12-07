//
//  ShowTableCell.m
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1ShowTableCell.h"

@implementation A1ShowTableCell
@synthesize titleLa,companyLa,detaLa,addressLa,btn;


-(void)dealloc
{
    [self.titleLa release];
    [self.companyLa release];
    [self.detaLa release];
    [self.addressLa release];
    [self.btn release];
    //[super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame=CGRectMake(-8, -1, 57, 57);
        [self.contentView addSubview:self.btn];
        [self.btn release];
        
        self.titleLa=[[UILabel alloc]initWithFrame:CGRectMake(40, 10,156, 21)];
        self.titleLa.backgroundColor=[UIColor clearColor];
        self.titleLa.textAlignment=UITextAlignmentLeft;
        self.titleLa.font=[UIFont fontWithName:@"ArialMT" size:14];
        [self.contentView addSubview:self.titleLa];
        [self.titleLa release];
        
        
        self.companyLa=[[UILabel alloc]initWithFrame:CGRectMake(40, 31, 178, 21)];
        self.companyLa.backgroundColor=[UIColor clearColor];
        self.companyLa.textAlignment=UITextAlignmentLeft;
        self.companyLa.font=[UIFont fontWithName:@"ArialMT" size:12];
        self.companyLa.textColor=[UIColor grayColor];
        [self.contentView addSubview:self.companyLa];
        [self.companyLa release];
        
        UIImageView *accessImageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryArrow"]];
        accessImageV.frame=CGRectMake(300, 21.5, 10, 14);
        [self.contentView addSubview:accessImageV];
        [accessImageV release];
        
        self.detaLa=[[UILabel alloc]initWithFrame:CGRectMake(225, 18, 67, 13)];
        self.detaLa.backgroundColor=[UIColor clearColor];
        self.detaLa.textAlignment=UITextAlignmentRight;
        self.detaLa.textColor=[UIColor grayColor];
        self.detaLa.font=[UIFont fontWithName:@"ArialMT" size:12];
        [self.contentView addSubview:self.detaLa];
        [self.detaLa release];
        
        self.addressLa=[[UILabel alloc]initWithFrame:CGRectMake(250, 31, 42, 21)];
        self.addressLa.backgroundColor=[UIColor clearColor];
        self.addressLa.textAlignment=UITextAlignmentRight;
        self.addressLa.textColor=[UIColor grayColor];
        self.addressLa.font=[UIFont fontWithName:@"ArialMT" size:12];
        [self.contentView addSubview:self.addressLa];
        [self.addressLa release];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"queryResultSelectBg.png"]];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
