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

@interface LocalRecordsViewController : BaseViewController<POVoiceHUDDelegate>

@property (nonatomic) BOOL isRecording;
@property (nonatomic, retain) POVoiceHUD *voiceHud;
@property (strong, nonatomic) UIButton *recordButton;

@end
