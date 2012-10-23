//
//  VIPSearchOptionViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchOptionProtocol <NSObject>
- (void)sentOption:(NSString *)selectedOption tag:(int)tag;
@end

@interface VIPSearchOptionViewController : UITableViewController
{
    NSArray *array;
}
@property(nonatomic,retain)id<SearchOptionProtocol>delegate;
@property(nonatomic,assign)int tag;

@end
