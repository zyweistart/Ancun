//
//  SQLiteOperate.h
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "VideoItem.h"
#import "RecordItem.h"
#import "PhotographItem.h"

@interface SQLiteOperate : NSObject

//打开数据库
- (BOOL)openDB;
//执行SQL语句
- (BOOL)execSql:(NSString *)sql;
//查询语句
- (NSMutableArray*)queryWithColumns:(NSArray*)columns WithSQL:(NSString*)sql;

//录像
- (BOOL)createTableVideoItem;
- (NSMutableArray*)getAllVideoItem;
- (BOOL)insertVideoItem:(VideoItem*)item;
- (BOOL)updateVideoItem:(VideoItem*)item;
- (BOOL)deleteVideoItem:(VideoItem*)item;
//录音
//- (BOOL)createTableRecordItem;
//- (NSMutableArray*)getAllRecordItem;
//- (BOOL)insertRecordItem:(RecordItem*)item;
//- (BOOL)updateRecordItem:(RecordItem*)item;
//- (BOOL)deleteRecordItem:(RecordItem*)item;
//拍照




@end