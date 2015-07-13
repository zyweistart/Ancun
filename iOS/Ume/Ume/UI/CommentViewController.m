//
//  CommentViewController.m
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"

@interface CommentViewController ()

@end

@implementation CommentViewController{
    UIButton *currentPlayerButton;
}

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        [self cTitle:@"评论"];
        self.isFirstRefresh=YES;
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 130)];
        [contentView setUserInteractionEnabled:YES];
        [self.view addSubview:contentView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
        self.meHeader.layer.masksToBounds=YES;
        self.meHeader.layer.borderWidth=1;
        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [contentView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [contentView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 40, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblTime];
        self.lblValue=[[CLabel alloc]initWithFrame:CGRectMake1(100, 30, 60, 20) Text:@""];
        [self.lblValue setFont:[UIFont systemFontOfSize:14]];
        [self.lblValue setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblValue];
        //语音
        CGFloat width=[PlayerVoiceButton getPlayerWidthToSecond:71];
        self.player=[[PlayerVoiceButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
        [contentView addSubview:self.player];
        
        [self.tableView setTableHeaderView:contentView];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setCurrentViewController:self];
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
        if(currentPlayerButton==button){
            [self stopAudioPlayer];
            [self stopPlayerAnimating];
            return;
        }else{
            [self stopPlayerAnimating];
        }
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
    [self stopAudioPlayer];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    [self.audioPlayer setDelegate:self];
    [self.audioPlayer setVolume:1.0];
    if([self.audioPlayer prepareToPlay]){
        [self.audioPlayer play];
    }
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(currentPlayerButton){
        [self stopPlayerAnimating];
    }
    [self stopAudioPlayer];
}

- (void)stopAudioPlayer
{
    if(self.audioPlayer){
        [self.audioPlayer stop];
        self.audioPlayer=nil;
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
    }
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

@end
