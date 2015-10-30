//
//  CameraView.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CameraView.h"
#import "CameraUtility.h"
#import "SJAvatarBrowser.h"

@implementation CameraView

- (id)initWithFrame:(CGRect)rect
{
    self=[super initWithFrame:rect];
    if(self){
        self.lblInfo=[[XLLabel alloc]initWithFrame:CGRectMake1(0, 0, 160, 25)];
        [self.lblInfo setBackgroundColor:[UIColor clearColor]];
        [self.lblInfo setFont:GLOBAL_FONTSIZE(13)];
        [self.lblInfo setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblInfo];
        self.currentImageView=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 25, 150, 107)];
        [self.currentImageView setBackgroundColor:[UIColor whiteColor]];
        [self.currentImageView setUserInteractionEnabled:YES];
        [self addSubview:self.currentImageView];
        self.pai=[[UIButton alloc]initWithFrame:CGRectMake1(55, 34, 40, 40)];
        [self.pai addTarget:self action:@selector(goPhotograph) forControlEvents:UIControlEventTouchUpInside];
        [self.pai setImage:[UIImage imageNamed:@"点击拍照"] forState:UIControlStateNormal];
        [self.currentImageView addSubview:self.pai];
        
        self.rPai=[[UIButton alloc]initWithFrame:CGRectMake1(130, 5, 15, 15)];
        [self.rPai addTarget:self action:@selector(goRPhotograph) forControlEvents:UIControlEventTouchUpInside];
        [self.rPai setImage:[UIImage imageNamed:@"重拍"] forState:UIControlStateNormal];
        [self.currentImageView setUserInteractionEnabled:YES];
        [self.currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goZoom)]];
        [self.currentImageView addSubview:self.rPai];
        [self.pai setHidden:NO];
        [self.rPai setHidden:YES];
    }
    return self;
}

- (void)goPhotograph
{
    if ([CameraUtility isCameraAvailable]) {
        if([CameraUtility doesCameraSupportTakingPhotos]){
            UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
            [imagePickerNC setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeImage]];
            [imagePickerNC setDelegate:self];
            [self.controler presentViewController:imagePickerNC animated:YES completion:nil];
        }
    }
}

- (void)goRPhotograph
{
    if(self.isDelete){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"重拍",nil];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }else{
        [self goPhotograph];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([@"public.image" isEqualToString:mediaType]){
        //照片
        self.currentImage=[info objectForKey:UIImagePickerControllerOriginalImage];
        if(self.currentImage){
            if(self.isDelete){
                [self.pai setHidden:YES];
                [self.rPai setHidden:NO];
            }
            [self.currentImageView setImage:self.currentImage];
            if([self.delegate respondsToSelector:@selector(CameraSuccess:)]){
                [self.delegate CameraSuccess:self];
            }
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        self.currentImage=nil;
        [self.currentImageView setImage:nil];
        [self.pai setHidden:NO];
        [self.rPai setHidden:YES];
        if([self.delegate respondsToSelector:@selector(CameraDelete:)]){
            [self.delegate CameraDelete:self];
        }
        
    }else if(buttonIndex==1){
        self.currentImage=nil;
        [self goPhotograph];
    }
}

- (void)goZoom
{
    if(self.currentImage){
        [SJAvatarBrowser showImage:self.currentImageView];
    }
}

@end