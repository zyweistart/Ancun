//
//  RecordViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "RecordViewController.h"
#import "NSString+Utils.h"

@interface RecordViewController ()

@end

@implementation RecordViewController{
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    NSTimer *timer;
    UIView *operatorView;
    long currentPlayLongTime;
    long currentRecordLongTime;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"录音笔"];
        [self setPlayingStep:0];
        [self setRecordingStep:0];
        [operatorView setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *recordView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGWidth(320), self.view.bounds.size.height-CGHeight(50))];
    [recordView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:recordView];
    
    self.lblTimer=[[XLLabel alloc]initWithFrame:CGRectMake1(50, 60, 200, 40) Text:@"00:00:00"];
    [self.lblTimer setFont:GLOBAL_FONTSIZE(20)];
    [self.lblTimer setTextColor:[UIColor whiteColor]];
    [recordView addSubview:self.lblTimer];
    
    operatorView=[[UIView alloc]initWithFrame:CGRectMake(0, recordView.bounds.size.height-CGHeight(45), CGWidth(320), CGHeight(40))];
    [recordView addSubview:operatorView];
    self.bPlayer=[[XLButton alloc]initWithFrame:CGRectMake1(10, 0, 140, 40) Name:@"播放"];
    [self.bPlayer addTarget:self action:@selector(startStopPlaying) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bPlayer];
    self.bDelete=[[XLButton alloc]initWithFrame:CGRectMake1(160, 0, 140, 40) Name:@"删除"];
    [self.bDelete addTarget:self action:@selector(deleteRecorder) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bDelete];
    
    self.recordButton=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), self.view.bounds.size.height-CGHeight(45), CGWidth(300), CGHeight(40)) Name:@"点击开始录音"];
    [self.recordButton addTarget:self action:@selector(startStopRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存到本地" style:UIBarButtonItemStylePlain target:self action:@selector(saveTo)];
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"播放结束");
        [self setPlayingStep:1];
        [self startStopPlaying];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        [self deleteRecorder];
    }else if(buttonIndex==1){
        //存储
        [self saveRecorder:@"备注111"];
    }
}

- (void)saveTo
{
    
}

//开始停止播放
- (void)startStopPlaying
{
    [self stopPlayer];
    if([self playingStep]==0){
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //如果录音文件存在都直接播放
        if([fileManager fileExistsAtPath:self.recordedFilePath]){
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            [[AVAudioSession sharedInstance] setActive:YES error:nil];
            player=[[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:self.recordedFilePath] error:nil];
            [player setVolume:1.0];
            [player setDelegate:self];
            if([player prepareToPlay]){
                [player play];
                [self setPlayingStep:1];
                [self.bPlayer setTitle:@"停止" forState:UIControlStateNormal];
                currentPlayLongTime=0;
                [self timerFiredPlayer];
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredPlayer) userInfo:nil repeats:YES];
            }
        }
    }else{
        [self setPlayingStep:0];
        currentPlayLongTime=0;
        [self.bPlayer setTitle:@"播放" forState:UIControlStateNormal];
    }
}

//开始停止录音
- (void)startStopRecording
{
    [self stopRecorder];
    if(self.recordingStep==0){
        //开始录音
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        //文件名称
        self.recordedFileName=[[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]] md5];
        //文件路径
        self.recordedFilePath=[NSTemporaryDirectory() stringByAppendingString:self.recordedFileName];
        //录音设置
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
        recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:self.recordedFilePath] settings:recordSettings error:nil];
        if([recorder prepareToRecord]){
            [recorder record];
            
            [self setRecordingStep:1];
            [operatorView setHidden:YES];
            [self.recordButton setTitle:@"点击停止录音" forState:UIControlStateNormal];
            //当前录音总时长
            currentRecordLongTime=0;
            [self timerFiredRecorder];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredRecorder) userInfo:nil repeats:YES];
        }
    }else{
        if(self.recordingStep==1){
            //停止录音
            [self setRecordingStep:2];
            [operatorView setHidden:NO];
            [self.recordButton setTitle:@"保存录音" forState:UIControlStateNormal];
        }else if(self.recordingStep==2){
            //保存录音
            [self setRecordingStep:0];
            [operatorView setHidden:YES];
            [self.recordButton setTitle:@"点击开始录音" forState:UIControlStateNormal];
            currentRecordLongTime=0;
            [self.lblTimer setText:@"00:00:00"];
            [self showAlert];
        }else{
            //保存录音
            [self setRecordingStep:0];
            [operatorView setHidden:YES];
            [self.recordButton setTitle:@"点击开始录音" forState:UIControlStateNormal];
            currentRecordLongTime=0;
            [self.lblTimer setText:@"00:00:00"];
        }
    }
}

//停止播放
- (void)stopPlayer
{
    if(player){
        [player stop];
        player=nil;
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [timer invalidate];
    }
}

//停止录音
- (void)stopRecorder
{
    if(recorder){
        [recorder stop];
        recorder=nil;
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [timer invalidate];
    }
}

//删除录音
- (void)deleteRecorder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:self.recordedFilePath error:NULL]){
        //删除成功
        [self setRecordingStep:3];
        [self startStopRecording];
    }
}

//保存录音
- (void)saveRecorder:(NSString*)remark
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *toMoveFilePath = [documents stringByAppendingPathComponent:self.recordedFileName];
    if([fileManager moveItemAtPath:self.recordedFilePath toPath:toMoveFilePath error:nil]){
//        NSURL *fileURL=[NSURL fileURLWithPath:toMoveFilePath];
//        AVURLAsset *mp3Asset=[AVURLAsset URLAssetWithURL:fileURL options:nil];
//        CMTime audioDuration = mp3Asset.duration;
//        float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
        NSLog(@"%@,文件保存成功%@",remark,toMoveFilePath);
    }
}

- (void)showAlert
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"保存录音" message:@"请输入文件名" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"存储", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)timerFiredPlayer
{
    currentPlayLongTime++;
    long hour=currentPlayLongTime/(60*60);
    long min=currentPlayLongTime/60%60;
    long second=currentPlayLongTime%60;
    NSString *h,*m,*s;
    if(hour<10){
        h=[NSString stringWithFormat:@"0%ld",hour];
    }else{
        h=[NSString stringWithFormat:@"%ld",hour];
    }
    if(min<10){
        m=[NSString stringWithFormat:@"0%ld",min];
    }else{
        m=[NSString stringWithFormat:@"%ld",min];
    }
    if(second<10){
        s=[NSString stringWithFormat:@"0%ld",second];
    }else{
        s=[NSString stringWithFormat:@"%ld",second];
    }
    [self.lblTimer setText:[NSString stringWithFormat:@"%@:%@:%@",h,m,s]];
}

- (void)timerFiredRecorder
{
    currentRecordLongTime++;
    long hour=currentRecordLongTime/(60*60);
    long min=currentRecordLongTime/60%60;
    long second=currentRecordLongTime%60;
    NSString *h,*m,*s;
    if(hour<10){
        h=[NSString stringWithFormat:@"0%ld",hour];
    }else{
        h=[NSString stringWithFormat:@"%ld",hour];
    }
    if(min<10){
        m=[NSString stringWithFormat:@"0%ld",min];
    }else{
        m=[NSString stringWithFormat:@"%ld",min];
    }
    if(second<10){
        s=[NSString stringWithFormat:@"0%ld",second];
    }else{
        s=[NSString stringWithFormat:@"%ld",second];
    }
    [self.lblTimer setText:[NSString stringWithFormat:@"%@:%@:%@",h,m,s]];
}

@end