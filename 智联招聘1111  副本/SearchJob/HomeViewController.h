//
//  HomeViewController.h
//  SearchAndSubscribe
//
//  Created by Ibokan on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityView.h"

@interface HomeViewController : UIViewController <UISearchBarDelegate>
{
    UIAlertView *loginAlertV;
    ActivityView *activityV;
}
- (IBAction)PushToSearchJob:(id)sender;
- (IBAction)PushToPersonMessage:(id)sender;
- (IBAction)PushToMyZhiLian:(id)sender;
- (IBAction)PushToSalaryQuery:(id)sender;
- (IBAction)PushToJobGuide:(id)sender;
- (IBAction)PushToReal_time:(id)sender;
- (IBAction)PushToSetting:(id)sender;
- (IBAction)PushToFavicons:(id)sender;
- (IBAction)PushToRecord:(id)sender;
- (NSString *)filePath;

@end
