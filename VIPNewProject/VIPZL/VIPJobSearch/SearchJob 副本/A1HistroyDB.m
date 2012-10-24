//
//  A1HistroyDB.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1HistroyDB.h"

@implementation A1HistroyDB
static sqlite3 * db = nil;
+(sqlite3 *)openDB
{
    if (db) {
        return db;
    }
    //判断doc里有无数据库文件没有就拷贝过去
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [docPath stringByAppendingPathComponent:@"history.sqlite"];

    
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]==NO) {
        NSString * bundleFile=[[NSBundle mainBundle]pathForResource:@"history1" ofType:@"sqlite"];
        NSError * err=nil;
        if ([fm copyItemAtPath:bundleFile toPath:filePath error:&err]) {
            NSLog(@"%@",[err localizedDescription]);
        }
    }

    sqlite3_open([filePath UTF8String], &db);
    return db;
}
+(void)closeDB
{
    if (db) {
        sqlite3_close(db);
    }
}

@end
