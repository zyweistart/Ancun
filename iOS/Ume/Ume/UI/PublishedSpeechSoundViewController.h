//
//  PublishedSpeechSoundViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpDownload.h"
#import "VPImageCropperViewController.h"

@interface PublishedSpeechSoundViewController : BaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate,HttpDownloadDelegate>

@property (strong, nonatomic) UIButton *recordButton;

@end
