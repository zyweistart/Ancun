//
//  NearbyViewController.h
//  Ume
//
//  Created by Start on 15/6/11.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <MapKit/MapKit.h>

@interface NearbyViewController : BaseEGOTableViewPullRefreshViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property MKMapView *mapView;
@property CLLocationManager *locationManager;

@end
