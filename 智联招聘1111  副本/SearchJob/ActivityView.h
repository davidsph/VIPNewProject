//
//  ActivityView.h
//  Real-time recommend
//
//  Created by Ibokan on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIActivityIndicatorView *activi;

- (void)show;
- (void)hidden;

@end
