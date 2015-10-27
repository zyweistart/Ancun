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
#import "BidViewController.h"
#import "UIButton+Utils.h"
#import "UIImage+Utils.h"
#import "CameraUtility.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"车安存"];
        [self.view setBackgroundColor:RGBCOLOR(0, 175, 178)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createButtonWithFrame:CGRectMake1(100, 100, 120, 120) title:@"事故处理" titleFont:GLOBAL_FONTSIZE(16)  imagedName:@"player_s" borderColor:RGBCOLOR(102, 208, 208) titleColor:RGBCOLOR(109, 180, 176) action:@selector(goAccident)];
    [self createButtonWithFrame:CGRectMake1(15, 140, 70, 70) title:@"去电录音" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"player_s" borderColor:RGBCOLOR(198, 178, 205) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goCall)];
    [self createButtonWithFrame:CGRectMake1(235, 140, 70, 70) title:@"随手拍" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"player_s" borderColor:RGBCOLOR(214, 210, 165) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goPhotograph)];
    [self createButtonWithFrame:CGRectMake1(45, 230, 70, 70) title:@"录音笔" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"player_s" borderColor:RGBCOLOR(172, 191, 206) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goRecord)];
    [self createButtonWithFrame:CGRectMake1(205, 230, 70, 70) title:@"录像" titleFont:GLOBAL_FONTSIZE(12)  imagedName:@"player_s" borderColor:RGBCOLOR(179, 210, 212) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goVideo)];
    [self createButtonWithFrame:CGRectMake1(120, 280, 80, 80) title:@"申请公证" titleFont:GLOBAL_FONTSIZE(12) imagedName:@"player_s" borderColor:RGBCOLOR(115, 210, 212) titleColor:RGBCOLOR(102, 102, 102) action:@selector(goBid)];
    //出险动态
    UIButton *dynamicButton=[[UIButton alloc]initWithFrame:CGRectMake(-1, self.view.bounds.size.height-CGHeight(50)+1, CGWidth(160), CGHeight(50))];
    dynamicButton.layer.borderColor=RGBCOLOR(102, 207, 210).CGColor;
    dynamicButton.layer.borderWidth=1;
    [dynamicButton setBackgroundColor:RGBCOLOR(51, 157, 153)];
    [dynamicButton.titleLabel setFont:GLOBAL_FONTSIZE(14)];
    [dynamicButton setTitle:@"出险动态" forImage:UIControlStateNormal];
    [dynamicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [dynamicButton setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateNormal];
    [dynamicButton addTarget:self action:@selector(goDynamic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dynamicButton];
    //用户中心
    UIButton *userCenterButton=[[UIButton alloc]initWithFrame:CGRectMake(CGWidth(160)-2, self.view.bounds.size.height-CGHeight(50)+1, CGWidth(163), CGHeight(50))];
    userCenterButton.layer.borderColor=RGBCOLOR(102, 207, 210).CGColor;
    userCenterButton.layer.borderWidth=1;
    [userCenterButton setBackgroundColor:RGBCOLOR(51, 157, 153)];
    [userCenterButton.titleLabel setFont:GLOBAL_FONTSIZE(14)];
    [userCenterButton setTitle:@"用户中心" forImage:UIControlStateNormal];
    [userCenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [userCenterButton setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateNormal];
    [userCenterButton addTarget:self action:@selector(goUserCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userCenterButton];
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
    [self.view addSubview:button];
    return button;
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
    [self.navigationController pushViewController:[[UploadViewController alloc]init] animated:YES];
}

- (void)goUserCenter
{
    [self.navigationController pushViewController:[[UserCenterViewController alloc]init] animated:YES];
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
            [[mUploadViewController uploadFile]setImage:[self cutImage:image]];
            [self.navigationController pushViewController:mUploadViewController animated:YES];
        }
    }else if([@"public.movie" isEqualToString:mediaType]){
        //视频
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if(videoURL){
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
            AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            gen.appliesPreferredTrackTransform = YES;
            CMTime time = CMTimeMakeWithSeconds(0.0, 600);
            NSError *error = nil;
            CMTime actualTime;
            CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
            UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
            CGImageRelease(image);
            [[mUploadViewController uploadFile]setImage:[self cutImage:thumb]];
            [mUploadViewController setMovFileUrl:videoURL];
            [self.navigationController pushViewController:mUploadViewController animated:YES];
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

//保存图片
- (void)saveImage:(UIImage *)ci withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(ci);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//保存
- (NSString*)saveFile:(NSURL*)url withName:(NSString *)name
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    //获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    //写入文件
    [data writeToFile:fullPath atomically:NO];
    return fullPath;
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    CGSize newSize;
    CGImageRef imageRef = nil;
    CGFloat width=CGWidth(260.0);
    CGFloat height=CGHeight(150.0);
    if ((image.size.width / image.size.height) < (width / height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * height / width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * width / height;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    return [UIImage imageWithCGImage:imageRef];
}

@end