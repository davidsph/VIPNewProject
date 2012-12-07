//
//  Articles.h
//  JobGuide
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Articles : NSObject
@property (nonatomic, assign) int ID;//id
@property (nonatomic, retain) NSString *author;//作者
@property (nonatomic, retain) NSString *title;//标题
@property (nonatomic, retain) NSString *subTilte;//子标题
@property (nonatomic, retain) NSString *startDate;//创建日期
@property (nonatomic, retain) NSString *content;//文章内容


//初始化对象的方法
- (id)initByXMLData:(NSData *)data;

@end
