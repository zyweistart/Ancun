//
//  AccidentViewController.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//
#define KEYADDRESSNAME @"KEYADDRESSNAME"
#define KEYLATITUDE @"KEYLATITUDE"
#define KEYLONGITUDE @"KEYLONGITUDE"
#define KEYTIME @"KEYTIME"

#import "BaseViewController.h"
#import "BaiduMapUtils.h"

@interface AccidentViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (strong,nonatomic)BMKMapView* mapView;
@property (strong,nonatomic)BMKLocationService *locService;
@property (strong,nonatomic)NSArray *poiList;

@end
