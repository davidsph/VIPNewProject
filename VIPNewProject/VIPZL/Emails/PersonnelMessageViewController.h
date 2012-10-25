//
//  PersonnelMessageViewController.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"


@interface PersonnelMessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    
    NSURLConnection *connection;
    NSMutableArray *messageArray;
    GDataXMLElement *root;
    UITableView *tableTV;
    
}
@property(nonatomic,retain)NSString *uTicket;
@property(nonatomic,retain)NSMutableData *messageData;
-(void)setEmail;
-(void)setURL:(NSString *)string;
@end
