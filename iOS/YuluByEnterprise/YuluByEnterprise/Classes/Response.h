//
//  ACResponse.h
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

@interface Response : NSObject

@property Boolean successFlag;
@property (strong,nonatomic) NSData *data;
@property (strong,nonatomic) NSMutableDictionary *propertys;
@property (strong,nonatomic) NSString *responseString;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *msg;
@property (strong,nonatomic) NSMutableDictionary *pageInfo;
@property (strong,nonatomic) NSMutableArray *dataItemArray;
@property (strong,nonatomic) NSMutableDictionary *mainData;

@end