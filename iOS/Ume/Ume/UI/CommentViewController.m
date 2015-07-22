//
//  CommentViewController.m
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "MessageViewFrame.h"

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
        [self cNavigationRightItemType:2 Title:@"赞" action:@selector(zambia:)];
        
        UIView *headFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 230)];
        self.headContentView=[[MessageViewFrame alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
        [headFrame addSubview:self.headContentView];
        UIView *titleHead=[[UIView alloc]initWithFrame:CGRectMake1(0, 190, 320, 40)];
        [titleHead setBackgroundColor:DEFAULTITLECOLOR(245)];
        titleHead.layer.borderWidth=1;
        titleHead.layer.borderColor=DEFAULTITLECOLOR(221).CGColor;
        [headFrame addSubview:titleHead];
        //总数
        self.lblCount=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 150, 40) Text:@""];
        [self.lblCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblCount setTextColor:DEFAULTITLECOLOR(100)];
        [self.lblCount setText:@"所有评论(15)"];
        [titleHead addSubview:self.lblCount];
        
        //底部
        CGFloat height=40;
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(height+54), CGWidth(320), CGHeight(height))];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bottomView];
        //私信
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 320, height)];
        [button setTitle:@"评论" forState:UIControlStateNormal];
        [button setTitleColor:DEFAULTITLECOLOR(50) forState:UIControlStateNormal];
        [button setBackgroundColor:COLOR2552160];
        [button addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        [self.tableView setTableHeaderView:headFrame];
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
        return CGHeight(190);
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
        [self.hDownload AsynchronousDownloadWithUrl:urlStr RequestCode:501 Object:nil];
    }else{
        NSInteger currentPlayerRow = currentPlayerButton.tag;
        NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
        [item setObject:@"1" forKey:@"pstatus"];
        [currentPlayerButton.imageView startAnimating];
        NSString *urlStr = [item objectForKey:@"recordUrl"];
        [self.hDownload AsynchronousDownloadWithUrl:urlStr RequestCode:501 Object:nil];
    }
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
    if(currentPlayerRow!=-1){
        NSMutableDictionary *item = [self.dataItemArray objectAtIndex:currentPlayerRow];
        [item setObject:@"0" forKey:@"pstatus"];
    }
    [currentPlayerButton.imageView stopAnimating];
    currentPlayerButton=nil;
}

- (void)comment:(id)sender
{
    [self.delegate CommentFinisih:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zambia:(id)sender
{
    NSLog(@"赞");
}

@end
