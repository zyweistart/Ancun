//
//  PublishedSpeechSoundViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "PublishedSpeechSoundViewController.h"
#import "CLabel.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Utils.h"

#define BLACKCOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define TIMECOLOR [UIColor colorWithRed:(40/255.0) green:(145/255.0) blue:(228/255.0) alpha:1]

enum
{
    ENC_AAC = 1,
    ENC_ALAC = 2,
    ENC_IMA4 = 3,
    ENC_ILBC = 4,
    ENC_ULAW = 5,
    ENC_PCM = 6,
} encodingTypes;

@interface PublishedSpeechSoundViewController ()

@end

@implementation PublishedSpeechSoundViewController{
    NSString *recordedFileName;
    NSString *recordedFilePath;
    long currentRecordLongTime;
    
    NSTimer *timer;
    AVAudioRecorder *recorder;
    UILabel *lblTimeCount;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"发布"];
        //
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(0, 0, 30, 30)];
        [bClose setTitle:@"关闭" forState:UIControlStateNormal];
        [bClose.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bClose];
        //
        UIButton *bPublished = [[UIButton alloc]init];
        [bPublished setFrame:CGRectMake1(0, 0, 30, 30)];
        [bPublished setTitle:@"发布" forState:UIControlStateNormal];
        [bPublished.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bPublished setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bPublished addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bPublished];
        
        UIImageView *imageHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 150)];
        [imageHeader setUserInteractionEnabled:YES];
        [imageHeader setImage:[UIImage imageNamed:@"personalbg"]];
        [self.view addSubview:imageHeader];
        UIButton *bSwitch=[[UIButton alloc]initWithFrame:CGRectMake1(270, 5, 40, 30)];
        [bSwitch setTitle:@"换一张" forState:UIControlStateNormal];
        [bSwitch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bSwitch.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bSwitch addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [imageHeader addSubview:bSwitch];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(0, 60, 320, 30) Text:@"说说我的心情，寻找懂我的人"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [imageHeader addSubview:lbl];
        
        CGFloat topHeight=568-30-64;
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, topHeight, 150, 30) Text:@"同步到：微信 QQ Sina"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(160, topHeight, 150, 30) Text:@"保存到心情轨迹"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
        //录音计时
        lblTimeCount=[[UILabel alloc]initWithFrame:CGRectMake1(80, 150, 100, 40)];
        [lblTimeCount setText:@"00"];
        [self.view addSubview:lblTimeCount];
        //录音按钮
        self.recordButton=[[UIButton alloc]initWithFrame:CGRectMake1(85, 200, 40, 40)];
        [self.recordButton setTitle:@"开始" forState:UIControlStateNormal];
        [self.recordButton setTitle:@"暂停" forState:UIControlStateSelected];
        [self.recordButton setImage:[UIImage imageNamed:@"player_r"] forState:UIControlStateNormal];
        [self.recordButton setImage:[UIImage imageNamed:@"player_s"] forState:UIControlStateSelected];
        [self.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.recordButton addTarget:self action:@selector(startStopRecording:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.recordButton];
        
        self.recordDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake1(185, 200, 40, 40)];
        [self.recordDeleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.recordDeleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.recordDeleteButton addTarget:self action:@selector(deleteRecording:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.recordDeleteButton];
        [self.recordDeleteButton setHidden:YES];
        
        self.fileManager = [NSFileManager defaultManager];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRecording = NO;
}

- (void)goSwitch:(id)sender
{
    NSLog(@"换一张");
}

//删除录音
- (void)deleteRecording:(id)sender
{
    //删除
    if([self.fileManager removeItemAtPath:recordedFilePath error:NULL]){
        //删除成功
        [lblTimeCount setText:@"00"];
        [self.recordButton setHidden:NO];
        [self.recordDeleteButton setHidden:YES];
    }
}

- (void)startStopRecording:(id)sender
{
    if(!self.isRecording){
        if(recorder){
            [self stopRecorder];
        }
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        
        //生成录音文件名
        recordedFileName=[[NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970]] md5];
        //文件路径
        recordedFilePath=[NSTemporaryDirectory() stringByAppendingString:recordedFileName];
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:recordedFilePath] settings:nil error:nil];
        if([recorder prepareToRecord]){
            [recorder record];
            self.isRecording = YES;
            [self.recordButton setSelected:YES];
            [lblTimeCount setText:@"00"];
            //当前录音总时长
            currentRecordLongTime=0;
            //当前录音开始时间
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        }
        [self.recordDeleteButton setHidden:YES];
    }else{
        [self stopRecorder];
    }
}

- (void)stopRecorder
{
    [self.recordDeleteButton setHidden:NO];
    [lblTimeCount setText:@"00"];
    self.isRecording = NO;
    [self.recordButton setSelected:NO];
    [timer invalidate];
    [recorder stop];
    recorder = nil;
    //存储
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *toMoveFilePath = [documents stringByAppendingPathComponent:recordedFileName];
    if([self.fileManager moveItemAtPath:recordedFilePath toPath:toMoveFilePath error:nil]){
        NSLog(@"录音保存成功:%@",toMoveFilePath);
    }
}

- (void)timerFired:(id)sender
{
    currentRecordLongTime++;
    if(currentRecordLongTime<10){
        [lblTimeCount setText:[NSString stringWithFormat:@"0%ld",currentRecordLongTime]];
    }else{
        [lblTimeCount setText:[NSString stringWithFormat:@"%ld",currentRecordLongTime]];
    }
}

@end