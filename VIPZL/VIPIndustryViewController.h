//
//  VIPIndustryViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndustryProtocl <NSObject>
- (void)sentIndustry:(NSString *)selectedIndustry;
@end

@interface VIPIndustryViewController : UITableViewController
{
    NSArray *array;
}
@property(nonatomic,retain) id <IndustryProtocl>delegate;
@end
