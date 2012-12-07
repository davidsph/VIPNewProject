//
//  CityViewController.h
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class A1FirstLevelViewController;
@protocol A1FirstLevelViewControllerDelegate <NSObject>

-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectItem:(NSString *)item;

@end


@interface A1FirstLevelViewController : UITableViewController


@property (nonatomic,retain) NSMutableString * string;

@property (nonatomic,assign) id<A1FirstLevelViewControllerDelegate>delegate;


@property (nonatomic,assign) int selectRow; //判断选择是第几行


@property (nonatomic,retain) NSMutableArray * provienceArr ;//工作地点
@property (nonatomic,retain) NSMutableArray * provienceID ;


@property (nonatomic,retain) NSMutableArray * jobArr ;//行业名称
@property (nonatomic,retain) NSMutableArray * jobIDArr ;


@property (nonatomic,retain) NSMutableArray * industryArr;//职位名称

@property (nonatomic,retain) NSMutableArray * publishDateArr;//发布时间

@property (nonatomic,retain) NSMutableArray * workEXPArr;//工作经验

@property (nonatomic,retain) NSMutableArray * educationArr;//学历要求

@property (nonatomic,retain) NSMutableArray * comptypeArr;//公司性质

@property (nonatomic,retain) NSMutableArray * compsizeArr;//公司规模

@end
