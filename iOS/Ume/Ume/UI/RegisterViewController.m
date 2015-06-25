//
//  RegisterViewController.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterGetCheckCodeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ImageTextField.h"
#import "NSString+DES.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    UIImageView *iUserNameImage;
    ImageTextField *tPhone;
    ImageTextField *tPassword;
    ImageTextField *tNickname;
    UIButton *mButton,*fButton;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"注册"];
        UIButton *bNextSteup = [UIButton buttonWithType:UIButtonTypeCustom];
        [bNextSteup setFrame:CGRectMake1(0, 0, 50, 30)];
        [bNextSteup setTitle:@"下一步" forState:UIControlStateNormal];
        [bNextSteup.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bNextSteup setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [bNextSteup addTarget:self action:@selector(goNextSteup:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bNextSteup];
        
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(140, 20, 60, 60)];
        [iUserNameImage setImage:[UIImage imageNamed:@"camera_button_take"]];
        iUserNameImage.layer.cornerRadius=30;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setUserInteractionEnabled:YES];
        [iUserNameImage addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(editPortrait:)]];
        [self.view addSubview:iUserNameImage];
        
        mButton=[[UIButton alloc]initWithFrame:CGRectMake1(220, 30, 40, 40)];
        [mButton setTitle:@"男" forState:UIControlStateNormal];
        [mButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [mButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [mButton addTarget:self action:@selector(mSex:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mButton];
        fButton=[[UIButton alloc]initWithFrame:CGRectMake1(270, 30, 40, 40)];
        [fButton setTitle:@"女" forState:UIControlStateNormal];
        [fButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [fButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        [fButton addTarget:self action:@selector(fSex:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fButton];
        
        [mButton setSelected:YES];
        [fButton setSelected:NO];
        
        tPhone=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 100, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"手机号"];
        [tPhone.textField setKeyboardType:UIKeyboardTypePhonePad];
        [self.view addSubview:tPhone];
        tPassword=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 150, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"密码"];
        [tPassword.textField setSecureTextEntry:YES];
        [self.view addSubview:tPassword];
        tNickname=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 200, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"昵称"];
        [self.view addSubview:tNickname];
        
        
        [tPhone.textField setText:@"13065732754"];
        [tPassword.textField setText:@"123456"];
        [tNickname.textField setText:@"政治"];
    }
    return self;
}

- (void)mSex:(id)sender
{
    if(!mButton.selected){
        [mButton setSelected:YES];
        [fButton setSelected:NO];
    }
}

- (void)fSex:(id)sender
{
    if(!fButton.selected){
        [fButton setSelected:YES];
        [mButton setSelected:NO];
    }
}

- (void)goNextSteup:(id)sender
{
    //头像
    [[User Instance]setHead:iUserNameImage.image];
    //性别
    if(mButton.selected){
        [[User Instance]setSex:@"1"];
    }else if(fButton.selected){
        [[User Instance]setSex:@"2"];
    }
    //手机号
    NSString *phone=[tPhone.textField text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"手机号不能为空"];
        return;
    }
    [[User Instance]setPhone:phone];
    //密码
    NSString *password=[tPassword.textField text];
    if([@"" isEqualToString:password]){
        [Common alert:@"密码不能为空"];
        return;
    }
    NSString *encrypt = [password encryptUseDES];
    [[User Instance]setPwd:encrypt];
    //昵称
    NSString *nickname=[tNickname.textField text];
    if([@"" isEqualToString:nickname]){
        [Common alert:@"昵称不能为空"];
        return;
    }
    [[User Instance]setNickName:nickname];
    [self.navigationController pushViewController:[[RegisterGetCheckCodeViewController alloc]init] animated:YES];
}

//弹出选项列表选择图片来源
- (void)editPortrait:(id)sender {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍一照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [iUserNameImage setImage:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else{
            if (widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
