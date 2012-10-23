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

- (void)VIPSelectedTableviewController:(VIPSelectedTableviewController *) controller didSelectItem:(NSString *) itemName atSelectIndexPath:(NSIndexPath *) path; 

@end


@interface VIPSelectedTableviewController : UITableViewController
{
    
    NSArray *tmpValueArray;
}

@property(nonatomic,retain)NSDictionary *tmpDictionary;
@property(nonatomic,retain)NSIndexPath *tmpIndexPath;
@property(nonatomic,assign)id<VIPSelectedTableviewControllerDelegate> delegate;
@end
