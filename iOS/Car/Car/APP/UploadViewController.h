//
//  UploadViewController.h
//  Car
//
//  Created by Start on 10/14/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface UploadViewController : BaseViewController

@property (strong,nonatomic)UIImageView *thumImage;
@property (strong,nonatomic)UIButton *bLocalFile;
@property (strong,nonatomic)UIButton *bYunFile;
@property (strong,nonatomic)XLLabel *lblFileSize;
@property (strong,nonatomic)XLLabel *lblFileType;
@property (strong,nonatomic)XLLabel *lblSaveTime;

@property (strong,nonatomic)UIImage *originalImage;
@property (strong,nonatomic)NSURL *movFileUrl;
//保存类型1、图片2、录像
@property (assign,nonatomic)NSInteger saveType;
@property (strong,nonatomic)NSString *saveTime;
@property (assign,nonatomic)long long fileSize;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@end
