//
//  MainViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : BaseEGOTableViewPullRefreshViewController<AVAudioPlayerDelegate>

@property (strong,nonatomic) AVAudioPlayer *audioPlayer;

@end
