//
//  MyViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "VPImageCropperViewController.h"

@interface MyViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate>

@property (strong, nonatomic) UIImageView *expandZoomImageView;

@end
