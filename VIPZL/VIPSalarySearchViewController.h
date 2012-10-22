//
//  VIPSalarySearchViewController.h
//  SalarySearch
//
//  Created by david on 12-10-20.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPSalarySearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    NSArray *selextedArrar;
    NSArray *tipArray;
    
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@end
