//
//  LocalRecordsViewController.h
//  Ancun
//
//  Created by Start on 4/14/15.
//
//

#import "BaseViewController.h"
#import "POVoiceHUD.h"
#import <AVFoundation/AVFoundation.h>

@interface LocalRecordsViewController : BaseViewController<AVAudioPlayerDelegate,POVoiceHUDDelegate>{
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}

@property (nonatomic, retain) POVoiceHUD *voiceHud;
@property (nonatomic) BOOL isRecording;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *recordButton;

@end
