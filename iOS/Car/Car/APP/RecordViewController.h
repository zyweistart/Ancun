//
//  RecordViewController.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface RecordViewController : BaseViewController<AVAudioPlayerDelegate>

@property (assign,nonatomic) NSInteger playingStep;
@property (assign,nonatomic) NSInteger recordingStep;
@property (strong,nonatomic) NSString *recordedFileName;
@property (strong,nonatomic) NSString *recordedFilePath;
@property (strong,nonatomic) XLButton *recordButton;
@property (strong,nonatomic) XLLabel *lblTimer;
@property (strong,nonatomic) UIButton *bPlayer;
@property (strong,nonatomic) UIButton *bDelete;

@end
