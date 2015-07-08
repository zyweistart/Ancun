//
//  UYourDetailViewController.h
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CLabel.h"
#import "PlayerButton.h"
#import "HttpDownload.h"

@interface UYourDetailViewController : BaseEGOTableViewPullRefreshViewController<AVAudioPlayerDelegate,HttpDownloadDelegate>

- (id)initWithData:(NSDictionary*)data;

@property (strong,nonatomic)UIImageView *meHeader;
@property (strong,nonatomic)UIImageView *mFelationship;
@property (strong,nonatomic)UIImageView *youHeader;
@property (strong,nonatomic)PlayerButton *bPlayer;
@property (strong,nonatomic)CLabel *lblContent;
@property (strong,nonatomic)CLabel *lblName;
@property (strong,nonatomic)CLabel *lblTime;
@property (strong,nonatomic)CLabel *lblValue;
@property (strong,nonatomic)CLabel *lblCount;

@property (strong,nonatomic)AVAudioPlayer *audioPlayer;
@property (strong,nonatomic)HttpDownload *httpDownload;

@property (strong,nonatomic)NSFileManager *fileManager;

@end