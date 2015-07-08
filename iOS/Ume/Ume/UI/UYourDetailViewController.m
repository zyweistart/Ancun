//
//  UYourDetailViewController.m
//  Ume
//  懂你详细页
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "UYourDetailViewController.h"
#import "WordsDetailViewController.h"
#import "PlayerVoiceButton.h"
#import "ReplyMDCell.h"
#import "CLabel.h"
#import <AVFoundation/AVFoundation.h>

@interface UYourDetailViewController ()

@end

@implementation UYourDetailViewController{
    UIImageView *sonic;
    UIImageView *buttonPlayer;
    UIButton *currentPlayerButton;
    
    UIButton *startRecordingButton;
    UIButton *playRecordingButton;
    UIButton *recordDeleteButton;
    CLabel *lblPressRecording;
    NSInteger recordingStep;
}

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        [self cTitle:@"懂你详情"];
        self.isFirstRefresh=NO;
        [self.navigationController.navigationBar setHidden:YES];
        UIView *headContent=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 300)];
        [self.view addSubview:headContent];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [image setBackgroundColor:DEFAULTITLECOLOR(221)];
        [image setUserInteractionEnabled:YES];
        [headContent addSubview:image];
        //关闭
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(5, 20, 30, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateHighlighted];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:bClose];
        //分享
        UIButton *bShare = [[UIButton alloc]init];
        [bShare setFrame:CGRectMake1(285, 20, 30, 30)];
        [bShare setImage:[UIImage imageNamed:@"icon-top-share"] forState:UIControlStateNormal];
        [bShare addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:bShare];
        //播放
        self.bPlayer=[[PlayerButton alloc]initWithFrame:CGRectMake1(140, 60, 40, 40)];
        [self.bPlayer addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:self.bPlayer];
        //内容
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(10, 130, 300, 40)];
        [self.lblContent setFont:[UIFont systemFontOfSize:15]];
        [self.lblContent setTextColor:[UIColor whiteColor]];
        [self.lblContent setNumberOfLines:2];
        [image addSubview:self.lblContent];
        
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 200, 320, 60)];
        [headContent addSubview:contentView];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        topView.layer.borderWidth=1;
        topView.layer.borderColor=DEFAULTITLECOLOR(221).CGColor;
        [contentView addSubview:topView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
        self.meHeader.layer.masksToBounds=YES;
        self.meHeader.layer.borderWidth=1;
        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [topView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(242, 82, 159)];
        [topView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 40, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [topView addSubview:self.lblTime];
        self.lblValue=[[CLabel alloc]initWithFrame:CGRectMake1(100, 30, 60, 20) Text:@""];
        [self.lblValue setFont:[UIFont systemFontOfSize:14]];
        [self.lblValue setTextColor:DEFAULTITLECOLOR(150)];
        [topView addSubview:self.lblValue];
        self.mFelationship=[[UIImageView alloc]initWithFrame:CGRectMake1(160, 10, 90, 40)];
        [self.mFelationship setImage:[UIImage imageNamed:@"icon-match"]];
        [topView addSubview:self.mFelationship];
        self.youHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(270, 10, 40, 40)];
        self.youHeader.layer.cornerRadius=self.youHeader.bounds.size.width/2;
        self.youHeader.layer.masksToBounds=YES;
        self.youHeader.layer.borderWidth=1;
        self.youHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [topView addSubview:self.youHeader];
        UIView *titleHead=[[UIView alloc]initWithFrame:CGRectMake1(0, 60, 320, 40)];
        [titleHead setBackgroundColor:DEFAULTITLECOLOR(245)];
        [topView addSubview:titleHead];
        //总数
        self.lblCount=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 150, 40) Text:@""];
        [self.lblCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblCount setTextColor:DEFAULTITLECOLOR(100)];
        [titleHead addSubview:self.lblCount];
        
        //底部
        CGFloat height=40;
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(height), CGWidth(320), CGHeight(height))];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bottomView];
        //私信
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 159, height)];
        [button setTitle:@"私信" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(50) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon-home-私信"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-10), 0, 0)];
        [button setBackgroundColor:COLOR2552160];
        [bottomView addSubview:button];
        //你最懂我
        button=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 160, height)];
        [button setTitle:@"你最懂我" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(50) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon-dw-black"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-10), 0, 0)];
        [button setBackgroundColor:COLOR2552160];
        [button addTarget:self action:@selector(goDW:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        [self.tableView setTableHeaderView:headContent];
        
        self.httpDownload=[[HttpDownload alloc]init];
        [self.httpDownload setDelegate:self];
        //背景
        NSString *backgroupUrl=[data objectForKey:@"backgroupUrl"];
        [self.httpDownload AsynchronousDownloadImageWithUrl:backgroupUrl ShowImageView:image];
        //内容
        NSString *content=[data objectForKey:@"content"];
        [self.lblContent setText:content];
        [self.lblContent sizeToFit];
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"Jackywell"];
        [self.lblTime setText:@"15:22"];
        [self.lblValue setText:@"开心70%"];
        [self.lblCount setText:@"所有懂你(12)"];
        [self.youHeader setImage:[UIImage imageNamed:@"img_girl"]];
        
        height=220;
        //评论
        UIView *bgFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [bgFrame setBackgroundColor:DEFAULTITLECOLORA(100,0.5)];
        [bgFrame setUserInteractionEnabled:YES];
        [self.view addSubview:bgFrame];
        UIView *commentFrame=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(height), CGWidth(320), CGHeight(height))];
        [commentFrame setBackgroundColor:DEFAULTITLECOLOR(250)];
        [bgFrame addSubview:commentFrame];
        //
        button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 60, 35)];
        [button setTitle:@"发语音" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [button setTitleColor:COLOR2552160 forState:UIControlStateSelected];
        [commentFrame addSubview:button];
        [button setSelected:YES];
        //
        button=[[UIButton alloc]initWithFrame:CGRectMake1(60, 0, 60, 35)];
        [button setTitle:@"发图片" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [button setTitleColor:COLOR2552160 forState:UIControlStateSelected];
        [commentFrame addSubview:button];
        //
        button=[[UIButton alloc]initWithFrame:CGRectMake1(120, 0, 60, 35)];
        [button setTitle:@"@某人" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [button setTitleColor:COLOR2552160 forState:UIControlStateSelected];
        [commentFrame addSubview:button];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 35, 300, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(230)];
        [commentFrame addSubview:line];
        
        buttonPlayer=[[UIImageView alloc]initWithFrame:CGRectMake1(75, 40, 170, 170)];
        [buttonPlayer setUserInteractionEnabled:YES];
        buttonPlayer.animationImages = [NSArray arrayWithObjects:
                                            [UIImage imageNamed:@"play-bg-1"],
                                            [UIImage imageNamed:@"play-bg-2"],
                                            [UIImage imageNamed:@"play-bg-3"],nil];
        [buttonPlayer setAnimationDuration:1.0];
        [buttonPlayer setAnimationRepeatCount:0];
        [commentFrame addSubview:buttonPlayer];
        
        //录音
        startRecordingButton=[[UIButton alloc]initWithFrame:CGRectMake1(45, 45, 80, 80)];
        startRecordingButton.layer.cornerRadius=startRecordingButton.bounds.size.width/2;
        startRecordingButton.layer.masksToBounds=YES;
        [startRecordingButton setImage:[UIImage imageNamed:@"icon-luyin"] forState:UIControlStateNormal];
        startRecordingButton.imageView.animationImages = [NSArray arrayWithObjects:
                                                           [UIImage imageNamed:@"播放中-1"],
                                                           [UIImage imageNamed:@"播放中-2"],
                                                           [UIImage imageNamed:@"播放中-3"],
                                                           [UIImage imageNamed:@"播放中-4"], nil];
        [startRecordingButton.imageView setAnimationDuration:1.0];
        [startRecordingButton.imageView setAnimationRepeatCount:0];
        [startRecordingButton setBackgroundColor:COLOR2552160];
        [startRecordingButton addTarget:self action:@selector(reocrdingUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [buttonPlayer addSubview:startRecordingButton];
        //播放
        playRecordingButton=[[UIButton alloc]initWithFrame:CGRectMake1(45, 45, 80, 80)];
        playRecordingButton.layer.cornerRadius=playRecordingButton.bounds.size.width/2;
        playRecordingButton.layer.masksToBounds=YES;
        [playRecordingButton setImage:[UIImage imageNamed:@"icon-play-big"] forState:UIControlStateNormal];
        [playRecordingButton setImage:[UIImage imageNamed:@"icon-stop-big"] forState:UIControlStateSelected];
        [playRecordingButton setBackgroundColor:COLOR2552160];
        [playRecordingButton addTarget:self action:@selector(playRecording:) forControlEvents:UIControlEventTouchUpInside];
        [playRecordingButton setHidden:YES];
        [buttonPlayer addSubview:playRecordingButton];
        //按下录音文字
        lblPressRecording=[[CLabel alloc]initWithFrame:CGRectMake1(45, 130, 80, 30) Text:@"按下录音"];
        [lblPressRecording setFont:[UIFont systemFontOfSize:18]];
        [lblPressRecording setTextAlignment:NSTextAlignmentCenter];
        [buttonPlayer addSubview:lblPressRecording];
        //删除
        recordDeleteButton=[[UIButton alloc]initWithFrame:CGRectMake1(130, 90, 30, 30)];
        recordDeleteButton.layer.cornerRadius=recordDeleteButton.bounds.size.width/2;
        recordDeleteButton.layer.masksToBounds = YES;
        recordDeleteButton.layer.borderWidth=1;
        recordDeleteButton.layer.borderColor=[[UIColor redColor]CGColor];
        [recordDeleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [recordDeleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [recordDeleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [recordDeleteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [recordDeleteButton addTarget:self action:@selector(recordingDel:) forControlEvents:UIControlEventTouchUpInside];
        [recordDeleteButton setHidden:YES];
        [buttonPlayer addSubview:recordDeleteButton];
        
        self.fileManager = [NSFileManager defaultManager];
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(130);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        ReplyMDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ReplyMDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSInteger row=[indexPath row];
        //        NSDictionary *data=[[self dataItemArray]objectAtIndex:[indexPath row]];
        //        [cell setData:data];
        //        [cell.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        //        [cell.youHeader setImage:[UIImage imageNamed:@"img_girl"]];
        //        [cell.lblName setText:@"Jackywell"];
        //        [cell.lblTime setText:@"15:22"];
        //        [cell.bDM setTitle:[NSString stringWithFormat:@"%@懂我",@"21"] forState:UIControlStateNormal];
        ////        NSString *backgroupUrl=[data objectForKey:@"backgroupUrl"];
        ////        [httpDownload AsynchronousDownloadImageWithUrl:backgroupUrl ShowImageView:cell.mBackground];
        //        NSString *content=[data objectForKey:@"content"];
        //        [cell.lblContent setText:content];
        //        [cell.lblContent sizeToFit];
        cell.player.tag=row;
        [cell.player addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"type"];//筛选1最新 2最热 3离我最近 4只看美女
    [params setObject:@"getPublish" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:nil requestParams:params];
}

- (void)playAudio:(UIButton*)button
{
    if(currentPlayerButton){
        [self stopPlayerAnimating];
    }
    currentPlayerButton=button;
    if(self.bPlayer==button){
        button.tag=-1;
        [currentPlayerButton.imageView startAnimating];
        NSString *urlStr = [self.data objectForKey:@"recordUrl"];
        [self.httpDownload AsynchronousDownloadWithUrl:urlStr RequestCode:500];
    }else{
        NSInteger currentPlayerRow = currentPlayerButton.tag;
        NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
        [item setObject:@"1" forKey:@"pstatus"];
        [currentPlayerButton.imageView startAnimating];
        NSString *urlStr = [item objectForKey:@"recordUrl"];
        [self.httpDownload AsynchronousDownloadWithUrl:urlStr RequestCode:500];
    }
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path
{
    //播放本地音乐
    if(self.audioPlayer){
        [self.audioPlayer stop];
        self.audioPlayer=nil;
    }
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    [self.audioPlayer setDelegate:self];
    [self.audioPlayer setVolume:1.0];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(currentPlayerButton){
        [self stopPlayerAnimating];
    }
    [self.audioPlayer stop];
    self.audioPlayer=nil;
}

- (void)stopPlayerAnimating
{
    NSInteger currentPlayerRow = currentPlayerButton.tag;
    if(currentPlayerRow!=-1){
        NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
        [item setObject:@"0" forKey:@"pstatus"];
    }
    [currentPlayerButton.imageView stopAnimating];
    currentPlayerButton=nil;
}

- (void)goDW:(id)sender
{
    
}

- (void)reocrdingUpInside:(UIButton*)sender
{
    if([startRecordingButton.imageView isAnimating]){
        [playRecordingButton setHidden:NO];
        [recordDeleteButton setHidden:NO];
        [lblPressRecording setHidden:YES];
        [buttonPlayer stopAnimating];
        [startRecordingButton.imageView stopAnimating];
    }else{
        [recordDeleteButton setHidden:YES];
        [lblPressRecording setHidden:YES];
        [buttonPlayer startAnimating];
        [startRecordingButton.imageView startAnimating];
    }
}

- (void)playRecording:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
    if(sender.selected){
        [buttonPlayer startAnimating];
    }else{
        [buttonPlayer stopAnimating];
    }
}

- (void)recordingDel:(UIButton*)sender
{
    [playRecordingButton setHidden:YES];
    [recordDeleteButton setHidden:YES];
    [lblPressRecording setHidden:NO];
    [buttonPlayer stopAnimating];
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