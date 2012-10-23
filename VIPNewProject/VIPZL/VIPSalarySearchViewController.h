//
//  VIPSalarySearchViewController.h
//  SalarySearch
//
//  Created by david on 12-10-20.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPSelectedTableviewController.h"
@interface VIPSalarySearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,VIPSelectedTableviewControllerDelegate>

{
    NSArray *selextedArrar;
    NSArray *tipArray;
    
    
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSArray *tmpSaveArray; //保存字典的数组
@property(nonatomic,retain)NSArray *itemAllkeys; //保存与服务器交互的所有参数
@property(nonatomic,retain)NSMutableDictionary *prepareItemsForNetWork;

- (IBAction)getSalaryInfo:(id)sender;


@end
