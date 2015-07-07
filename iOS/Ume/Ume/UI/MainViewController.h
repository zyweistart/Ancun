//
//  MainViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import "HttpDownload.h"
#import "PlayerButton.h"
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : BaseEGOTableViewPullRefreshViewController<AVAudioPlayerDelegate,HttpDownloadDelegate>

@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@end
