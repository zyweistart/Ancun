//
//  PublishedSpeechSoundViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishedSpeechSoundViewController : BaseViewController<UITextViewDelegate>

@property (nonatomic) BOOL isRecording;
@property (strong,nonatomic)NSFileManager *fileManager;
@property (strong, nonatomic) UIButton *recordButton;
@property (strong, nonatomic) UIButton *recordDeleteButton;

@end
