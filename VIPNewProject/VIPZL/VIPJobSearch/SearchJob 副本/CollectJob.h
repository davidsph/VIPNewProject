//
//  CollectJob.h
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectJob : NSObject<NSURLConnectionDataDelegate>
@property (retain,nonatomic)NSMutableData *receiveData;


+(void)CollectJobWithUticket:(NSString *)aUticket JobNumber:(NSString *)aJobNumber;//发送收藏职位信息到服务器

-(void)CollectJobWithUticket:(NSString *)aUticket JobNumber:(NSString *)aJobNumber;


@end
