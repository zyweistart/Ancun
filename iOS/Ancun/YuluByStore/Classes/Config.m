#import "Config.h"

@implementation Config

static Config * instance = nil;
+ (Config *) Instance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
            //禁止拨打的号码列表
            NSMutableArray* phoneList=[[NSMutableArray alloc]init];
            [phoneList addObject:@"110"];
            [phoneList addObject:@"112"];
            [phoneList addObject:PHONENUMBER];
            [instance setNoDialPhoneNumber:phoneList];
        }
    }
    return instance;
}

+ (void)resetConfig {
    instance=nil;
}

@end
