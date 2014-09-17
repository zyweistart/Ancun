#import "Config.h"

@implementation Config

static Config * instance = nil;
+ (Config *) Instance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
        }
    }
    return instance;
}

+ (void)resetConfig {
    instance=nil;
}

@end
