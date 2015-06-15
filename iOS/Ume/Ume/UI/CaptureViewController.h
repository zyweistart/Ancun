//
//  CaptureViewController.h
//  ImagePickerDemo
//
//  Created by Ryan Tang on 13-1-5.
//  Copyright (c) 2013年 Ericsson Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSimpleImageEditorView.h"
#import "PassImageDelegate.h"

@interface CaptureViewController : UIViewController
{
    UIImage *image;
}

@property(nonatomic,strong) UIImage *image;

@property(strong,nonatomic) NSObject<PassImageDelegate> *delegate;

@end
