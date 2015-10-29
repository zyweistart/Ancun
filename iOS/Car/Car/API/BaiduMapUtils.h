//
//  BaiduMapUtils.h
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入base相关所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//引入检索功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
//引入云检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
//引入定位功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//引入计算工具所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface BaiduMapUtils : NSObject

+ (NSString *)getAddress:(BMKPoiInfo*)info;

@end
