//
//  VIPSelectedTableviewController.h
//  VIPZL
//
//  Created by david on 12-10-22.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VIPSelectedTableviewController;
@protocol VIPSelectedTableviewControllerDelegate <NSObject>

//传值协议
- (void)VIPSelectedTableviewController:(VIPSelectedTableviewController *) controller didSelectItem:(NSString *) itemName atSelectIndexPath:(NSIndexPath *) path; 

@end


@interface VIPSelectedTableviewController : UITableViewController
{
    
    NSArray *tmpValueArray;  //字典中的数据
}

@property(nonatomic,retain)NSDictionary *tmpDictionary; //传值字典
@property(nonatomic,retain)NSIndexPath *tmpIndexPath; //传值indexpath
@property(nonatomic,assign)id<VIPSelectedTableviewControllerDelegate> delegate; //代理
@end
