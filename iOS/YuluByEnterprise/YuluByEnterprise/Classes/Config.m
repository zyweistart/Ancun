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

#pragma mark 是否为老用户
- (BOOL) isOldUser {
    //1老用户 2新用户
    return [@"1" isEqualToString:[[[Config Instance] userInfo] objectForKey:@"uflag"]];
}

- (BOOL) isMaster {
    return [@"1" isEqualToString:[[[Config Instance] userInfo] objectForKey:@"masterflag"]];
}

- (BOOL)isAuth:(NSString*)authName {
    
    if([self isMaster]){
        return YES;
    }
    
    for (NSMutableDictionary *dic in [[Config Instance]userAuthList]) {
        
        if([authName isEqualToString:[dic objectForKey:@"authcode"]]){
            return YES;
        }
        
    }
    
    return NO;
}

@end
