//
//  BaseEntity.h
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

+ (instancetype)buildInstanceClass:(Class)classes WithData:(NSDictionary*)data;

@end
