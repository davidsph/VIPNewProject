//
//  PlaceInfo.m
//  MapVC
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1PlaceInfo.h"

@implementation A1PlaceInfo
@synthesize jobName,companyName,coordinatee;
-(id)initWithCoord:(CLLocationCoordinate2D)coor
{
    self = [super init];
    if (self) {
        coordinatee=coor;
    }
    
    return self;
}
-(CLLocationCoordinate2D)coordinate
{
    return coordinatee;
}
-(NSString *)title
{
    return companyName;
}
-(NSString *)subtitle
{
    return jobName;
}

@end
