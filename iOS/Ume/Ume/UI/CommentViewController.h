//
//  CommentViewController.h
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HttpDownload.h"
#import "CLabel.h"
#import "PlayerButton.h"
#import "CLabel.h"
#import "PlayerVoiceButton.h"
#import "MessageViewFrame.h"

@protocol CommentDelegate

@optional
- (void)CommentFinisih:(NSArray*)friendsArray;

@end

@interface CommentViewController : BaseEGOTableViewPullRefreshViewController<AVAudioPlayerDelegate,HttpDownloadDelegate>

@property (strong,nonatomic)PlayerButton *bPlayer;
@property (strong,nonatomic)PlayerVoiceButton *player;
@property (strong,nonatomic)CLabel *lblCount;
@property (strong,nonatomic)MessageViewFrame *headContentView;
@property (strong,nonatomic)AVAudioPlayer *audioPlayer;
@property (strong,nonatomic)HttpDownload *httpDownload;

@property (strong,nonatomic) NSObject<CommentDelegate> *delegate;

@end
