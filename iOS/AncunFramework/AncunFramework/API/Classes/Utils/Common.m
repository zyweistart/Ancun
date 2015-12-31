//
//  Common.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "Common.h"

//#import "NotifyHUD.h"

@implementation Common

+ (id)getCache:(NSString *)key{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:key];
}

+ (void)setCache:(NSString *)key data:(id)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setObject:data forKey:key];
    [setting synchronize];
}

+ (BOOL)getCacheByBool:(NSString *)key{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings boolForKey:key];
}

+ (void)setCacheByBool:(NSString *)key data:(BOOL)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setBool:data forKey:key];
    [setting synchronize];
}

+ (NSString*)formatPhone:(NSString*)phone
{
    if(phone){
        NSMutableString *phoneNumber=[[NSMutableString alloc]init];
        for(int i=0;i<[phone length];i++){
            unichar c=[phone characterAtIndex:i];
            if((c>=48&&c<=57)||c==43){
                [phoneNumber appendFormat:@"%c",c];
            }
        }
        return [NSString stringWithFormat:@"%@",phoneNumber];
    }
    return @"";
}

+ (BOOL)isNull:(id)obj
{
    return obj==nil;
}

+ (NSString*)nullConvertString:(id)value
{
    if([Common isNull:value]){
        return @"";
    }
    return [NSString stringWithFormat:@"%@",value];
}

+ (void)alert:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil];
    [alert show];
//    [NotifyHUD alert:message];
}
+ (UIAlertController *)alertTitle:(NSString *)title Message:(NSString *)message confirmMsg:(NSString *)confirmMsg CancleMsg:(NSString *)msg confirmBlock:(void(^)(UIAlertAction *action))confirm
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:confirmMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(action);
        }
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    return alertController;
    
}

+ (NSString *)getDocumentFilePath:(NSString *)fileName;
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //1.拼接文件路径
    return  [NSString stringWithFormat:@"%@/%@",path,fileName];
    
}

+ (NSString*)getAppVersion
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)getAppBuild
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
}

+ (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (NSString*)buildFileNameWithUrl:(NSString*)url
{
    NSString *ext=[url pathExtension];
    return [NSString stringWithFormat:@"%@.%@",[url md5],ext];
}

+ (void)authenticateUser
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //错误对象
    NSError* error = nil;
    NSString* result = @"Authentication is needed to access your notes.";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"验证成功，主线程处理UI");
            } else {
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"切换到其他APP，系统取消验证Touch ID");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"用户选择输入自定义密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择其他验证方式，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    } else {
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"未登记指纹");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"未设置密码");
                break;
            }
            default:
            {
                NSLog(@"指纹不可用");
                break;
            }
        }
    }
}



@end