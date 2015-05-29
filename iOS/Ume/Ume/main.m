//
//  main.m
//  Ume
//
//  Created by Start on 5/13/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+Utils.h"
#import "AESCrypt.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {

        NSString *enkey=@"44A9CE83845076EEFE391430DABA3F26";
        NSString *pwdmd5=[@"1234" md5];
        NSString *decr=[AESCrypt decrypt:enkey password:pwdmd5];
        NSLog(@"%@",decr);
//        NSString *encr=[AESCrypt encrypt:enkey password:pwdmd5];
//        NSLog(@"%@",encr);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
