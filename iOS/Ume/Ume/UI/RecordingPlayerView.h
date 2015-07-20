//
//  RecordingPlayerView.h
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordingPlayerView : UIImageView<AVAudioPlayerDelegate>

@property (strong,nonatomic)NSFileManager *fileManager;
@property (strong,nonatomic)AVAudioPlayer *mAudioPlayer;
@property (strong,nonatomic)AVAudioRecorder *mAVAudioRecorder;
@property (strong,nonatomic)NSString *docRecordedFilePath;

- (void)clear;

@end
