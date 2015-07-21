//
//  MainViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MainViewController.h"
#import "UYourDetailViewController.h"
#import "ContentCell.h"
#import "NSString+Utils.h"
#import "LabelScreening.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIView *bgView;
    LabelScreening *mButton1,*mButton2,*mButton3,*mButton4;
    UIButton *currentPlayerButton;
    NSInteger currentType;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"懂你"];
        self.isFirstRefresh=YES;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        //筛选
        [self cNavigationRightItemType:2 Title:@"筛选" action:@selector(goScreening)];
        
        bgView=[[UIView alloc]initWithFrame:self.view.bounds];
        [bgView setBackgroundColor:DEFAULTITLECOLORA(100,0.5)];
        [bgView setUserInteractionEnabled:YES];
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goScreening)]];
        [self.view addSubview:bgView];
        [bgView setHidden:YES];
        //筛选
        UIView *downRefresh=[[UIView alloc]initWithFrame:CGRectMake1(219, 1, 100, 120)];
        downRefresh.layer.borderWidth=1;
        downRefresh.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [downRefresh setBackgroundColor:[UIColor whiteColor]];
        [bgView addSubview:downRefresh];
        
        mButton1=[[LabelScreening alloc]initWithFrame:CGRectMake1(0, 0, 100, 30)];
        [mButton1.lblTitle setText:@"最新"];
        [mButton1 setTag:1];
        [mButton1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hScreening:)]];
        [downRefresh addSubview:mButton1];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(5, 30, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton2=[[LabelScreening alloc]initWithFrame:CGRectMake1(0, 30, 100, 30)];
        [mButton2.lblTitle setText:@"最热"];
        [mButton2 setTag:2];
        [mButton2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hScreening:)]];
        [downRefresh addSubview:mButton2];
        line=[[UIView alloc]initWithFrame:CGRectMake1(5, 60, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton3=[[LabelScreening alloc]initWithFrame:CGRectMake1(0, 60, 100, 30)];
        [mButton3.lblTitle setText:@"离我最近"];
        [mButton3 setTag:3];
        [mButton3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hScreening:)]];
        [downRefresh addSubview:mButton3];
        line=[[UIView alloc]initWithFrame:CGRectMake1(5, 90, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton4=[[LabelScreening alloc]initWithFrame:CGRectMake1(0, 90, 100, 30)];
        [mButton4.lblTitle setText:@"只看异性"];
        [mButton4 setTag:4];
        [mButton4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hScreening:)]];
        [downRefresh addSubview:mButton4];
        
        [mButton1 setSelected:YES];
        currentType=1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)goScreening
{
    [bgView setHidden:![bgView isHidden]];
}

- (void)hScreening:(UIGestureRecognizer*)sender
{
    LabelScreening *ls=((LabelScreening*)[sender view]);
    [mButton1 setSelected:NO];
    [mButton2 setSelected:NO];
    [mButton3 setSelected:NO];
    [mButton4 setSelected:NO];
    [self goScreening];
    [ls setSelected:YES];
    currentType=ls.tag;
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(205);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSInteger row=[indexPath row];
        NSMutableDictionary *data=[[self dataItemArray]objectAtIndex:row];
        
        NSString *headUrl=[Common getString:[data objectForKey:@"headUrl"] DefaultValue:@""];
        NSString *bestDwHeadUrl=[Common getString:[data objectForKey:@"bestDwHeadUrl"] DefaultValue:@""];
        NSString *name=[Common getString:[data objectForKey:@"name"] DefaultValue:@""];
        NSString *time=[Common getString:[data objectForKey:@"time"] DefaultValue:@""];
        NSString *backgroupUrl=[Common getString:[data objectForKey:@"backgroupUrl"] DefaultValue:@""];
        NSString *content=[Common getString:[data objectForKey:@"content"] DefaultValue:@""];
        NSString *commentCount=[Common getString:[data objectForKey:@"commentCount"] DefaultValue:@"0"];
        [cell setData:data];
        if(![@"" isEqualToString:headUrl]){
            [self.hDownload AsynchronousDownloadWithUrl:headUrl RequestCode:500 Object:cell.meHeader];
        }
        [cell.lblName setText:name];
        [cell.lblTime setText:time];
        [cell setFelationshipStat:2];
        if([@"" isEqualToString:bestDwHeadUrl]){
            [self.hDownload AsynchronousDownloadWithUrl:bestDwHeadUrl RequestCode:500 Object:cell.youHeader];
        }
        NSString *pstatus=[data objectForKey:@"pstatus"];
        if([@"1" isEqualToString:pstatus]){
            if(currentPlayerButton!=nil&&currentPlayerButton.tag==row){
                [cell.bPlayer.imageView startAnimating];
            }else{
                [data setObject:@"0" forKey:@"pstatus"];
                [cell.imageView stopAnimating];
            }
        }else{
            [cell.bPlayer.imageView stopAnimating];
        }
        [cell.bDM setTitle:[NSString stringWithFormat:@"%@懂我",commentCount] forState:UIControlStateNormal];
        [self.hDownload AsynchronousDownloadWithUrl:backgroupUrl RequestCode:500 Object:cell.mBackground];
        [cell.lblContent setText:content];
        [cell.lblContent sizeToFit];
        cell.bPlayer.tag = row;
        [cell.bPlayer addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self stopAudioPlayer];
    if([[self dataItemArray] count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        UINavigationController *mUYourDetailViewController=[[UINavigationController alloc]initWithRootViewController:[[UYourDetailViewController alloc]initWithData:data]];
        [self presentViewController:mUYourDetailViewController animated:YES completion:nil];
    }else{
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[NSString stringWithFormat:@"%ld",currentType] forKey:@"type"];//筛选1最新 2最热 3离我最近 4只看美女
    [params setObject:@"getPublish" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:nil requestParams:params];
}

- (void)playAudio:(UIButton *)button
{
    if(currentPlayerButton==button){
        [self stopAudioPlayer];
        [self stopPlayerAnimating];
        return;
    }else{
        [self stopPlayerAnimating];
    }
    currentPlayerButton=button;
    NSInteger currentPlayerRow = currentPlayerButton.tag;
    NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
    [item setObject:@"1" forKey:@"pstatus"];
    [currentPlayerButton.imageView startAnimating];
    NSString *urlStr = [item objectForKey:@"recordUrl"];
    [self.hDownload AsynchronousDownloadWithUrl:urlStr RequestCode:501 Object:nil];
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(reqCode==501){
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
    }else if(reqCode==500){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
            }
        }
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
    NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
    [item setObject:@"0" forKey:@"pstatus"];
    [currentPlayerButton.imageView stopAnimating];
    currentPlayerButton=nil;
}

@end