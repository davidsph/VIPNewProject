//
//  A1ShowJob.h
//  A1ShowJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1Job.h"
#import "JobDetails.h"
#import "ApplyProcess.h"
#import "ApplyProcessProtocol.h"


@interface A1ShowJob : UIViewController<UIAlertViewDelegate>
{
    UISegmentedControl *segControl;
    UIView *otherJobView;
    
    UITextView *textView;
    UILabel *titleLable;
    UILabel *scaleLable;
    UILabel *locationLable;
    UILabel *experienceLable;
    UILabel *numLable;
}

@property (retain ,nonatomic) id delegate;
@property (assign ,nonatomic) int applyTapnumber;

@property (retain,nonatomic)A1Job *job;
@property (retain,nonatomic)JobDetails *jD;

@end
