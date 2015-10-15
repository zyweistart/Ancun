//
//  BaseItem.h
//  Car
//
//  Created by Start on 10/14/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseItem : NSObject

@property (copy,nonatomic)NSString *key;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *date;
@property (copy,nonatomic)NSString *oper;
@property (copy,nonatomic)NSString *url;
@property (copy,nonatomic)NSString *content;
@property (copy,nonatomic)NSString *type;
@property (copy,nonatomic)NSString *read;

@end
