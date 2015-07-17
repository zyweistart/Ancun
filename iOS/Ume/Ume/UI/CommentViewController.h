//
//  CommentViewController.h
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerVoiceButton.h"
#import "MessageViewFrame.h"
#import "PlayerButton.h"

@protocol CommentDelegate

@optional
- (void)CommentFinisih:(NSArray*)friendsArray;

@end

@interface CommentViewController : BaseEGOTableViewPullRefreshViewController<AVAudioPlayerDelegate>

@property (strong,nonatomic)PlayerButton *bPlayer;
@property (strong,nonatomic)PlayerVoiceButton *player;
@property (strong,nonatomic)CLabel *lblCount;
@property (strong,nonatomic)MessageViewFrame *headContentView;
@property (strong,nonatomic)AVAudioPlayer *audioPlayer;

@property (strong,nonatomic) NSObject<CommentDelegate> *delegate;

@end
