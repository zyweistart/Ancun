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
#import "CameraUtility.h"
#import "UIImage+Utils.h"

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
        //
        [self cNavigationRightItemType:2 Title:@"下一步" action:@selector(goNextSteup:)];
        
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(100, 20, 60, 60)];
        [iUserNameImage setImage:[UIImage imageNamed:@"img_boy"]];
        iUserNameImage.layer.cornerRadius=iUserNameImage.bounds.size.width/2;
        iUserNameImage.layer.masksToBounds = YES;
        iUserNameImage.layer.borderWidth=1;
        iUserNameImage.layer.borderColor=[DEFAULTITLECOLOR(150) CGColor];
        [iUserNameImage setUserInteractionEnabled:YES];
        [iUserNameImage addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(editPortrait:)]];
        [self.view addSubview:iUserNameImage];
        
        mButton=[[UIButton alloc]initWithFrame:CGRectMake1(180, 30, 40, 40)];
        [mButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [mButton setTitle:@"男" forState:UIControlStateNormal];
        [mButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [mButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [mButton setTitleColor:DEFAULTITLECOLORRGB(47,160,248) forState:UIControlStateSelected];
        [mButton setImage:[UIImage imageNamed:@"icon_boy_g"] forState:UIControlStateNormal];
        [mButton setImage:[UIImage imageNamed:@"icon_boy"] forState:UIControlStateSelected];
        [mButton addTarget:self action:@selector(mSex:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mButton];
        fButton=[[UIButton alloc]initWithFrame:CGRectMake1(230, 30, 40, 40)];
        [fButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [fButton setTitle:@"女" forState:UIControlStateNormal];
        [fButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [fButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [fButton setTitleColor:DEFAULTITLECOLORRGB(242,82,159) forState:UIControlStateSelected];
        [fButton setImage:[UIImage imageNamed:@"icon_girl_g"] forState:UIControlStateNormal];
        [fButton setImage:[UIImage imageNamed:@"icon_girl"] forState:UIControlStateSelected];
        [fButton addTarget:self action:@selector(fSex:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fButton];
        
        [mButton setSelected:YES];
        [fButton setSelected:NO];
        
        tPhone=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 100, 280, 40) Image:@"icon_phone" Placeholder:@"手机号"];
        [tPhone.textField setKeyboardType:UIKeyboardTypePhonePad];
        [tPhone.textField setDelegate:self];
        [self.view addSubview:tPhone];
        tPassword=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 150, 280, 40) Image:@"icon_mima" Placeholder:@"密码"];
        [tPassword.textField setSecureTextEntry:YES];
        [tPassword.textField setDelegate:self];
        [self.view addSubview:tPassword];
        tNickname=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 200, 280, 40) Image:@"icon_name" Placeholder:@"昵称"];
        [tNickname.textField setDelegate:self];
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
//    NSString *encrypt = [password encryptUseDES];
    [[User Instance]setPwd:password];
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
        if ([CameraUtility isCameraAvailable] && [CameraUtility doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([CameraUtility isFrontCameraAvailable]) {
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
        if ([CameraUtility isPhotoLibraryAvailable]) {
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
        portraitImg = [portraitImg imageByScalingToMaxSize];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self changeTextFieldStatus:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    [self changeTextFieldStatus:nil];
    return YES;
}

- (void)changeTextFieldStatus:(UITextField*)textField
{
    if(textField==tPhone.textField){
        [tPhone.image setImage:[UIImage imageNamed:@"icon_phone2"]];
        tPhone.layer.borderColor=[COLOR2552160 CGColor];
        [tPassword.image setImage:[UIImage imageNamed:@"icon_mima"]];
        tPassword.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tNickname.image setImage:[UIImage imageNamed:@"icon_name"]];
        tNickname.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
    }else if(textField==tPassword.textField){
        [tPhone.image setImage:[UIImage imageNamed:@"icon_phone"]];
        tPhone.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tPassword.image setImage:[UIImage imageNamed:@"icon_mima2"]];
        tPassword.layer.borderColor=[COLOR2552160 CGColor];
        [tNickname.image setImage:[UIImage imageNamed:@"icon_name"]];
        tNickname.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
    }else if(textField==tNickname.textField){
        [tPhone.image setImage:[UIImage imageNamed:@"icon_phone"]];
        tPhone.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tPassword.image setImage:[UIImage imageNamed:@"icon_mima"]];
        tPassword.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tNickname.image setImage:[UIImage imageNamed:@"icon_name2"]];
        tNickname.layer.borderColor=[COLOR2552160 CGColor];
    }else{
        [tPhone.image setImage:[UIImage imageNamed:@"icon_phone"]];
        tPhone.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tPassword.image setImage:[UIImage imageNamed:@"icon_mima"]];
        tPassword.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tNickname.image setImage:[UIImage imageNamed:@"icon_name"]];
        tNickname.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
    }
}

@end
