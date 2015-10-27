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

@property (strong,nonatomic)UIImageView *uploadFile;
@property (strong,nonatomic)UIButton *bLocalFile;
@property (strong,nonatomic)UIButton *bYunFile;
@property (strong,nonatomic)XLLabel *lblFileSize;
@property (strong,nonatomic)XLLabel *lblFileType;
@property (strong,nonatomic)XLLabel *lblSaveTime;
@property (strong,nonatomic)NSURL *movFileUrl;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@end
