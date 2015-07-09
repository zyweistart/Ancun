//
//  MyViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MyViewController.h"
#import "MyPublishListViewController.h"
#import "MyHeartbeatViewController.h"
#import "MyFollowViewController.h"
#import "MyFansViewcontroller.h"
#import "MyImageViewController.h"
#import "SettingViewController.h"
#import "MoodTrackViewcontroller.h"
#import "MyFlowersViewController.h"
#import "MyImagesCell.h"
#import "MessageCell.h"
#import "UIButton+TitleImage.h"
#import "CLabel.h"
#import "UIImage+Utils.h"
#import "SJAvatarBrowser.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CameraUtility.h"
#import "UIImage+Utils.h"

#define LOGINREGISTERBGCOLOR [UIColor colorWithRed:(58/255.0) green:(117/255.0) blue:(207/255.0) alpha:0.5]
#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

static CGFloat kImageOriginHight = 220.f;

@interface MyViewController ()

@end

@implementation MyViewController{
    UIView *topFrame;
    UIView *personalFrame;
    UIView *bHead;
    UILabel *lblUserName;
    UIImageView *iUserNameImage;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"我的"];
        [self.dataItemArray addObject:@"心情轨迹"];
        [self.dataItemArray addObject:@"我发布的"];
        [self.dataItemArray addObject:@"设置"];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        
        self.expandZoomImageView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, kImageOriginHight)];
        self.expandZoomImageView.userInteractionEnabled=YES;
        [self.expandZoomImageView setImage:[UIImage imageNamed:@"personalbg"]];
        self.tableView.contentInset = UIEdgeInsetsMake(CGHeight(kImageOriginHight), 0, 0, 0);
        [self.tableView addSubview:self.expandZoomImageView];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 20, 60, 30) Text:@"当前心情"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [self.expandZoomImageView addSubview:lbl];
        
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(210, 20, 100, 30)Text:@"杭州市 摩羯座"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.expandZoomImageView addSubview:lbl];
        
        personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        //头像
        bHead=[[UIView alloc]initWithFrame:CGRectMake1(120, 20, 80, 90)];
        [personalFrame addSubview:bHead];
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 60, 60)];
        iUserNameImage.layer.cornerRadius=30;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setUserInteractionEnabled:YES];
        [iUserNameImage addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(editPortrait:)]];
        [bHead addSubview:iUserNameImage];
        lblUserName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 70,80,20)];
        [lblUserName setFont:[UIFont systemFontOfSize:14]];
        [lblUserName setTextColor:[UIColor whiteColor]];
        [lblUserName setTextAlignment:NSTextAlignmentCenter];
        [lblUserName setUserInteractionEnabled:YES];
        [bHead addSubview:lblUserName];
        //鲜花
        UIButton *bFlowers=[[UIButton alloc]initWithFrame:CGRectMake1(240, 35, 80, 30)];
        [bFlowers setTitle:@"135朵鲜花" forState:UIControlStateNormal];
        [bFlowers setTitleColor:DEFAULTITLECOLOR(100) forState:UIControlStateNormal];
        [bFlowers setBackgroundColor:DEFAULTITLECOLORA(200,0.5)];
        [bFlowers.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bFlowers addTarget:self action:@selector(goFlowers:) forControlEvents:UIControlEventTouchUpInside];
        [personalFrame addSubview:bFlowers];
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(40, 140, 240, 20)];
        [personalFrame addSubview:bottomFrame];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 20)];
        [button setTitle:@"5关注" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goFollow:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 20)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line1];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 20)];
        [button setTitle:@"25粉丝" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goFans:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
        //竖线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 20)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line2];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 20)];
        [button setTitle:@"63心动" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goMood:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
        [self showUser];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.expandZoomImageView.frame = CGRectMake(0, -CGHeight(kImageOriginHight), self.tableView.frame.size.width, CGHeight(kImageOriginHight));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -CGHeight(kImageOriginHight)) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
        [personalFrame setFrame:CGRectMake(0, f.size.height-CGHeight(170), CGWidth(320), CGHeight(160))];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else{
        return [self.dataItemArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    if(section==0){
        return CGHeight(80);
    }else{
        return CGHeight(45);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    if(section==0){
        //照片
        static NSString *CMainCell = @"MyImagesCell";
        MyImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[MyImagesCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        //总图像数
        int count=5;
        //计算总宽度
        CGFloat width=10+(count*60)+(count*10);
        [cell.scrollViewFrame setContentSize:CGSizeMake1(width,80)];
        for(int i=0;i<count;i++){
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10+(i*60)+(i*10), 10, 60, 60)];
            [image setImage:[UIImage imageNamed:@"personalbg"]];
            [image setUserInteractionEnabled:YES];
            [image addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(zoomImage:)]];
            [cell.scrollViewFrame addSubview:image];
        }
        return cell;
    }else{
        static NSString *CMainCell = @"CMainCell";
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        NSString *content=[self.dataItemArray objectAtIndex:row];
        [cell.image setImage:[UIImage imageNamed:content]];
        [cell.lblTitle setText:content];
        [cell.lblCount setHidden:YES];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    if(row==0){
        //心情轨迹
        [self.navigationController pushViewController:[[MoodTrackViewController alloc]init] animated:YES];
    }else if(row==1){
        //我发布的
        [self.navigationController pushViewController:[[MyPublishListViewController alloc]init] animated:YES];
    }else if(row==2){
        //设置
        [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
    }
}
//关注
- (void)goFollow:(id)sender
{
    [self.navigationController pushViewController:[[MyFollowViewController alloc]init] animated:YES];
}
//粉丝
- (void)goFans:(id)sender
{
    [self.navigationController pushViewController:[[MyFansViewController alloc]init] animated:YES];
}
//心动
- (void)goMood:(id)sender
{
    [self.navigationController pushViewController:[[MoodTrackViewController alloc]init] animated:YES];
}
//鲜花
- (void)goFlowers:(id)sender
{
    [self.navigationController pushViewController:[[MyFlowersViewController alloc]init] animated:YES];
}

- (void)showUser
{
    [bHead setHidden:NO];
    [iUserNameImage setImage:[UIImage imageNamed:@"camera_button_take"]];
    [lblUserName setText:@"辰羽"];
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

- (void)zoomImage:(UITapGestureRecognizer*)sender
{
    UIImageView *imageV=(UIImageView*)[sender view];
    [SJAvatarBrowser showImage:imageV];
}

@end