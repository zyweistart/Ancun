//
//  ACResponse.h
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

@interface Response : NSObject

@property BOOL successFlag;
@property (strong,nonatomic) NSData *data;
@property (strong,nonatomic) NSString *responseString;
@property (strong,nonatomic) NSDictionary *propertys;
@property (strong,nonatomic) NSDictionary *resultJSON;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

@end