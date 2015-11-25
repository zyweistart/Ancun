//
//  XLCamera.m
//  Car
//
//  Created by Start on 11/6/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "XLCamera.h"
#import "CameraUtility.h" 
#import "UIImage+Utils.h"

@implementation XLCamera

- (id)initWithController:(UIViewController*)controller
{
    self=[super init];
    if(self){
        self.isImageCut=YES;
        self.controller=controller;
    }
    return self;
}

- (void)open
{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
    // 拍照
    if ([CameraUtility isCameraAvailable]) {
        if([CameraUtility doesCameraSupportTakingPhotos]){
            UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
            [imagePickerNC setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeImage]];
            [imagePickerNC setDelegate:self];
            [self.controller presentViewController:imagePickerNC animated:YES completion:nil];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
        if ([CameraUtility isCameraAvailable]) {
            if([CameraUtility doesCameraSupportTakingPhotos]){
                UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
                [imagePickerNC setSourceType:UIImagePickerControllerSourceTypeCamera];
                [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeImage]];
                [imagePickerNC setDelegate:self];
                [self.controller presentViewController:imagePickerNC animated:YES completion:nil];
            }
        }
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([CameraUtility isCameraAvailable]) {
            if([CameraUtility doesCameraSupportTakingPhotos]){
                UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
                [imagePickerNC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeImage]];
                [imagePickerNC setDelegate:self];
                [self.controller presentViewController:imagePickerNC animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([@"public.image" isEqualToString:mediaType]){
        if([self.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]){
            [self.pickerDelegate imagePickerController:picker didFinishPickingMediaWithInfo:info];
        }else{
            [picker dismissViewControllerAnimated:YES completion:^() {
                UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
                //剪切图片
                if(self.isImageCut){
                    portraitImg = [portraitImg imageByScalingToMaxSize];
                    VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, CGHeight(100), self.controller.view.frame.size.width, self.controller.view.frame.size.width) limitScaleRatio:3.0];
                    [imgEditorVC setDelegate:self.cropperDelegate];
                    [self.controller presentViewController:imgEditorVC animated:YES completion:nil];
                }
            }];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if([self.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]){
        [self.pickerDelegate imagePickerControllerDidCancel:picker];
    }else{
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    if([self.cropperDelegate respondsToSelector:@selector(imageCropper:didFinished:)]){
        [self.cropperDelegate imageCropper:cropperViewController didFinished:editedImage];
    }else{
        [cropperViewController dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    if([self.cropperDelegate respondsToSelector:@selector(imageCropperDidCancel:)]){
        [self.cropperDelegate imageCropperDidCancel:cropperViewController];
    }else{
        [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // bug fixes: UIImagePickerController使用中偷换StatusBar颜色的问题
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

@end