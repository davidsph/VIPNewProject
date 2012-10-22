//
//  VIPSearchOptionViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchOptionProtocl <NSObject>
- (void)sentOption:(NSString *)selectedOption;
@end

@interface VIPSearchOptionViewController : UITableViewController
{
    NSArray *array;
}
@property(nonatomic,assign)int tag;
@property(nonatomic,retain)id<SearchOptionProtocl>delegate;
@end
