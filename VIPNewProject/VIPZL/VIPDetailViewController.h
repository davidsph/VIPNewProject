//
//  VIPDetailViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailProtocl <NSObject>

- (void)sent:(NSString *)message tag:(int)tag1;

@end

@interface VIPDetailViewController : UITableViewController

{
    NSArray *array;
}
@property(nonatomic,assign)int tag,theRow;
@property(nonatomic,retain)id<DetailProtocl>delegate;
@end
