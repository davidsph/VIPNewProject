//
//  DetailedCityViewController.h
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class A1SecondLevelViewController;
@protocol A1SecondLevelViewControllerDelegate <NSObject>

-(void)A1SecondLevelViewController:(A1SecondLevelViewController *)controller didSelectTown:(NSString *)town;
-(void)A1SecondLevelViewController:(A1SecondLevelViewController *)controller didSelectJob:(NSString *)job;

@end


@interface A1SecondLevelViewController : UITableViewController
{
    NSString * strID;
}

@property(nonatomic,retain) NSString * string;
@property(nonatomic,retain) NSMutableArray * townArr;
@property(nonatomic,assign) int sendID;//判断在cityViewController中点击的是一行
@property(nonatomic,assign) int sendPreviousID;//判断在Asvanced中点击的哪一行

@property(nonatomic,retain) NSMutableArray * proArr;
@property(nonatomic,retain) NSMutableArray * jobIDArr;

@property(nonatomic,retain) NSMutableArray * smallJobArr;
@property(nonatomic,retain) NSMutableArray * jobID;

@property (nonatomic, assign) id <A1SecondLevelViewControllerDelegate>delegate;

@end
