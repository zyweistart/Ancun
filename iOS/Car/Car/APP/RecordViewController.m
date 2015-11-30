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
    UIImageView *sonic;
    UIButton *rightButtonSaveType;
    NSInteger saveType;
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
    UIView *recordView=[[UIView alloc]initWithFrame:self.view.bounds];
    [recordView setBackgroundColor:BCOLOR(243)];
    [self.view addSubview:recordView];
    
    UIImageView *sonicW1=[[UIImageView alloc]initWithFrame:CGRectMake1(55, 61, 210, 210)];
    [sonicW1 setImage:[UIImage imageNamed:@"动画外圈2"]];
    [recordView addSubview:sonicW1];
    UIImageView *sonicW2=[[UIImageView alloc]initWithFrame:CGRectMake1(7, 8, 195, 195)];
    [sonicW2 setImage:[UIImage imageNamed:@"动画外圈1"]];
    [sonicW1 addSubview:sonicW2];
    
    sonic=[[UIImageView alloc]initWithFrame:CGRectMake1(15, 15, 165, 165)];
    [sonic setImage:[UIImage imageNamed:@"IOS动画1"]];
    sonic.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"IOS动画1"],
                             [UIImage imageNamed:@"IOS动画2"],
                             [UIImage imageNamed:@"IOS动画3"],
                             [UIImage imageNamed:@"IOS动画4"],
                             [UIImage imageNamed:@"IOS动画5"],
                             [UIImage imageNamed:@"IOS动画6"],
                             [UIImage imageNamed:@"IOS动画7"],
                             [UIImage imageNamed:@"IOS动画8"],
                             [UIImage imageNamed:@"IOS动画9"],
                             [UIImage imageNamed:@"IOS动画10"],
                             [UIImage imageNamed:@"IOS动画11"], nil];
    // all frames will execute in 1.75 seconds
    sonic.animationDuration = 1.0;
    // repeat the annimation forever
    sonic.animationRepeatCount = 0;
    [sonicW2 addSubview:sonic];
    
    self.lblTimer=[[XLLabel alloc]initWithFrame:CGRectMake1(0, 290, 320, 50) Text:@"00:00:00"];
    [self.lblTimer setFont:GLOBAL_FONTSIZE(40)];
    [self.lblTimer setTextColor:BGCOLOR];
    [self.lblTimer setTextAlignment:NSTextAlignmentCenter];
    [recordView addSubview:self.lblTimer];
    
    operatorView=[[UIView alloc]initWithFrame:CGRectMake(0, recordView.bounds.size.height-CGHeight(100)-64, CGWidth(320), CGHeight(40))];
    [recordView addSubview:operatorView];
    self.bPlayer=[[UIButton alloc]initWithFrame:CGRectMake1(115, 0, 40, 40)];
    [self.bPlayer setImage:[UIImage imageNamed:@"播放_开始"] forState:UIControlStateNormal];
    [self.bPlayer setImage:[UIImage imageNamed:@"播放_停止"] forState:UIControlStateSelected];
    [self.bPlayer addTarget:self action:@selector(startStopPlaying) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bPlayer];
    self.bDelete=[[UIButton alloc]initWithFrame:CGRectMake1(165, 0, 40, 40)];
    [self.bDelete setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [self.bDelete addTarget:self action:@selector(deleteRecorder) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:self.bDelete];
    
    self.recordButton=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), recordView.bounds.size.height-CGHeight(45)-64, CGWidth(300), CGHeight(40)) Name:@"点击开始录音" Type:3];
    [self.recordButton addTarget:self action:@selector(startStopRecording) forControlEvents:UIControlEventTouchUpInside];
    [recordView addSubview:self.recordButton];
    //
    rightButtonSaveType = [[UIButton alloc]initWithFrame:CGRectMake(0,0,115,40)];
    [rightButtonSaveType.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [rightButtonSaveType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButtonSaveType setImage:[UIImage imageNamed:@"箭头_下拉"] forState:UIControlStateNormal];
    [rightButtonSaveType setImageEdgeInsets:UIEdgeInsetsMake(0, 105, 0, 0)];
    [rightButtonSaveType addTarget:self action:@selector(switchSaveType) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButtonSaveType];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    saveType=1;
    [self switchSaveType];
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
        [self setPlayingStep:1];
        [self startStopPlaying];
    }
}

- (void)saveTo
{
    if(saveType==1){
        NSLog(@"保存到云端");
    }else{
        [self saveRecorderToLocal:@"备注信息"];
    }
}

//开始停止播放
- (void)startStopPlaying
{
    [self stopPlayer];
    if([self playingStep]==0){
        [sonic startAnimating];
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
                [self.bPlayer setSelected:YES];
                [self setPlayingStep:1];
                currentPlayLongTime=0;
                [self timerFiredPlayer];
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredPlayer) userInfo:nil repeats:YES];
            }
        }
    }else{
        [sonic stopAnimating];
        [self setPlayingStep:0];
        currentPlayLongTime=0;
        [self.bPlayer setSelected:NO];
        [self.lblTimer setText:@"00:00:00"];
    }
}

//开始停止录音
- (void)startStopRecording
{
    [self stopRecorder];
    if(self.recordingStep==0){
        [sonic startAnimating];
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
        [sonic stopAnimating];
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
            [self saveTo];
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

//切换保存类型
- (void)switchSaveType
{
    saveType=saveType==1?2:1;
    if(saveType==1){
        [rightButtonSaveType setTitle:@"保存到云端" forState:UIControlStateNormal];
    }else{
        [rightButtonSaveType setTitle:@"保存到本地" forState:UIControlStateNormal];
    }
}

//保存录音
- (void)saveRecorderToLocal:(NSString*)remark
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