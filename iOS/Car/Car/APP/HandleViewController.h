//
//  HandleViewController.h
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import "CameraView.h"

@interface HandleViewController : BaseViewController<CameraViewDelegate>


@property (strong,nonatomic) UIView *viewFrame;

@end
