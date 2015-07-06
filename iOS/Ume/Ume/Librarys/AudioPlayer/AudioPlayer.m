#import "AudioPlayer.h"
#import "AudioStreamer.h"

@implementation AudioPlayer

@synthesize streamer, button, url;


- (id)init
{
    self = [super init];
    if (self) {
        
    }

    return self;
}


- (BOOL)isProcessing
{
    return [streamer isPlaying] || [streamer isWaiting] || [streamer isFinishing] ;
}

- (void)play
{        
    if (!streamer) {
        
        self.streamer = [[AudioStreamer alloc] initWithURL:self.url];
        
        // set up display updater
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:@selector(updateProgress)]];    
        [invocation setSelector:@selector(updateProgress)];
        [invocation setTarget:self];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             invocation:invocation 
                                                repeats:YES];
        
        // register the streamer on notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackStateChanged:)
                                                     name:ASStatusChangedNotification
                                                   object:streamer];
    }
    
    if ([streamer isPlaying]) {
        [streamer pause];
    } else {
        [streamer start];
    }
}

- (void)stop
{
    [button.imageView stopAnimating];
    button = nil; // 避免播放器的闪烁问题
    
    // release streamer
	if (streamer){
		[streamer stop];
		streamer = nil;
        
        // remove notification observer for streamer
		[[NSNotificationCenter defaultCenter] removeObserver:self 
                                                        name:ASStatusChangedNotification
                                                      object:streamer];		
	}
}

- (void)updateProgress
{
}


- (void)playbackStateChanged:(NSNotification *)notification
{
	if ([streamer isWaiting]){
        NSLog(@"isWaiting");
    } else if ([streamer isIdle]) {
        [self stop];
        NSLog(@"isIdle");
    } else if ([streamer isPaused]) {
        NSLog(@"isPaused");
    } else if ([streamer isPlaying]) {
        NSLog(@"isPlaying");
    } else if ([streamer isFinishing]) {
        NSLog(@"isFinishing");
	} else {
        NSLog(@"other");
    }
}

@end
