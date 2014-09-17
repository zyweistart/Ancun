#import "ACPlayerView.h"
#import "ACExtractionDetailViewController.h"
#import "ACRecordingManagerDetailListViewController.h"
#import "ACNotaryDetailViewController.h"

@interface ACPlayerView ()
- (void)updateSlider;
@end

@implementation ACPlayerView{
    HttpRequest *_playerViewHttp;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:[_dictionary objectForKey:@"fileno"] forKey:@"fileno"];
            //1:取消出证;2:申请出证
            [requestParams setObject:@"2" forKey:@"cerflag"];
            _playerViewHttp=[[HttpRequest alloc]init];
            [_playerViewHttp setDelegate:self];
            [_playerViewHttp setController:_controller];
            [_playerViewHttp setRequestCode:REQUESTCODE_APPLYNOTARY];
            [_playerViewHttp loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:[_dictionary objectForKey:@"fileno"] forKey:@"fileno"];
            //1:取消出证;2:申请出证
            [requestParams setObject:@"1" forKey:@"cerflag"];
            _playerViewHttp=[[HttpRequest alloc]init];
            [_playerViewHttp setDelegate:self];
            [_playerViewHttp setController:_controller];
            [_playerViewHttp setRequestCode:REQUESTCODE_CANCELNOTARY];
            [_playerViewHttp loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==3){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:[_dictionary objectForKey:@"fileno"] forKey:@"fileno"];
            //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
            [requestParams setObject:@"1" forKey:@"acccodeact"];
            [requestParams setObject:@"10" forKey:@"vtime"];
            _playerViewHttp=[[HttpRequest alloc]init];
            [_playerViewHttp setDelegate:self];
            [_playerViewHttp setController:_controller];
            [_playerViewHttp setRequestCode:REQUESTCODE_ACExtractionDetailViewController_apply];
            [_playerViewHttp loginhandle:@"v4recAcccode" requestParams:requestParams];
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode{
    if([response successFlag]){
        if(reqCode==REQUESTCODE_APPLYNOTARY){
            [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
            [_dictionary setObject:@"2" forKey:@"cerflag"];
            ACRecordingManagerDetailListViewController *con=(ACRecordingManagerDetailListViewController*)_controller;
            for(NSMutableDictionary *dic in [con dataItemArray]){
                if([[dic objectForKey:@"fileno"] isEqualToString:[_dictionary objectForKey:@"fileno"]]){
                    [dic setObject:@"2" forKey:@"cerflag"];
                    [[con tableView]reloadData];
                    break;
                }
            }
            
            ACNotaryDetailViewController *notaryDetailViewController=[[ACNotaryDetailViewController alloc]init];
            notaryDetailViewController.hidesBottomBarWhenPushed = YES;
            [_controller.navigationController pushViewController:notaryDetailViewController animated:YES];
        }else if(reqCode==REQUESTCODE_CANCELNOTARY){
            [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
            [_dictionary setObject:@"1" forKey:@"cerflag"];
            ACRecordingManagerDetailListViewController *con=(ACRecordingManagerDetailListViewController*)_controller;
            for(NSMutableDictionary *dic in [con dataItemArray]){
                if([[dic objectForKey:@"fileno"] isEqualToString:[_dictionary objectForKey:@"fileno"]]){
                    [dic setObject:@"1" forKey:@"cerflag"];
                    [[con tableView]reloadData];
                    break;
                }
            }
            
            [Common notificationMessage:@"取消成功" inView:self.controller.view];
        }else if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply||
                 reqCode==REQUESTCODE_ACExtractionDetailViewController_view){
            [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
            [_dictionary setObject:@"1" forKey:@"accstatus"];
            ACRecordingManagerDetailListViewController *con=(ACRecordingManagerDetailListViewController*)_controller;
            for(NSMutableDictionary *dic in [con dataItemArray]){
                if([[dic objectForKey:@"fileno"] isEqualToString:[_dictionary objectForKey:@"fileno"]]){
                    [dic setObject:@"1" forKey:@"accstatus"];
                    [[con tableView]reloadData];
                    break;
                }
            }
            ACExtractionDetailViewController *extractionDetailViewController=[[ACExtractionDetailViewController alloc]init];
            [extractionDetailViewController setFileno:[_dictionary objectForKey:@"fileno"]];
            if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply){
                [extractionDetailViewController setLoad:NO];
            }else{
                [extractionDetailViewController setLoad:YES];
            }
            [extractionDetailViewController setResultDelegate:self];
            [extractionDetailViewController setExtractionDics:[[response mainData]objectForKey:@"acccodeinfo"]];
            extractionDetailViewController.hidesBottomBarWhenPushed = YES;
            [_controller.navigationController pushViewController:extractionDetailViewController animated:YES];
        }
    }
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
        [self stop];
        [_sliderTimer invalidate];
        _sider_player.value = 0.0f;
        _lbl_playertimerlong.text=@"00:00";
    }
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary*)result{
    if(resultCode==RESULTCODE_ACExtractionDetailViewController_back){
        if([[result objectForKey:@"accstatus"] isEqualToString:@"2"]){
            [_dictionary setObject:@"2" forKey:@"accstatus"];
            
            ACRecordingManagerDetailListViewController *con=(ACRecordingManagerDetailListViewController*)_controller;
            for(NSMutableDictionary *dic in [con dataItemArray]){
                if([[dic objectForKey:@"fileno"] isEqualToString:[_dictionary objectForKey:@"fileno"]]){
                    [dic setObject:[result objectForKey:@"accstatus"] forKey:@"accstatus"];
                    [[con tableView]reloadData];
                    break;
                }
            }
            
            [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

+ (ACPlayerView *)instance:(UIViewController *)viewController{
    ACPlayerView *playerView=[[[NSBundle mainBundle] loadNibNamed:@"ACPlayerView" owner:nil options:nil] objectAtIndex:0];
    [playerView setController:viewController];
    [playerView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"player_gb"]]];
    return playerView;
}

//开始播放
- (void)player:(NSString *)playerPath dictionary:(NSMutableDictionary *)dic{
    [self setPath:playerPath];
    
    [self setDictionary:[[NSMutableDictionary alloc] initWithDictionary:dic]];
    
    if([[_dictionary objectForKey:@"cerflag"] isEqualToString:@"1"]){
        [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
    }else if([[_dictionary objectForKey:@"cerflag"] isEqualToString:@"2"]){
        [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
    }
    if([[_dictionary objectForKey:@"accstatus"] isEqualToString:@"1"]){
        [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
    }else if([[_dictionary objectForKey:@"accstatus"] isEqualToString:@"2"]){
        [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
    }
    [_btn_notary setEnabled:true];
    [_btn_extraction setEnabled:true];
    [_btn_player setEnabled:true];
    [_sider_player setEnabled:true];
    
    if(_player){
        [self stop];
    }
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:_path] error:nil];
    _player.delegate=self;
    [_player setVolume:1.0];
    [_player prepareToPlay];
    
    //设置为与当前音频播放同步的Timer
    _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    //进度条的最大值设定为音频的播放时间
    _sider_player.minimumValue=0.0f;
    _sider_player.maximumValue = [[_dictionary objectForKey:@"duration"] intValue];
    _sider_player.value = 0.0f;
    
    _lbl_playertimerlong.text=@"00:00";
    _lbl_playertimertotallong.text=[Common secondConvertFormatTimerByEn:[_dictionary objectForKey:@"duration"]];
    
    //播放音频
    [_player play];
    [self updateSlider];
    [_btn_player setImage:[UIImage imageNamed:@"pause_normal"] forState:UIControlStateNormal];
}

//停止播放
- (void)stop{
    [_btn_player setImage:[UIImage imageNamed:@"player_normal"] forState:UIControlStateNormal];
    if(_player){
        [_player stop];
        _player=nil;
    }
}

//播放按钮
- (IBAction)btnPlayer:(id)sender{
    if(_player){
        if([_player isPlaying]){
            [_btn_player setImage:[UIImage imageNamed:@"player_normal"] forState:UIControlStateNormal];
            [_player pause];
        }else{
            [_btn_player setImage:[UIImage imageNamed:@"pause_normal"] forState:UIControlStateNormal];
            [_player play];
        }
    }else{
        [self player:_path dictionary:_dictionary];
    }
}

//申办取消出证
- (IBAction)notary:(id)sender{
    [self stop];
    if([[Config Instance] isMaster]){
        if([[_dictionary objectForKey:@"cerflag"] isEqualToString:@"1"]){
            [Common actionSheet:self message:@"您确定将该录音提交至公证机构申办公证吗？" tag:1];
        }else if([[_dictionary objectForKey:@"cerflag"] isEqualToString:@"2"]){
            [Common actionSheet:self message:@"您确定要取消该录音申办公证吗？" tag:2];
        }
    }else{
        [Common alert:@"暂无权限"];
    }
}

//申请查看提取码
- (IBAction)extraction:(id)sender{
    [self stop];
    if([[_dictionary objectForKey:@"accstatus"] isEqualToString:@"1"]){
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:[_dictionary objectForKey:@"fileno"] forKey:@"fileno"];
        //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
        [requestParams setObject:@"2" forKey:@"acccodeact"];
        _playerViewHttp=[[HttpRequest alloc]init];
        [_playerViewHttp setDelegate:self];
        [_playerViewHttp setController:_controller];
        [_playerViewHttp setRequestCode:REQUESTCODE_ACExtractionDetailViewController_view];
        [_playerViewHttp loginhandle:@"v4recAcccode" requestParams:requestParams];
    }else if([[_dictionary objectForKey:@"accstatus"] isEqualToString:@"2"]){
        if([[Config Instance]isAuth:auth_v4recalter8]){
            [Common actionSheet:self message:@"凭提取码可在官网公开查询、验证本条通话录音，确定申请？" tag:3];
        }else{
            [Common alert:@"暂无权限"];
        }
    }
}

//当拖动进度条时
- (IBAction)sliderChanged:(UISlider*)sender{
    if(_player){
        [_btn_player setImage:[UIImage imageNamed:@"pause_normal"] forState:UIControlStateNormal];
        [_player stop];
        [_player setCurrentTime:_sider_player.value];
        [_player prepareToPlay];
        [_player play];
    }
}

//更新播放进度条
- (void)updateSlider{
    if(_player){
        float duration=[[_dictionary objectForKey:@"duration"] intValue];
        float currentTime=round(_player.currentTime);
        if(duration>_player.currentTime){
            if(duration>currentTime){
                currentTime++;
            }
        }
        _sider_player.value=currentTime;
        _lbl_playertimerlong.text=[Common secondConvertFormatTimerByEn:[NSString stringWithFormat:@"%f",currentTime]];
    }
}

@end