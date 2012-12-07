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
#import "A1PopMenuPro.h"
#import "EGORefreshTableHeaderView.h"

@interface A1ShowTable : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,A1PopMenuPro,EGORefreshTableHeaderDelegate>
{
    
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    
    int popMenuSign;
    BOOL selectedSign;//是否已选中的标记位
    BOOL loadingMoreSign;//是否允许加载更多
    BOOL LoadingSign;//是否正在加载
    
    UITextField *searchNameFid;//输入搜索器名字的
    UIView *saveSearchView;//用来显示的
    UITextView *textView;//显示条件的
}
@property (assign,nonatomic)int count;
@property (nonatomic ,retain) NSString *recordSearcherName;//用来记录搜索器名字的
@property (retain,nonatomic)UITableView *tableView;
@property (retain,nonatomic)UIActionSheet *actionSheet;
@property (assign,nonatomic)int dataSourseSign;//为1时为快速搜索，为2时为高级搜索，为3时为相似职位
@property (retain,nonatomic)NSMutableArray *selectArr;
@property (retain,nonatomic)NSMutableArray *allJobArr;
@property (retain,nonatomic)SearchJob *searchjob;//搜索用的属性
@property (retain,nonatomic)NSString *jobNumber;//相似职位用的属性
@property (retain,nonatomic)UILabel *loadMoreLa;//加载更多的显示框

@property (nonatomic,retain)id delegate;

-(void)apply;//申请职位
-(void)loadMore;//下拉加载更多
-(void)savedSearcher;//保存职位搜索器

-(void)cancel;//用来取消的方法


@end
