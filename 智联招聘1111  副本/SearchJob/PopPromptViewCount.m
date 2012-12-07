//
//  PopPromptViewCount.m
//  SearchJob
//
//  Created by Ibokan on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PopPromptViewCount.h"

@implementation PopPromptViewCount
@synthesize arr;
-(id)init
{
    self=[super init];
    self.arr=[[NSMutableArray alloc]init];
    [self.arr addObject:[NSNumber numberWithInt:0]];
    return self;
}
-(void)dealloc
{
    [self.arr release];
    [super dealloc];
}
//文件路径
- (NSString *)filePath//用来读取文件目录
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"PopPromptViewCount"];//不加后缀可以避免被别人读取
    return path;
}
- (void)readData
{
    NSFileManager *fm=[NSFileManager defaultManager];//关于文件读取的类（单例） 可以对目录、文件进行管理  增删改查 移动 copy
    if ([fm fileExistsAtPath:[self filePath]])
    {//判断该路径下是否有文件
        self.arr=[NSMutableArray arrayWithContentsOfFile:[self filePath]];//读取文件
    }
}
- (void)savaData
{
    //文件写入
    [self.arr writeToFile:[self filePath] atomically:YES];//如果指定路径下没有文件，系统会新建，如果已经有了系统则会覆盖
}

@end
