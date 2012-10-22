//
//  VIPLoginViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginWithAccount.h"

@interface VIPLoginViewController : UIViewController<LoginErrorProtocol,UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UITextField *accountTextField;
@property (retain, nonatomic) IBOutlet UITextField *passWordTextField;
- (IBAction)clickLogIn:(id)sender;
- (IBAction)clickRegister:(id)sender;

@end
