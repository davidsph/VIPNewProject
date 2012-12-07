//
//  Articles.m
//  JobGuide
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Articles.h"
#import "GDataXMLNode.h"
@implementation Articles
@synthesize ID;
@synthesize author;
@synthesize title;
@synthesize subTilte;
@synthesize startDate;
@synthesize content;


//初始化对象的方法
- (id)initByXMLData:(NSData *)data
{
    self = [super init];
    if (self) {
        // 开始解析获得的数据
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        GDataXMLElement *root = [document rootElement];
        //将解析得到的数据赋给self属性值
        self.ID = [[[[root nodesForXPath:@"article/id" error:nil]objectAtIndex:0]stringValue]intValue];
        self.author = [[[root nodesForXPath:@"article/author" error:nil] objectAtIndex:0]stringValue];
        self.title = [[[root nodesForXPath:@"article/title" error:nil] objectAtIndex:0]stringValue];
        self.subTilte = [[[root nodesForXPath:@"article/subtitle" error:nil] objectAtIndex:0]stringValue];
        self.startDate = [[[root nodesForXPath:@"article/startdate" error:nil] objectAtIndex:0]stringValue];
        self.content = [[[root nodesForXPath:@"article/content" error:nil] objectAtIndex:0]stringValue];
        [document release];
    }
    return self;
}

//重写dealloc方法，释放内存
- (void)dealloc
{
    self.author = nil;
    self.title = nil;
    self.subTilte = nil;
    self.startDate = nil;
    self.content = nil;
    [super dealloc];
}
@end
