//
//  ACMore.h
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

@interface ACMore : NSObject

@property int tag;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *img;

- (id)initWith:(NSString *)name andImg:(NSString *)img andTag:(int)tag;

@end
