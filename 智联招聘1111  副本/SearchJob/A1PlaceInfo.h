//
//  PlaceInfo.h
//  MapVC
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface A1PlaceInfo : NSObject<MKAnnotation>
@property (nonatomic,retain)NSString *companyName;//公司名
@property (nonatomic,retain)NSString *jobName;//工作名
@property (nonatomic,readonly)CLLocationCoordinate2D coordinatee;//经纬度

-(id)initWithCoord:(CLLocationCoordinate2D)coor;
@end