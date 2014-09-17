#import "ACPlayerView.h"

@interface ACPlayerView ()
- (void)updateSlider;
@end

@implementation ACPlayerView{
    NSString *_path;
    NSTimer *_sliderTimer;
    AVAudioPlayer *_player;
    UIButton *_btn_player;
    UISlider *_sider_player;
    UILabel *_lbl_playertimerlong;
    UILabel *_lbl_playertimertotallong;
}

- (id)initWithController:(UIViewController*)controller
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 67)];
    if(self){
        [self setController:controller];
        [self setBackgroundColor:MAINBG];
        
        _btn_player=[[UIButton alloc]initWithFrame:CGRectMake(9, 10, 54, 47)];
        [_btn_player addTarget:self action:@selector(btnPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_player setImage:[UIImage imageNamed:@"player_normal"] forState:UIControlStateNormal];
        [self addSubview:_btn_player];
        
        _sider_player=[[UISlider alloc]initWithFrame:CGRectMake(69, 10, 233, 29)];
        [_sider_player addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_sider_player];
        
        _lbl_playertimerlong=[[UILabel alloc]initWithFrame:CGRectMake(71, 36, 70, 21)];
        [_lbl_playertimerlong setText:@"00:00"];
        [_lbl_playertimerlong setFont:[UIFont systemFontOfSize:12]];
        [_lbl_playertimerlong setTextColor:[UIColor whiteColor]];
        [_lbl_playertimerlong setTextAlignment:NSTextAlignmentLeft];
        [_lbl_playertimerlong setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_lbl_playertimerlong];
        
        _lbl_playertimertotallong=[[UILabel alloc]initWithFrame:CGRectMake(233, 36, 67, 21)];
        [_lbl_playertimertotallong setText:@"00:00"];
        [_lbl_playertimertotallong setFont:[UIFont systemFontOfSize:12]];
        [_lbl_playertimertotallong setTextColor:[UIColor whiteColor]];
        [_lbl_playertimertotallong setTextAlignment:NSTextAlignmentRight];
        [_lbl_playertimertotallong setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_lbl_playertimertotallong];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
        [self stop];
        [_sliderTimer invalidate];
        _sider_player.value = 0.0f;
        _lbl_playertimerlong.text=@"00:00";
    }
}

#pragma mark -
#pragma mark Custom Methods

//开始播放
- (void)player:(NSString *)playerPath dictionary:(NSDictionary *)dic{
    _path=playerPath;
    
    [self setDictionary:[[NSMutableDictionary alloc] initWithDictionary:dic]];
    
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
- (void)btnPlayer:(id)sender{
    if(_dictionary){
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
}

//当拖动进度条时
- (void)sliderChanged:(UISlider*)sender{
    if(_dictionary){
        if(_player){
            [_btn_player setImage:[UIImage imageNamed:@"pause_normal"] forState:UIControlStateNormal];
            [_player stop];
            [_player setCurrentTime:_sider_player.value];
            [_player prepareToPlay];
            [_player play];
        }
    }else{
        [_sider_player setValue:0];
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