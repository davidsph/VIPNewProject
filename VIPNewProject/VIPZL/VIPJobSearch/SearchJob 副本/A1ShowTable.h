//
//  ShowTable.h
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1ShowTableCell.h"
#import "A1Job.h"
#import "SearchJob.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplyProcessProtocol.h"
#import "ApplyProcess.h"

@interface A1ShowTable : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
    int count;
    BOOL selectedSign;//是否已选中的标记位
    BOOL loadingMoreSign;//是否允许加载更多
    BOOL LoadingSign;//是否正在加载
    int pickSelectNumber;
    
    UIImageView *img;//小三角
    UIView *viewShow;//显示搜索器视图
    UITextField *searchNameTF;//用来输入搜索器名字的
    UITextView *textView;//用来显示条件的
}

@property (nonatomic ,retain) NSString *recordSearcherName;//用来记录搜索器名字的
//

@property (retain,nonatomic)UIActionSheet *actionSheet;
@property (assign,nonatomic)int dataSourseSign;//为1时为快速搜索，为2时为高级搜索，为3时为相似职位
@property (retain,nonatomic)NSMutableArray *selectArr;
@property (retain,nonatomic)NSMutableArray *allJobArr;
@property (retain,nonatomic)NSMutableArray *pickArr;
@property (retain,nonatomic)UIView *headV;
@property (retain,nonatomic)SearchJob *searchjob;//搜索用的属性
@property (retain,nonatomic)NSString *jobNumber;//相似职位用的属性
@property (retain,nonatomic)UILabel *loadMoreLa;//加载更多的显示框

@property (nonatomic,retain)id delegate;


-(void)loadMore;//下拉加载更多

//点击头视图的触发方法
-(void)doTap;
//点击保存搜索器的按钮触发的方法
-(void)savedSearcher;


@end
