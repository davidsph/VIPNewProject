//
//  Asvanced.h
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1SecondLevelViewController.h"
#import "A1FirstLevelViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
@interface A1FindJobViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,A1SecondLevelViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,A1FirstLevelViewControllerDelegate,UITextFieldDelegate,UISearchBarDelegate,UIAlertViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray * grayArr;
    NSMutableArray * advancedArr;
    NSMutableArray * historyArr;
    NSMutableArray * originAdvancedGrayArr;
    NSMutableArray * originQuickGrayArr;
    
    NSString *pickerValues;//pickerView输入的值
    
    int selectedRow;
    
    UIActionSheet *actionSheet;
    
    UISearchBar * searchBar;
    
    NSMutableArray * dataArr;
        
    UIActionSheet * sheet;
    
    UIImageView * viewsort;
    
    UIButton * delButton;
}
@property (retain,nonatomic)NSMutableArray *grayArr, *advancedArr,*historyArr,*historyArrList;
@property(nonatomic,retain)NSMutableArray *contents;
@property (nonatomic,retain) UITextField * textField_;

@property(nonatomic,assign)BOOL historyMark;
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic,retain)CLLocation *checkinLocation;
@property (nonatomic,retain) NSMutableDictionary * allDataDic;

@property (nonatomic,retain) NSString *  databaseStr;//保存每一次的记录

-(void)changeHistoryArrList;
-(void)historyStretch;
//hoistory文件存储的路径
//- (NSString *)filePath;
@end
