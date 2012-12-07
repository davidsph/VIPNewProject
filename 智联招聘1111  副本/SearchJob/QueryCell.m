//
//  QueryCell.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryCell.h"

@implementation QueryCell

@synthesize cityLabel2,industryLabel2,corppropertyLabel2,jobcatLabel2,joblevelOrEducationLabel,joblevelOrEducationLabel2,salaryLabel2;

- (void)dealloc {
    
    [cityLabel release];
    [industryLabel release];
    [corppropertyLabel release];
    [jobcatLabel release];
    [salaryLabel release];
    
    [self.cityLabel2 release];
    [self.industryLabel2 release];
    [self.jobcatLabel2 release];
    [self.salaryLabel2 release];
    
    [self.joblevelOrEducationLabel release];
    [self.joblevelOrEducationLabel2 release];
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //统一设置字体大小为系统15号大小
        cityLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 75, 20)];
        cityLabel.text =@"地区:";
        cityLabel.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:cityLabel];
        
        industryLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 20, 75, 20)];
        industryLabel.font =[UIFont systemFontOfSize:15];
        industryLabel.text =@"行业:";
        [self.contentView addSubview:industryLabel];
        
        corppropertyLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 40, 75, 20)];
        corppropertyLabel.text =@"企业性质:";
        corppropertyLabel.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:corppropertyLabel];
        
        jobcatLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 60, 75, 20)];
        jobcatLabel.text =@"职位类别:";
        jobcatLabel.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:jobcatLabel];
        
        self.joblevelOrEducationLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 80, 75, 20)];
        joblevelOrEducationLabel.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.joblevelOrEducationLabel];
        
        salaryLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 100, 75, 20)];
        salaryLabel.text =@"期望月薪:";
        salaryLabel.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:salaryLabel];
                
        self.cityLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 0, 220, 20)];
        self.cityLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.cityLabel2];
        
        self.industryLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 20, 220, 20)];
        self.industryLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.industryLabel2];
        
        self.corppropertyLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 40, 220, 20)];
        self.corppropertyLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.corppropertyLabel2];
        
        self.jobcatLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 60, 220, 20)];
        self.jobcatLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.jobcatLabel2];
        
        self.joblevelOrEducationLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 80, 220, 20)];
        self.joblevelOrEducationLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.joblevelOrEducationLabel2];
        
        self.salaryLabel2 =[[UILabel alloc] initWithFrame:CGRectMake(90, 100, 220, 20)];
        self.salaryLabel2.font =[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.salaryLabel2];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
