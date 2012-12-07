//
//  Real_time_recommendViewController.h
//  Real-time recommend
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "ActivityView.h"
#import "ApplyProcessProtocol.h"
#import "ApplyProcess.h"

@interface Real_time_recommendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    ActivityView *activityV;
    UIAlertView *loginAlertV;
    GDataXMLElement *root;
    NSMutableArray *selectJob;
    NSURLConnection *connection;
    UIAlertView *alertV;
    UITableView *tableV1;
    UITableView *tableV2;
    int a; 
    BOOL c;
}

@property(nonatomic,retain)NSMutableData *receivedData;
@property(nonatomic,retain)id delegate;
@property(nonatomic,retain)NSString *uTicket;

@end
