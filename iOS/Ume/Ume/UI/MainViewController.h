//
//  MainViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
@class AudioPlayer;

@interface MainViewController : BaseEGOTableViewPullRefreshViewController

@property (strong,nonatomic) AudioPlayer *audioPlayer;

@end
