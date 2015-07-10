//
//  PublishedSpeechSoundViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "PublishedSpeechSoundViewController.h"
#import "CLabel.h"
#import "CButton.h"
#import "RecordingPlayerView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CameraUtility.h"
#import "UIImage+Utils.h"
#import "ContactViewController.h"

@interface PublishedSpeechSoundViewController ()<ContactDelegate>

@end

@implementation PublishedSpeechSoundViewController{
    UIButton *atToMe,*saveTo;
    RecordingPlayerView *mRecordingPlayerView;
    UIImageView *mBackgroundImage;
    UITextView *textContent;
    NSArray *atFriendsArray;
    NSString *backgroundID;
}

- (id)init{
    self=[super init];
    if(self){
        //
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(0, 0, 30, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bClose];
        //
        UIButton *bPublished = [[UIButton alloc]init];
        [bPublished setFrame:CGRectMake1(0, 0, 50, 30)];
        [bPublished setTitle:@"发布" forState:UIControlStateNormal];
        [bPublished.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bPublished setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [bPublished addTarget:self action:@selector(goPublish:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bPublished];
        
        mBackgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 5, 310, 250)];
        mBackgroundImage.layer.masksToBounds=YES;
        [mBackgroundImage setUserInteractionEnabled:YES];
        [mBackgroundImage setImage:[UIImage imageNamed:@"personalbg"]];
        [mBackgroundImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:mBackgroundImage];
        CButton *bGetServerImage=[[CButton alloc]initWithFrame:CGRectMake1(220, 10, 80, 30) Name:@"换一张" Type:5];
        [bGetServerImage.titleLabel setFont:[UIFont systemFontOfSize:15]];
        bGetServerImage.layer.cornerRadius=CGWidth(15);
        [bGetServerImage addTarget:self action:@selector(goGetServerImage:) forControlEvents:UIControlEventTouchUpInside];
        [mBackgroundImage addSubview:bGetServerImage];
        
        textContent=[[UITextView alloc]initWithFrame:CGRectMake1(10, 60, 290, 120)];
        [textContent setText:@"每张脸诉说千种情绪,却很容易掩饰心情。\n最快乐的面具下,也许是一颗最痛的心。"];
        [textContent setScrollEnabled:YES];
        [textContent setFont:[UIFont systemFontOfSize:18]];
        [textContent setTextColor:DEFAULTITLECOLOR(200)];
        [textContent setBackgroundColor:[UIColor clearColor]];
        [textContent setDelegate:self];
        [textContent setTextAlignment:NSTextAlignmentCenter];
        [mBackgroundImage addSubview:textContent];
        //换图片
        UIButton *switchToImage=[[UIButton alloc]initWithFrame:CGRectMake1(10, 255, 50, 30)];
        [switchToImage.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [switchToImage setTitle:@"换照片" forState:UIControlStateNormal];
        [switchToImage setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [switchToImage addTarget:self action:@selector(goSwitchToImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:switchToImage];
        //@某人
        atToMe=[[UIButton alloc]initWithFrame:CGRectMake1(70, 255, 50, 30)];
        [atToMe.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [atToMe setTitle:@"@某人" forState:UIControlStateNormal];
        [atToMe setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [atToMe addTarget:self action:@selector(atToMeb:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:atToMe];
        //保存到
        saveTo=[[UIButton alloc]initWithFrame:CGRectMake1(190, 255, 120, 30)];
        [saveTo.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [saveTo setTitle:@"保存到心情轨迹" forState:UIControlStateNormal];
        [saveTo setImage:[UIImage imageNamed:@"icon-select-off"] forState:UIControlStateNormal];
        [saveTo setImage:[UIImage imageNamed:@"icon-select-on"] forState:UIControlStateSelected];
        [saveTo setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [saveTo setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [saveTo addTarget:self action:@selector(saveTob:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveTo];
        //默认设置为选中
        [saveTo setSelected:YES];
        
        mRecordingPlayerView=[[RecordingPlayerView alloc]initWithFrame:CGRectMake1(75, 320, 170, 170)];
        [self.view addSubview:mRecordingPlayerView];
    }
    return self;
}

- (void)goGetServerImage:(id)sender
{
    NSLog(@"获取服务端图片");
}

- (void)atToMeb:(id)sender
{
    ContactViewController *mContactViewController=[[ContactViewController alloc]init];
    [mContactViewController setDelegate:self];
    [mContactViewController setSelectedUser:atFriendsArray];
    [self.navigationController pushViewController:mContactViewController animated:YES];
}

- (void)goPublish:(id)sender
{
    NSLog(@"%@",mBackgroundImage.image);
    NSLog(@"%@",backgroundID);
    NSLog(@"内容:%@",[textContent text]);
    NSLog(@"保存到：%d",saveTo.isSelected);
    NSLog(@"@某人：%@",atFriendsArray);
    NSLog(@"录音地址:%@",mRecordingPlayerView.docRecordedFilePath);
}

- (void)saveTob:(id)sender
{
    [saveTo setSelected:!saveTo.selected];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//弹出选项列表选择图片来源
- (void)goSwitchToImage:(id)sender {
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
    [mBackgroundImage setImage:editedImage];
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

- (void)atContactFinisih:(NSArray*)friendsArray
{
    atFriendsArray=[NSArray arrayWithArray:friendsArray];
}

@end