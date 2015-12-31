//
//  BaseEntity.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseEntity.h"
#import <objc/runtime.h>

@implementation BaseEntity

+ (instancetype)buildInstanceClass:(Class)classes WithData:(NSDictionary*)data
{
    //获取类已有属性
    NSMutableArray *pNames=[[NSMutableArray alloc]init];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(classes, &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [pNames addObject:name];
    }
    free(properties);
    //动态生成类
    Class kclass = NSClassFromString([NSString stringWithUTF8String:object_getClassName(classes)]);
    id instance = [[kclass alloc] init];
    for(NSString *key in [data allKeys]){
        //循环设置属性值
        if([pNames containsObject:key]){
            [instance setValue:[data objectForKey:key] forKey:key];
        }
    }
    return instance;
}

+ (BOOL)getVariableWithClass:(Class)myClass varName:(NSString *)name
{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

@end
