//
//  VIPRegisterViewController.h
//  VIPZL
//
//  Created by Ibokan on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPRegisterViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField *phoneTF;
    UITextField *mailTF;
    UITextField *passTF;
    UITextField *confirmTF;
    UIButton *doneInKeyboardButton;
    UIWindow *tempWindow;
    UIAlertView *doneAlert;
    
}
@property(nonatomic,retain)NSArray *resumeArr;
@property(nonatomic,assign)int tag;

- (NSString *) getMD5String:(NSString *)url ;
-(NSString *)md5:(NSString *)str;


@end
