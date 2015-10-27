//
//  UploadViewController.m
//  Car
//
//  Created by Start on 10/14/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"文件上传"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.uploadFile=[[UIImageView alloc]initWithFrame:CGRectMake1(30, 70, 260, 150)];
    [self.uploadFile setBackgroundColor:[UIColor blackColor]];
    [self.uploadFile setUserInteractionEnabled:YES];
    [self.uploadFile addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goPlay)]];
    [self.view addSubview:self.uploadFile];
    CGFloat f=self.view.bounds.size.height-CGHeight(70+150+20);
    UIView *operatorView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-f, CGWidth(320), f)];
    operatorView.layer.borderWidth=2;
    operatorView.layer.borderColor=BCOLOR(229).CGColor;
    [operatorView setBackgroundColor:BCOLOR(244)];
    [self.view addSubview:operatorView];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 10,70, 30) Text:@"保存类型:"];
    [operatorView addSubview:lbl];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 40,70, 30) Text:@"文件大小:"];
    [operatorView addSubview:lbl];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 70,70, 30) Text:@"文件类型:"];
    [operatorView addSubview:lbl];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 100,70, 30) Text:@"存证时间:"];
    [operatorView addSubview:lbl];
    //保存类型
    self.bLocalFile=[[UIButton alloc]initWithFrame:CGRectMake1(90, 10, 110, 30)];
    [self.bLocalFile setTitle:@"存证到云端" forState:UIControlStateNormal];
    [self.bLocalFile setTitleColor:BGCOLOR forState:UIControlStateNormal];
    [self.bLocalFile.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [self.bLocalFile setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateNormal];
    [self.bLocalFile setImage:[UIImage imageNamed:@"player"] forState:UIControlStateSelected];
    [self.bLocalFile setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
    [self.bLocalFile addTarget:self action:@selector(saveTypeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bLocalFile];
    self.bYunFile=[[UIButton alloc]initWithFrame:CGRectMake1(200, 10, 110, 30)];
    [self.bYunFile setTitle:@"存证到本地" forState:UIControlStateNormal];
    [self.bYunFile setTitleColor:BGCOLOR forState:UIControlStateNormal];
    [self.bYunFile.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [self.bYunFile setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateNormal];
    [self.bYunFile setImage:[UIImage imageNamed:@"player"] forState:UIControlStateSelected];
    [self.bYunFile setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
    [self.bYunFile addTarget:self action:@selector(saveTypeSelected:) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bYunFile];
    //文件大小
    self.lblFileSize=[[XLLabel alloc]initWithFrame:CGRectMake1(90, 40, 100, 30) Text:@"520KB"];
    [operatorView addSubview:self.lblFileSize];
    //文件类型
    self.lblFileType=[[XLLabel alloc]initWithFrame:CGRectMake1(90, 70, 100, 30) Text:@"图片存证"];
    [operatorView addSubview:self.lblFileType];
    //存证时间
    self.lblSaveTime=[[XLLabel alloc]initWithFrame:CGRectMake1(90, 100, 100, 30) Text:@"2015-10-15"];
    [operatorView addSubview:self.lblSaveTime];
    //按钮
    CGFloat bTop=operatorView.bounds.size.height-CGHeight(50);
    XLButton *bCancel=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(20), bTop, CGWidth(130), CGHeight(40)) Name:@"取消" Type:2];
    [operatorView addSubview:bCancel];
    XLButton *bSave=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(170), bTop, CGWidth(130), CGHeight(40)) Name:@"保存" Type:3];
    [operatorView addSubview:bSave];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)saveTypeSelected:(UIButton*)button
{
    if(self.bLocalFile == button){
        [self.bLocalFile setSelected:YES];
        [self.bYunFile setSelected:NO];
    }else{
        [self.bLocalFile setSelected:NO];
        [self.bYunFile setSelected:YES];
    }
}

- (void)goPlay
{
    if(!self.movFileUrl){
        return;
    }
    self.moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:self.movFileUrl];
    [self.moviePlayer.view setFrame:self.view.bounds];
    self.moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.moviePlayer setShouldAutoplay:YES];
    [self.moviePlayer setFullscreen:YES animated:YES];
    [self.moviePlayer setRepeatMode:MPMovieRepeatModeNone];
    [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [self.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [self.navigationController.view addSubview:_moviePlayer.view];
    [self.moviePlayer play];
    
    [self addMovieNotification];
}

//添加通知监控媒体播放控制器状态
-(void)addMovieNotification
{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

//播放完成
- (void)mediaPlayerPlaybackFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.moviePlayer];
    [self.moviePlayer.view removeFromSuperview];
}

//移除所有通知监控
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end