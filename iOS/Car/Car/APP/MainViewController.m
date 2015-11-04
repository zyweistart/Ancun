//
//  MainViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "MainViewController.h"
#import "AccidentViewController.h"
#import "CallViewController.h"
#import "RecordViewController.h"
#import "UploadViewController.h"
#import "UserCenterViewController.h"
#import "ProcessViewController.h"
#import "BidViewController.h"
#import "BeinDangerDetailViewController.h"
#import "UIButton+Utils.h"
#import "UIImage+Utils.h"
#import "CameraUtility.h"
#import "FileUtils.h"
#import "VideoUtils.h"
#import "TimeUtils.h"
#import "NSString+Utils.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIImageView *bgView;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"车安存"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bgView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgView setUserInteractionEnabled:YES];
    [bgView setImage:[UIImage imageNamed:@"BJ_2"]];
    [self.view addSubview:bgView];
    [self createButtonWithFrame:CGRectMake1(100, 50, 120, 120) title:@"事故处理" titleFont:GLOBAL_FONTSIZE(16)  imagedName:@"事故处理" borderColor:RGBCOLOR(102, 208, 208) titleColor:RGBCOLOR(109, 180, 176) action:@selector(goAccident)];
    [self createButtonWithFrame:CGRectMake1(15, 90, 70, 70) title:@"去电录音" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"去电录音" borderColor:RGBCOLOR(198, 178, 205) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goCall)];
    [self createButtonWithFrame:CGRectMake1(235, 90, 70, 70) title:@"随手拍" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"随手拍" borderColor:RGBCOLOR(214, 210, 165) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goPhotograph)];
    [self createButtonWithFrame:CGRectMake1(45, 180, 70, 70) title:@"录音笔" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"录音笔" borderColor:RGBCOLOR(172, 191, 206) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goRecord)];
    [self createButtonWithFrame:CGRectMake1(205, 180, 70, 70) title:@"录像" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"录像" borderColor:RGBCOLOR(179, 210, 212) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goVideo)];
    UIButton *bid=[self createButtonWithFrame:CGRectMake1(120, 230, 80, 80) title:@"申请公证" titleFont:GLOBAL_FONTSIZE(12) imagedName:@"申请公证" borderColor:RGBCOLOR(115, 210, 212) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goBid)];
    [bid setBackgroundColor:RGBCOLOR(255, 162, 0)];
    //出险动态
    UIButton *dynamicButton=[[UIButton alloc]initWithFrame:CGRectMake(-1, bgView.bounds.size.height-64-CGHeight(50)+1, CGWidth(160), CGHeight(50))];
    dynamicButton.layer.borderColor=RGBCOLOR(102, 207, 210).CGColor;
    dynamicButton.layer.borderWidth=1;
    [dynamicButton setBackgroundColor:RGBCOLOR(51, 157, 153)];
    [dynamicButton.titleLabel setFont:GLOBAL_FONTSIZE(14)];
    [dynamicButton setTitle:@"出险动态" forImage:UIControlStateNormal];
    [dynamicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dynamicButton setImage:[UIImage imageNamed:@"出险动态"] forState:UIControlStateNormal];
    [dynamicButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [dynamicButton addTarget:self action:@selector(goDynamic) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:dynamicButton];
    //用户中心
    UIButton *userCenterButton=[[UIButton alloc]initWithFrame:CGRectMake(CGWidth(160)-2, bgView.bounds.size.height-64-CGHeight(50)+1, CGWidth(163), CGHeight(50))];
    userCenterButton.layer.borderColor=RGBCOLOR(102, 207, 210).CGColor;
    userCenterButton.layer.borderWidth=1;
    [userCenterButton setBackgroundColor:RGBCOLOR(51, 157, 153)];
    [userCenterButton.titleLabel setFont:GLOBAL_FONTSIZE(14)];
    [userCenterButton setTitle:@"用户中心" forImage:UIControlStateNormal];
    [userCenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [userCenterButton setImage:[UIImage imageNamed:@"用户中心"] forState:UIControlStateNormal];
    [userCenterButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [userCenterButton addTarget:self action:@selector(goUserCenter) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:userCenterButton];
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"事故处理流程" style:UIBarButtonItemStylePlain target:self action:@selector(goProcess)];
}

- (UIButton*)createButtonWithFrame:(CGRect)frame title:(NSString*)title titleFont:(UIFont*)titleFont imagedName:(NSString*)imagedName borderColor:(UIColor *)borderColor titleColor:(UIColor *)titleColor action:(SEL)action
{
    UIButton *button=[[UIButton alloc]initWithFrame:frame];
    button.layer.cornerRadius=button.bounds.size.width/2;
    button.layer.masksToBounds=YES;
    button.layer.borderColor=borderColor.CGColor;
    button.layer.borderWidth=CGWidth(3);
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button setTitle:title forImage:[UIImage imageNamed:imagedName]];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    return button;
}

- (void)goProcess
{
    [self.navigationController pushViewController:[[ProcessViewController alloc]init] animated:YES];
}

- (void)goAccident
{
    [self.navigationController pushViewController:[[AccidentViewController alloc]init] animated:YES];
}

- (void)goCall
{
    [self.navigationController pushViewController:[[CallViewController alloc]init] animated:YES];
}

- (void)goRecord
{
    [self.navigationController pushViewController:[[RecordViewController alloc]init] animated:YES];
}

- (void)goPhotograph
{
    if ([CameraUtility isCameraAvailable]) {
        if([CameraUtility doesCameraSupportTakingPhotos]){
            UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
            [imagePickerNC setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeImage]];
            [imagePickerNC setDelegate:self];
            [self presentViewController:imagePickerNC animated:YES completion:nil];
        }
    }
}

- (void)goVideo
{
    if ([CameraUtility isCameraAvailable]){
        if([CameraUtility doesCameraSupportTakingPhotos]){
            UIImagePickerController *imagePickerNC = [[UIImagePickerController alloc] init];
            [imagePickerNC setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePickerNC setMediaTypes:@[(NSString *)kUTTypeMovie]];
            [imagePickerNC setDelegate:self];
            //设置最长录制5分钟
//            [imagePickerNC setVideoMaximumDuration:300.0f];
            //视频质量设置
//            [imagePickerNC setVideoQuality:UIImagePickerControllerQualityTypeIFrame960x540];
            [self presentViewController:imagePickerNC animated:YES completion:nil];
        }
    }
}

- (void)goBid
{
    [self.navigationController pushViewController:[[BidViewController alloc]init] animated:YES];
}

- (void)goDynamic
{
    [self.navigationController pushViewController:[[BeinDangerDetailViewController alloc]init] animated:YES];
}

- (void)goUserCenter
{
    [self.navigationController pushViewController:[[UserCenterViewController alloc]init] animated:YES];
    
//    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
//    [self.hRequest setDelegate:self];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"addUser" forKey:@"act"];
//    [params setObject:@"23123" forKey:@"pwd"];
//    [params setObject:@"13888888888" forKey:@"mobile"];
//    [params setObject:@"12345" forKey:@"code"];
//    [params setObject:@"0" forKey:@"gender"];
//    [params setObject:@"1" forKey:@"appver"];
//    [params setObject:@"baidu" forKey:@"regfrom"];
////    [self.hRequest setIsShowFailedMessage:YES];
//    [self.hRequest handleWithParams:params];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UploadViewController *mUploadViewController=[[UploadViewController alloc]init];
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([@"public.image" isEqualToString:mediaType]){
        //照片
        UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
        if(image){
            [mUploadViewController setSaveType:1];
            [mUploadViewController setOriginalImage:image];
            [[mUploadViewController thumImage]setImage:[image cutCenterImageSize:CGSizeMake1(260, 150)]];
            [self.navigationController pushViewController:mUploadViewController animated:YES];
        }
    }else if([@"public.movie" isEqualToString:mediaType]){
        //视频
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if(videoURL){
            NSString *fullName=[NSString stringWithFormat:@"%@.mp4",[[TimeUtils getTimeFormatter:FORMAT_yyyyMMddHHmmss_1] md5]];
            NSString *path=[FileUtils saveFile:videoURL withName:fullName];
            videoURL=[NSURL fileURLWithPath:path];
            if(videoURL){
                //获取视频的缩略图
                UIImage *thumb = [VideoUtils getVideoThumb:videoURL];
                [mUploadViewController setSaveType:2];
                [mUploadViewController setMovFileUrl:videoURL];
                [[mUploadViewController thumImage]setImage:[thumb cutCenterImageSize:CGSizeMake1(260, 150)]];
                [self.navigationController pushViewController:mUploadViewController animated:YES];
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

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSLog(@"成功了:%@",[response responseString]);
    }
}

@end