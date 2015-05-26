//
//  LocalRecordsViewController.h
//  Ancun
//
//  Created by Start on 4/14/15.
//
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LocalRecordsViewController : BaseViewController<UIAlertViewDelegate>

@property (nonatomic) BOOL isRecording;
@property (strong, nonatomic) UIButton *recordButton;

@end
