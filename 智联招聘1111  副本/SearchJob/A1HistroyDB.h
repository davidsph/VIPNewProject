//
//  A1HistroyDB.h
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface A1HistroyDB : NSObject
+(sqlite3 *)openDB;
+(void)closeDB;
@end
