//
//  PositionFavoriteViewController.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "ActivityView.h"
#import "ApplyProcessProtocol.h"
#import "ApplyProcess.h"
@interface PositionFavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    ActivityView *activityV;
    NSMutableArray *jobArray;//盛放的job结点的数组
    NSMutableArray *selectJob;
    UITableView *tableV;
    NSString *uTicket;//等待传参数
    NSMutableArray *positionArray;
    int a;
}
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,retain)NSMutableData *favoriteData;
@property(nonatomic,retain)GDataXMLElement *root;
@property (nonatomic,assign)id delegate;

-(void)setURL:(NSString *)string;
-(void)setPosition;
@end
