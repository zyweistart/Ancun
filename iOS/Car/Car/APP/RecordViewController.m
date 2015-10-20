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
    self.recordButton=[[XLButton alloc]initWithFrame:CGRectMake1(100, 100, 200, 40) Name:@"录音"];
    [self.recordButton addTarget:self action:@selector(startStopRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
}

//开始停止录音
- (void)startStopRecording
{
    [self stopRecorder];
    if(![self isRecording]){
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
            [self.recordButton setTitle:@"停止" forState:UIControlStateNormal];
        }
    }else{
        [self setIsRecording:NO];
        [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
    }
}

//停止录音
- (void)stopRecorder
{
    if(recorder){
        [recorder stop];
        recorder=nil;
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [self saveRecorder:@"备注111"];
    }
}

//存储
- (void)saveRecorder:(NSString*)remark
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *toMoveFilePath = [documents stringByAppendingPathComponent:self.recordedFileName];
    if([fileManager moveItemAtPath:self.recordedFilePath toPath:toMoveFilePath error:nil]){
        NSLog(@"%@,文件保存成功",remark);
    }
}

@end
