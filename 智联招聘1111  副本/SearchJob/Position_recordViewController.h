//
//  Position_recordViewController.h
//  Position-record
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "ActivityView.h"

@interface Position_recordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    ActivityView *activityV;
    UITableView *tableV;
    GDataXMLElement *root;
    NSURLConnection *connection;
    NSMutableArray *items;
}

@property(nonatomic,assign) int mm;

@property(nonatomic,retain)NSMutableData *receivedData;
@property(nonatomic,retain)NSArray *recordArr;
@property(nonatomic,retain)UITableView *tableV;
@property(nonatomic,retain)NSMutableArray *items;

@end
