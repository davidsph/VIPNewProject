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
@property (nonatomic,retain)NSString *companyName;
@property (nonatomic,retain)NSString *jobName;
@property (nonatomic,readonly)CLLocationCoordinate2D coordinatee;

-(id)initWithCoord:(CLLocationCoordinate2D)coor;
@end