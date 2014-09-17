#import <AVFoundation/AVFoundation.h>

@interface ACPlayerView : UIView<AVAudioPlayerDelegate>

@property (strong,nonatomic) NSMutableDictionary *dictionary;
@property (strong,nonatomic) UIViewController *controller;

- (id)initWithController:(UIViewController*)controller;

- (void)player:(NSString *)playerPath dictionary:(NSDictionary*)dic;
- (void)stop;

@end