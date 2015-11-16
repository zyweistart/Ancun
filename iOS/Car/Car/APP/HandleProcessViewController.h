//
//  HandleProcessViewController.h
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface HandleProcessViewController : BaseViewController

//地图信息
@property (strong,nonatomic) NSDictionary *mapData;
//我们保险公司
@property (strong,nonatomic) NSDictionary *insuranceData;
//对方保险公司
@property (strong,nonatomic) NSDictionary *insuranceOData;

@end
