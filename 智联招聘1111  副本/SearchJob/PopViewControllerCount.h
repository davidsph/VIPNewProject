//
//  PopViewControllerCount.h
//  testMenu
//
//  Created by Ibokan on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopViewControllerCount : NSObject
@property (retain,nonatomic)NSMutableArray *arr;

- (NSString *)filePath;
- (void)readData;
- (void)savaData;
@end
