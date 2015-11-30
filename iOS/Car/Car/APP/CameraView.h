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
#import "HttpDownload.h"

@class CameraView;
@protocol CameraViewDelegate

@optional
- (void)CameraDelete:(CameraView*)camera;
- (void)CameraSuccess:(CameraView*)camera;

@end

@interface CameraView : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,HttpViewDelegate,HttpDownloadDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;
@property (strong,nonatomic) HttpDownload *hDownload;

@property (strong,nonatomic)NSString *imageNetAddressUrl;
@property (strong,nonatomic)UIViewController *controler;
@property (strong,nonatomic)XLLabel *lblInfo;
@property (strong,nonatomic)UIImage *currentImage;
@property (strong,nonatomic)UIImageView *currentImageView;
@property (assign,nonatomic)int type;
@property (strong,nonatomic)UIButton *pai;
@property (strong,nonatomic)UIButton *rPai;
@property (strong,nonatomic)XLLabel *lblTag;
@property (assign,nonatomic)BOOL isDelete;
@property (strong,nonatomic)NSObject<CameraViewDelegate> *delegate;
@property (assign,nonatomic)BOOL isUploadFile;
- (void)loadHttpImage:(NSString*)url;
- (void)resetCamera;
- (void)setStatus:(BOOL)status;


@end