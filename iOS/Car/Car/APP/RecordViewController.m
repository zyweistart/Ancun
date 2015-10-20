//
//  RecordViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "RecordViewController.h"
#import "NSString+Utils.h"
#import <AVFoundation/AVFoundation.h>

@interface RecordViewController ()

@end

@implementation RecordViewController{
    AVAudioRecorder *recorder;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"录音笔"];
        [self setIsRecording:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    XLButton *recordButton=[[XLButton alloc]initWithFrame:CGRectMake1(100, 100, 200, 40) Name:@"录音"];
    [recordButton addTarget:self action:@selector(startStopRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
}

//开始停止录音
- (void)startStopRecording
{
    if([self isRecording]){
        if(recorder){
            [self stopRecorder];
        }
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
            [self setIsRecording:YES];
        }
    }else{
        [self stopRecorder];
    }
}

//停止录音
- (void)stopRecorder
{
    [self setIsRecording:NO];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

@end
