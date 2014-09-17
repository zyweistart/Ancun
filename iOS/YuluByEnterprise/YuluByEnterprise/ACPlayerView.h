#import <AVFoundation/AVFoundation.h>

@interface ACPlayerView : UIView<AVAudioPlayerDelegate,UIActionSheetDelegate,ResultDelegate,HttpViewDelegate>{
    
    NSTimer *_sliderTimer;
    AVAudioPlayer *_player;
    
}

@property (strong,nonatomic) NSString *path;
@property (strong,nonatomic) NSMutableDictionary *dictionary;
@property (strong,nonatomic) UIViewController *controller;

@property (strong, nonatomic) IBOutlet UIButton *btn_notary;
@property (strong, nonatomic) IBOutlet UIButton *btn_extraction;
@property (strong, nonatomic) IBOutlet UIButton *btn_player;
@property (strong, nonatomic) IBOutlet UISlider *sider_player;
@property (strong, nonatomic) IBOutlet UILabel *lbl_playertimerlong;
@property (strong, nonatomic) IBOutlet UILabel *lbl_playertimertotallong;

+ (ACPlayerView *)instance:(UIViewController *)viewController;

- (void)player:(NSString *)playerPath dictionary:(NSMutableDictionary*)dic;
- (void)stop;

- (IBAction)btnPlayer:(id)sender;
- (IBAction)sliderChanged:(UISlider *)sender;
- (IBAction)notary:(id)sender;
- (IBAction)extraction:(id)sender;

@end