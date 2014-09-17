//
//  BookService.h
//  Magazine
//
//  Created by Start on 6/12/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACAppDelegate.h"
#import "Book.h"

@interface BookService : NSObject

- (NSArray*)getList;
- (Book*)get:(NSString*)periods;
- (BOOL)save:(NSDictionary*)data;
- (BOOL)saveByBook:(Book *)book;
- (NSMutableDictionary*)bookConvertDictionary:(Book*)book;

@end
