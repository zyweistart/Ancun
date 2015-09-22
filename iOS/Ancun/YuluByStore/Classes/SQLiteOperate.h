//
//  SQLiteOperate.h
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Message.h"

@interface SQLiteOperate : NSObject

//打开数据库
- (BOOL)openDB;
//执行SQL语句
- (BOOL)execSql:(NSString *)sql;
//查询语句
- (NSMutableArray*)queryWithColumns:(NSArray*)columns WithSQL:(NSString*)sql;

- (BOOL)createTableMessageNotification;
- (NSMutableArray*)getAllMessageNotification;
- (BOOL)insertMessageNotification:(Message*)message;
- (BOOL)updateMessageNotification:(Message*)message;
- (NSInteger)getNoReadMessageNotificationCount;

@end