//
//  Message.h
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (copy,nonatomic)NSString *key;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *date;
@property (copy,nonatomic)NSString *oper;
@property (copy,nonatomic)NSString *url;
@property (copy,nonatomic)NSString *content;
@property (copy,nonatomic)NSString *type;
@property (copy,nonatomic)NSString *read;

@end
