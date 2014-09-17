//
//  ACMore.m
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

#import "ACMore.h"

@implementation ACMore

- (id)initWith:(NSString *)name andImg:(NSString *)img andTag:(int)tag{
    self = [super init];
    if (self) {
        [self setName:name];
        [self setImg:img];
        [self setTag:tag];
    }
    return self;
}

@end
