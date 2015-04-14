//
//  LocalRecordsViewController.m
//  Ancun
//
//  Created by Start on 4/14/15.
//
//

#import "LocalRecordsViewController.h"

#define PLAYNAME @"播放"
#define STOPNAME @"停止"
#define RECORDNAME @"播放"


#define BLACKCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface LocalRecordsViewController ()

@end

@implementation LocalRecordsViewController

- (id)init
{
    self=[super init];
    if(self){
        self.title=@"现场录音";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.playButton=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 200, 40)];
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playPause:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.playButton];
        self.recordButton=[[UIButton alloc]initWithFrame:CGRectMake1(0, 50, 200, 40)];
        [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
        [self.recordButton addTarget:self action:@selector(startStopRecording:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.recordButton];
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRecording = NO;
    [self.playButton setEnabled:NO];
    self.playButton.titleLabel.alpha = 0.5;
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"RecordedFile"]];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil){
        NSLog(@"Error creating session: %@", [sessionError description]);
    } else {
        [session setActive:YES error:nil];
    }
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 300, 300,40)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 170,40)];
    [lbl setText:@"剩余存储可录音制"];
    [lbl setTextColor:BLACKCOLOR];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [bottomView addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(190, 0, 100,40)];
    [lbl setText:@"10小时以上"];
    [lbl setTextColor:BLACKCOLOR];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:lbl];
    [self.view addSubview:bottomView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.voiceHud = [[POVoiceHUD alloc] initWithParentView:self.view];
    self.voiceHud.title = @"Speak Now";
    [self.voiceHud setDelegate:self];
    [self.view addSubview:self.voiceHud];
}

- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setRecordButton:nil];
    recorder = nil;
    player = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // [fileManager removeItemAtPath:recordedFile.path error:nil];
    [fileManager removeItemAtURL:recordedFile error:nil];
    recordedFile = nil;
    [super viewDidUnload];
}

- (void)playPause:(id)sender
{
    if([player isPlaying]){
        [player pause];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    } else {
        [player play];
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (void)startStopRecording:(id)sender
{
    if(!self.isRecording){
        [self.voiceHud startForFilePath:[NSTemporaryDirectory() stringByAppendingString:@"RecordedFile"]];
        self.isRecording = YES;
        [self.recordButton setTitle:@"STOP" forState:UIControlStateNormal];
        [self.playButton setEnabled:NO];
        [self.playButton.titleLabel setAlpha:0.5];
        recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:nil error:nil];
        [recorder prepareToRecord];
        [recorder record];
        player = nil;
    }else{
        self.isRecording = NO;
        [self.recordButton setTitle:@"REC" forState:UIControlStateNormal];
        [self.playButton setEnabled:YES];
        [self.playButton.titleLabel setAlpha:1];
        [recorder stop];
        recorder = nil;
        NSError *playerError;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedFile error:&playerError];
        if (player == nil){
            NSLog(@"ERror creating player: %@", [playerError description]);
        }
        player.delegate = self;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
}

#pragma mark - POVoiceHUD Delegate

- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength {
    NSLog(@"Sound recorded with file %@ for %.2f seconds", [recordPath lastPathComponent], recordLength);
}

- (void)voiceRecordCancelledByUser:(POVoiceHUD *)voiceHUD {
    NSLog(@"Voice recording cancelled for HUD: %@", voiceHUD);
}

@end