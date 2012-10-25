//
//  CompanListInfoViewController.h
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Resume;

@interface CompanListInfoViewController : UITableViewController
{
    
    NSMutableSet *selectedBns;
    NSMutableArray *selectedCompany;
    NSArray * companyArray;
}
@property(nonatomic,retain)Resume *resumeItemsOfCompany;
@end

