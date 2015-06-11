//
//  NearbyViewController.m
//  Ume
//
//  Created by Start on 15/6/11.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "NearbyViewController.h"
#import "CustomAnnotation.h"
#import "CButton.h"
#import "NearbyXQCell.h"

#define ZOOMLEVEL 0.05f

@interface NearbyViewController ()

@end

@implementation NearbyViewController{
    int type;
    CButton *bList,*bMap;
    double latitude,longitude;
}

- (id)init
{
    self=[super init];
    if(self){
        self.title = @"遇见心动";
        self.isFirstRefresh=NO;
        type=1;
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 200, 40)];
        self.navigationItem.titleView=headerView;
        bList=[[CButton alloc]initWithFrame:CGRectMake1(20, 5, 80, 30) Name:@"列表" Type:1];
        [bList addTarget:self action:@selector(goMapOrList:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:bList];
        bMap=[[CButton alloc]initWithFrame:CGRectMake1(100, 5, 80, 30) Name:@"地图" Type:3];
        [bMap addTarget:self action:@selector(goMapOrList:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:bMap];
        
        //创建地图
        self.mapView=[[MKMapView alloc]initWithFrame:[self.view bounds]];
        [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.mapView setDelegate:self];
        [self.mapView setMapType:MKMapTypeStandard];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setZoomEnabled:YES];
        [self.mapView setScrollEnabled:YES];
        [self.view addSubview:self.mapView];
        //刷新位置点数据
        UIButton *refresh=[[UIButton alloc]initWithFrame:CGRectMake1(270, 10, 33, 33)];
        [refresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [refresh addTarget:self action:@selector(goRefreshMapData) forControlEvents:UIControlEventTouchDown];
        [self.mapView addSubview:refresh];
        //定位到当前位置
        UIButton *currentLocation=[[UIButton alloc]initWithFrame:
                                   CGRectMake1(270, 53, 33, 33)];
        [currentLocation setImage:[UIImage imageNamed:@"mylocation"] forState:UIControlStateNormal];
        [currentLocation addTarget:self action:@selector(goCurrentLocation) forControlEvents:UIControlEventTouchDown];
        [self.mapView addSubview:currentLocation];
        
        //定位管理
        self.locationManager = [CLLocationManager new];
#ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
#endif
        [self.locationManager setDelegate:self];
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
        
        [self buildTableViewWithView:self.view];
        
        [self goMapOrList:nil];
    }
    return self;
}

//切换地图或列表
- (void)goMapOrList:(id)sender
{
    if(type==1){
        //切换到列表模式
        type=2;
        [bList setType:1];
        [bMap setType:3];
        [self.tableView setHidden:NO];
        [self.mapView setHidden:YES];
    }else{
        //切换到地图模式
        type=1;
        [bList setType:3];
        [bMap setType:1];
        [self.tableView setHidden:YES];
        [self.mapView setHidden:NO];
//        [self goCurrentLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"请在设置-隐私-定位服务中开启定位功能！");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"定位服务无法使用！");
        default:
            break;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
{
    if([annotation isKindOfClass:[CustomAnnotation class]]){
        //附近点
        static NSString *CPinIdentifier = @"Pin";
        CustomAnnotation *myAnnotation = (CustomAnnotation*)annotation;
        MKPinAnnotationView *annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CPinIdentifier];
        if(nil == annView) {
            annView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:CPinIdentifier];
        }
        int tag=[myAnnotation index];
//        NSDictionary *data=[self.dataItemArray objectAtIndex:tag];
        [annView setImage:[UIImage imageNamed:@"出租点"]];
        UIButton *icon=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [icon setImage:[UIImage imageNamed:@"category2"] forState:UIControlStateNormal];
        annView.rightCalloutAccessoryView=icon;
        [[annView rightCalloutAccessoryView] setTag:tag];
        [[annView rightCalloutAccessoryView] addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickGoDetail:)]];
        [annView setEnabled:YES];
        [annView setCanShowCallout:YES];
        return annView;
    }else{
        return nil;
    }
}

- (void)mapView:(MKMapView *)_mapView regionDidChangeAnimated:(BOOL)animated {
    //    NSLog(@"当前搜索的范围为:%d----%d", [self getZoomLevel],abs([self getZoomLevel]-20)*10000);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    latitude=loc.latitude;
    longitude=loc.longitude;
}

//定位到当前位置
- (void)goCurrentLocation
{
    MKCoordinateRegion region;
    region.center=[[self.locationManager location] coordinate];
    region.span.longitudeDelta = ZOOMLEVEL;
    region.span.longitudeDelta = ZOOMLEVEL;
    [self.mapView setRegion:region animated:YES];
}

- (void)loadHttp
{
    [super loadHttp];
}

//刷新地图位置数据
- (void)goRefreshMapData
{
    self.currentPage=1;
    [self loadHttp];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [super requestFinishedByResponse:response requestCode:reqCode];
    if([response successFlag]){
        if(type==1){
            //清除地图上的位置点
            [self.mapView removeAnnotations:[self.mapView annotations]];
            for(int i=0;i<[self.dataItemArray count];i++){
                NSDictionary *data=[self.dataItemArray objectAtIndex:i];
                NSString *location=[data objectForKey:@"location"];
                NSArray *array=[location componentsSeparatedByString:@","];
                NSString *lat=[array objectAtIndex:0];
                NSString *lng=[array objectAtIndex:1];
                CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([lng doubleValue],[lat doubleValue])];
                annotation1.title = [data objectForKey:@"Name"];
                annotation1.subtitle = @"点击联系此信息";
                [annotation1 setIndex:i];
                [self.mapView addAnnotation:annotation1];
            }
        }
    }
}

- (void)onClickGoDetail:(UITapGestureRecognizer *)sender
{
    NSUInteger tag=[sender.view tag];
    NSDictionary *data=[self.dataItemArray objectAtIndex:tag];
    NSLog(@"%@",data);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(85);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *CProjectCell = @"CProjectCell";
        NearbyXQCell *cell = [tableView dequeueReusableCellWithIdentifier:CProjectCell];
        if (cell == nil) {
            cell = [[NearbyXQCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CProjectCell];
        }
//        NSUInteger row=[indexPath row];
//        NSDictionary *d=[self.dataItemArray objectAtIndex:row];
        [cell.textLabel setText:@"右右顺在"];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end