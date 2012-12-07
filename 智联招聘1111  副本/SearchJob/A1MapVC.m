//
//  MapVC.m
//  MapVC
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "A1MapVC.h"
#import "A1PlaceInfo.h"
@implementation A1MapVC
@synthesize map,coordinate,region,locationManager,place,longitude,latitude,companyName,jobName;

-(void)viewWillAppear:(BOOL)animated
{ 
    place = [[A1PlaceInfo alloc]init ];
    count2=1;   //标记位
    [super viewWillAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"查看地图";
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 55, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"详情" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn;
    [backBtn release];
    
    
    map=[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [map setMapType:MKMapTypeStandard];
    map.delegate=self;
    [self.view addSubview:map];
    [map release];
    
    locationManager=[[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]==YES) //判断是否有定位服务
    {
        locationManager.delegate=self;
        locationManager.distanceFilter=100.0f;         //100.0以米为单位，超过100米后重新定位
        [locationManager startUpdatingLocation];        //启动定位管理器进行定位，进入代理方法，实施定位
        
    }else
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"没有定位服务" message:@"!!!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
    if (!(self.longitude==0&&self.latitude==0)) {   //有位置信息时才有方法
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(0, 0, 80, 44);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
        [btn2 setTitle:@"查看线路" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
        [btn2 addTarget:self action:@selector(appear) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];  
        self.navigationItem.rightBarButtonItem = backBtn2;
        [backBtn2 release];
    }

   
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
//定位代理
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //   coordinate= [newLocation coordinate];    //调用coordinate方法，获取经纬度信息，并保存起来
    
    coordinate.longitude = [self.longitude floatValue];
    coordinate.latitude=[self.latitude floatValue];
    if (coordinate.longitude==0&&coordinate.latitude==0) {//弹出没有位置信息的窗口
        
        if (count2==1) {
            UIAlertView *text = [[UIAlertView alloc]initWithTitle:@"此职位没有位置信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [text show];
            [text release];
            count2++;
        }
    //没位置信息时地图停留的位置     
        coordinate.longitude=105;
        coordinate.latitude = 30;
        MKCoordinateSpan theSpan;
        theSpan.latitudeDelta=50;
        theSpan.longitudeDelta=50;
        region.span=theSpan;
        
        region.center=coordinate;
        [map setRegion:region animated:YES];
        return;
    }
      
    region.center=coordinate;            //坐标区域：坐标点
    
    //坐标区域：精度信息
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01f;
    theSpan.longitudeDelta=0.01f;
    region.span=theSpan;
    
    //mapview的坐标区域，赋值
    [map setRegion:region animated:YES];
    
    place = [[A1PlaceInfo alloc]initWithCoord:coordinate];
    place.companyName = self.companyName;
    place.jobName = self.jobName;
    [map addAnnotation:place];
    [place release];

}

//自动弹出annotation
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
    for (MKAnnotationView* ano in views) {
        [map selectAnnotation:ano.annotation animated:YES];
    }
}
//修改大头针颜色，以及在标注上添加按钮等
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    MKPinAnnotationView *pinAnnotation=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pinAnnotation.pinColor=MKPinAnnotationColorRed;
    //红色代表目的地，绿色代表起点，紫色代表用户自选位置
    pinAnnotation.canShowCallout=YES;
    pinAnnotation.animatesDrop=YES;
    return [pinAnnotation autorelease];
}

//调用系统自带的地图

-(void)appear
{
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:@"你确定离开智联客户端去查看地图线路吗？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [av show];
    [av release];
    

}
//UIAlert协议
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex==1) {
    NSLog(@"%d",buttonIndex);
    NSString *title = @"title";
    int zoom = 13;
    NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@@%1.6f,%1.6f&z=%d", title,[self.latitude floatValue],[self.longitude floatValue],zoom];
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
