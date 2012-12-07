//
//  MapVC.h
//  MapVC
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "A1PlaceInfo.h"
@interface A1MapVC : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate>
{
    int count2;
}
@property(nonatomic,retain)MKMapView * map;
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;//经纬度结构体类
@property(nonatomic,assign)MKCoordinateRegion region; //位置地点
@property(nonatomic,retain)A1PlaceInfo *place;  //位置类
@property (retain,nonatomic)NSString *longitude;//经度
@property (retain,nonatomic)NSString *latitude;//纬度

@property (nonatomic,retain)NSString *companyName;
@property (nonatomic,retain)NSString *jobName;

@end
