//
//  PopPromptViewCount.h
//  SearchJob
//
//  Created by Ibokan on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopPromptViewCount : NSObject
@property (retain,nonatomic)NSMutableArray *arr;

- (NSString *)filePath;
- (void)readData;
- (void)savaData;
@end
