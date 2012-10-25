//
//  DealWithNetworkAndXMLHelper.h
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 315235374
 mxp19890101
 */
@class Resume;
@interface DealWithNetworkAndXMLHelper : NSObject

+(NSArray *) getCompanyList:(Resume *) resume;
//+(NSArray *) getCompanyListDetail;


@end
