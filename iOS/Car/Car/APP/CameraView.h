//
//  CameraView.h
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCamera.h"

@class CameraView;
@protocol CameraViewDelegate

@optional
- (void)CameraDelete:(CameraView*)camera;
- (void)CameraSuccess:(CameraView*)camera;

@end

@interface CameraView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)UIViewController *controler;
@property (strong,nonatomic)XLLabel *lblInfo;
@property (strong,nonatomic)UIImage *currentImage;
@property (strong,nonatomic)UIImageView *currentImageView;
@property (strong,nonatomic)UIButton *pai;
@property (strong,nonatomic)UIButton *rPai;
@property (assign,nonatomic)BOOL isDelete;
@property (strong,nonatomic)NSObject<CameraViewDelegate> *delegate;

@end