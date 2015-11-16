//
//  HandleViewController.h
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import "AccidentCerView.h"

@interface HandleViewController : BaseViewController<CameraViewDelegate,AccidentCerViewDelegate>

//@property (strong,nonatomic) UIView *viewFrame;
//地图信息
@property (strong,nonatomic) NSDictionary *mapData;
//我们保险公司
@property (strong,nonatomic) NSDictionary *insuranceData;
//对方保险公司
@property (strong,nonatomic) NSDictionary *insuranceOData;

@end
