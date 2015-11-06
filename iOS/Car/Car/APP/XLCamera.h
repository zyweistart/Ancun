//
//  XLCamera.h
//  Car
//
//  Created by Start on 11/6/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPImageCropperViewController.h"

@interface XLCamera : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate>

- (id)initWithController:(UIViewController*)controller;

- (void)open;

@property (assign,nonatomic)BOOL isImageCut;
@property (strong,nonatomic)UIViewController *controller;

@property (nonatomic, assign) id<UIImagePickerControllerDelegate> pickerDelegate;
@property (nonatomic, assign) id<VPImageCropperDelegate> cropperDelegate;

@end