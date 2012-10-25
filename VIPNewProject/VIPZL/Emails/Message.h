//
//  Message.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property(nonatomic,retain)NSString *subject;
@property(nonatomic,retain)NSString *companyName;
@property(nonatomic,retain)NSString *companyNumber;
@property(nonatomic,retain)NSString *emailDate;
@property(nonatomic,retain)NSString *emailNumber;
@property(nonatomic,retain)NSString *isRead;
@end
