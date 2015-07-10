//
//  RecordingPlayerView.m
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "RecordingPlayerView.h"
#import "NSString+Utils.h"
#import "CLabel.h"

@implementation RecordingPlayerView{
    
    UILabel *lblTimeCount;
    UIButton *startRecordingButton;
    UIButton *recordDeleteButton;
    CLabel *lblTextTip;
    
    NSInteger recordingStep;
    NSString *recordedFileName;
    NSString *tempRecordedFilePath;
    NSInteger currentRecordLongTime;
    
    NSTimer *timer;
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setUserInteractionEnabled:YES];
        self.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"play-bg-1"],
                                        [UIImage imageNamed:@"play-bg-2"],
                                        [UIImage imageNamed:@"play-bg-3"],nil];
        [self setAnimationDuration:1.0];
        [self setAnimationRepeatCount:0];
        
        //时间
        lblTimeCount=[[CLabel alloc]initWithFrame:CGRectMake1(45, 15, 80, 30) Text:@"00'"];
        [lblTimeCount setFont:[UIFont systemFontOfSize:18]];
        [lblTimeCount setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lblTimeCount];
        //录音
        startRecordingButton=[[UIButton alloc]initWithFrame:CGRectMake1(45, 45, 80, 80)];
        startRecordingButton.layer.cornerRadius=startRecordingButton.bounds.size.width/2;
        startRecordingButton.layer.masksToBounds=YES;
        //录音动画
        startRecordingButton.imageView.animationImages = [NSArray arrayWithObjects:
                                                          [UIImage imageNamed:@"播放中-1"],
                                                          [UIImage imageNamed:@"播放中-2"],
                                                          [UIImage imageNamed:@"播放中-3"],
                                                          [UIImage imageNamed:@"播放中-4"], nil];
        [startRecordingButton.imageView setAnimationDuration:1.0];
        [startRecordingButton.imageView setAnimationRepeatCount:0];
        [startRecordingButton setBackgroundColor:COLOR2552160];
        [startRecordingButton addTarget:self action:@selector(reocrdingUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startRecordingButton];
        
        //按下录音文字
        lblTextTip=[[CLabel alloc]initWithFrame:CGRectMake1(45, 130, 80, 30) Text:@""];
        [lblTextTip setFont:[UIFont systemFontOfSize:18]];
        [lblTextTip setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lblTextTip];
        //删除
        recordDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake1(140, 90, 30, 30)];
        recordDeleteButton.layer.cornerRadius=recordDeleteButton.bounds.size.width/2;
        recordDeleteButton.layer.masksToBounds = YES;
        recordDeleteButton.layer.borderWidth=1;
        recordDeleteButton.layer.borderColor=[[UIColor redColor]CGColor];
        [recordDeleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [recordDeleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [recordDeleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [recordDeleteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [recordDeleteButton addTarget:self action:@selector(deleteRecording:) forControlEvents:UIControlEventTouchUpInside];
        [recordDeleteButton setHidden:YES];
        [self addSubview:recordDeleteButton];
        
        self.fileManager = [NSFileManager defaultManager];
        
        recordingStep=1;
        [self setStartRecordingButtonStatus];
    }
    return self;
}

- (void)reocrdingUpInside:(UIButton*)sender
{
    if(recordingStep==1){
        [lblTextTip setText:@"点击停止"];
        recordingStep++;
        [self setStartRecordingButtonStatus];
        //开始录音
        [self startAVAudioRecorder];
    }else if(recordingStep==2){
        [lblTextTip setText:@"点击播放"];
        [self stopAnimating];
        [startRecordingButton.imageView stopAnimating];
        recordingStep++;
        [self setStartRecordingButtonStatus];
        //停止录音
        [self stopAVAudioRecorder];
    }else if(recordingStep==3){
        [lblTextTip setText:@"点击停止"];
        recordingStep++;
        [self setStartRecordingButtonStatus];
        //开始播放
        [self startAudioPlayer];
    }else if(recordingStep==4){
        [lblTextTip setText:@"点击播放"];
        [self stopAnimating];
        recordingStep--;
        [self setStartRecordingButtonStatus];
        //停止播放
        [self stopAudioPlayer];
    }
}
//删除录音
- (void)deleteRecording:(id)sender
{
    //删除文件
    if([self.fileManager removeItemAtPath:self.docRecordedFilePath error:NULL]){
        self.docRecordedFilePath=nil;
        //停止播放
        [self stopAudioPlayer];
        //文件删除成功
        [self stopAnimating];
        recordingStep=1;
        [self setStartRecordingButtonStatus];
    }
}
//设置状态
- (void)setStartRecordingButtonStatus
{
    if(recordingStep==1){
        //录音
        [lblTextTip setText:@"点击说话"];
        [startRecordingButton setImage:[UIImage imageNamed:@"icon-luyin"] forState:UIControlStateNormal];
        [lblTimeCount setHidden:YES];
        [recordDeleteButton setHidden:YES];
    }else if(recordingStep==2){
        //录音中
        [lblTimeCount setText:@"00'"];
        [self startAnimating];
        [startRecordingButton.imageView startAnimating];
        [lblTimeCount setHidden:NO];
        [recordDeleteButton setHidden:YES];
    }else if(recordingStep==3){
        //播放
        [startRecordingButton setImage:[UIImage imageNamed:@"icon-play-big"] forState:UIControlStateNormal];
        [lblTimeCount setHidden:NO];
        [recordDeleteButton setHidden:NO];
    }else if(recordingStep==4){
        [self startAnimating];
        //暂停
        [startRecordingButton setImage:[UIImage imageNamed:@"icon-stop-big"] forState:UIControlStateNormal];
        [lblTimeCount setHidden:NO];
        [recordDeleteButton setHidden:YES];
    }
}
//开始录音
- (void)startAVAudioRecorder
{
    [self stopAVAudioRecorder];
    //生成录音文件名
    recordedFileName=[[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]] md5];
    //文件路径
    tempRecordedFilePath=[NSTemporaryDirectory() stringByAppendingString:recordedFileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:tempRecordedFilePath];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDictionary *recordSetting =[[NSDictionary alloc] initWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless],AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMax],AVEncoderAudioQualityKey,nil];
    self.mAVAudioRecorder = [[AVAudioRecorder alloc] initWithURL:fileUrl settings:recordSetting error:nil];
    if([self.mAVAudioRecorder prepareToRecord]){
        [self.mAVAudioRecorder record];
        //当前录音总时长
        currentRecordLongTime=0;
        //当前录音开始时间
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
}
//停止录音
- (void)stopAVAudioRecorder
{
    if(self.mAVAudioRecorder){
        [timer invalidate];
        [self.mAVAudioRecorder stop];
        self.mAVAudioRecorder = nil;
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
        //存储
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        self.docRecordedFilePath = [documents stringByAppendingPathComponent:recordedFileName];
        if([self.fileManager moveItemAtPath:tempRecordedFilePath toPath:self.docRecordedFilePath error:nil]){
            //录音保存成功
        }
    }
}
//开始播放录音
- (void)startAudioPlayer
{
    [self stopAudioPlayer];
    NSURL *fileURL = [NSURL fileURLWithPath:self.docRecordedFilePath];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    self.mAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    [self.mAudioPlayer setDelegate:self];
    [self.mAudioPlayer setVolume:1.0];
    if([self.mAudioPlayer prepareToPlay]){
        [self.mAudioPlayer play];
    }
}
//停止播放录音
- (void)stopAudioPlayer
{
    if(self.mAudioPlayer){
        [self.mAudioPlayer stop];
        self.mAudioPlayer=nil;
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
    }
}

- (void)timerFired:(id)sender
{
    currentRecordLongTime++;
    if(currentRecordLongTime<10){
        [lblTimeCount setText:[NSString stringWithFormat:@"0%ld'",currentRecordLongTime]];
    }else{
        [lblTimeCount setText:[NSString stringWithFormat:@"%ld'",currentRecordLongTime]];
    }
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopAnimating];
    recordingStep=3;
    [self setStartRecordingButtonStatus];
    //停止播放
    [self stopAudioPlayer];
}

@end