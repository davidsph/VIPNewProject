//
//  DetailEmailViewController.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import <MessageUI/MessageUI.h>

@interface DetailEmailViewController : UIViewController<NSURLConnectionDataDelegate,MFMailComposeViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *fromLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UITextView *emailContent;
@property(nonatomic,retain)NSString *emailNum;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,retain)NSString *uticket;
@property(nonatomic,retain)NSMutableData *emailData;

-(void)setURL:(NSString *)string;
@end
