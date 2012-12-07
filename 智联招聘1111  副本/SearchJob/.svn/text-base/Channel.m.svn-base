//
//  Channel.m
//  JobGuide
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Channel.h"
#import "GDataXMLNode.h"
#import "Articles.h"
@implementation Channel

@synthesize ID;
@synthesize articleCount;
@synthesize name;
@synthesize articles;

- (void)dealloc
{
    [self.name release];
    [self.articles release];
    [super dealloc];
}


//初始化对象的方法
- (id)initByXMLData:(NSData *)data
{ 
   
    self = [super init];
    if (self) {
        // 开始解析获得的数据
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        GDataXMLElement *root = [document rootElement];
        GDataXMLElement *channel = [[root children]objectAtIndex:0];
        //取出各个节点并存放入数组
        NSArray *totalCounts = [root nodesForXPath:@"channel/totalcount" error:nil];
        NSArray *names = [root nodesForXPath:@"channel/name" error:nil];
        NSArray *IDs = [root nodesForXPath:@"channel/articles/article/id" error:nil];
        NSArray *titles = [root nodesForXPath:@"channel/articles/article/title" error:nil];
        //将解析得到的数据赋给self属性值
        self.ID = [[[channel attributeForName:@"id"]stringValue]intValue];
        self.articleCount = [[[totalCounts objectAtIndex:0] stringValue]intValue];
        self.name = [[names objectAtIndex:0]stringValue];
        self.articles = [[NSMutableArray alloc]init];
        for (int i = 0; i< self.articleCount; i++) {
            Articles *article = [[Articles alloc]init];
            article.ID = [[[IDs objectAtIndex:i] stringValue]intValue];
            article.title = [[titles objectAtIndex:i] stringValue];
            [self.articles addObject:article];
            [article release];
        }
        [document release];
    }
    return self;
  
}


@end
