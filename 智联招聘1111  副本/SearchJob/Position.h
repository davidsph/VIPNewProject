//
//  Position.h
//  SearchJob
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject
@property (nonatomic,retain)NSString *jobNumber;
@property(nonatomic,retain)NSString *jobTitle;
@property(nonatomic,retain)NSString *jobCity;
@property(nonatomic,retain)NSString *applyCount;
@property(nonatomic,retain)NSString *companyNumber;
@property(nonatomic,retain)NSString *companyName;

@end
