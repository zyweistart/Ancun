//
//  CameraView.h
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCamera.h"
#import "HttpRequest.h"

@class CameraView;
@protocol CameraViewDelegate

@optional
- (void)CameraDelete:(CameraView*)camera;
- (void)CameraSuccess:(CameraView*)camera;

@end

@interface CameraView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@property (strong,nonatomic)NSString *imageNetAddressUrl;
@property (strong,nonatomic)UIViewController *controler;
@property (strong,nonatomic)XLLabel *lblInfo;
@property (strong,nonatomic)UIImage *currentImage;
@property (strong,nonatomic)UIImageView *currentImageView;
@property (strong,nonatomic)UIButton *pai;
@property (strong,nonatomic)UIButton *rPai;
@property (assign,nonatomic)BOOL isDelete;
@property (strong,nonatomic)NSObject<CameraViewDelegate> *delegate;

- (void)resetCamera;

@end