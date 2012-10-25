//
//  VIPSalarySearchViewController.h
//  SalarySearch
//
//  Created by david on 12-10-20.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPSelectedTableviewController.h"
#import "MBProgressHUD.h"
@interface VIPSalarySearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,VIPSelectedTableviewControllerDelegate,MBProgressHUDDelegate>

{
    
    MBProgressHUD *HUD;
    NSArray *selextedArrar;//选择项目提示文字数组
    NSArray *tipArray; //提示文字数组
    NSMutableArray *tmpSaveSalaryInfo;
}




@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UITableView *tableview; //表
@property(nonatomic,retain)NSArray *tmpSaveArray; //保存字典的数组
@property(nonatomic,retain)NSArray *itemAllkeys; //保存与服务器交互的所有参数
@property(nonatomic,retain)NSMutableDictionary *prepareItemsForNetWork; //封装用户选择的数据，准备与服务器交互
@property(nonatomic,retain)NSMutableDictionary *prepareItemsWithNameForSalarySearch; //封装用户选择  后面的界面 会显示
- (IBAction)getSalaryInfo:(id)sender;


@end
