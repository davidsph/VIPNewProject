//
//  Channel.h
//  JobGuide
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
@property (nonatomic, assign) int ID;//channel的id 
@property (nonatomic, assign) int articleCount;//文章数
@property (nonatomic, retain) NSString *name;//channel的名字
@property (nonatomic, retain) NSMutableArray *articles;//存放所有文章



//初始化对象的方法
- (id)initByXMLData:(NSData *)data;
@end
