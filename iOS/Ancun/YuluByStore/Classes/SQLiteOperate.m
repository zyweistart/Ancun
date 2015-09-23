//
//  SQLiteOperate.m
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "SQLiteOperate.h"
#define DBNAME    @"ancun_yulu.db"

@implementation SQLiteOperate {
    sqlite3 *db;
}

- (id)init
{
    self=[super init];
    if(self){
        
    }
    return self;
}

- (BOOL)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }
    return YES;
}

- (BOOL)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }
    return YES;
}

- (NSMutableArray*)queryWithColumns:(NSArray*)columns WithSQL:(NSString*)sql
{
    NSMutableArray *data=[[NSMutableArray alloc]init];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
            //循环读取列表字段
            for(int i=0;i<[columns count];i++){
                NSString *key=[columns objectAtIndex:i];
                char *val = (char*)sqlite3_column_text(statement, i);
                NSString *valStr = [[NSString alloc]initWithUTF8String:val];
                [d setObject:valStr forKey:key];
            }
            [data addObject:d];
        }
    }
    sqlite3_close(db);
    return data;
}

- (NSInteger)queryWithCountWithSQL:(NSString*)sql
{
    NSString *valStr=@"0";
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *val = (char*)sqlite3_column_text(statement, 0);
            valStr = [[NSString alloc]initWithUTF8String:val];
        }
    }
    sqlite3_close(db);
    return [valStr intValue];
}

///////////////////////消息通知

- (BOOL)createTableMessageNotification
{
    NSString *ctNEWSql = @"CREATE TABLE IF NOT EXISTS MESSAGENOTIFICATION (ID INTEGER PRIMARY KEY AUTOINCREMENT,TITLE TEXT, CONTEXT TEXT, OPERATOR TEXT, URL TEXT, TYPE TEXT, DATE TEXT, READ TEXT)";
    return [self execSql:ctNEWSql];
}

- (NSMutableArray*)getAllMessageNotification
{
    NSString *SQL=@"SELECT * FROM MESSAGENOTIFICATION ORDER BY DATE DESC";
    NSMutableArray *lists=[self queryWithColumns:@[@"ID",@"TITLE",@"CONTEXT",@"OPERATOR",@"URL",@"TYPE",@"DATE",@"READ"] WithSQL:SQL];
    NSMutableArray *arrays=[[NSMutableArray alloc]init];
    for(NSDictionary *d in lists){
        Message *msg=[[Message alloc]init];
        [msg setKey:[d objectForKey:@"ID"]];
        [msg setTitle:[d objectForKey:@"TITLE"]];
        [msg setContent:[d objectForKey:@"CONTEXT"]];
        [msg setOper:[d objectForKey:@"OPERATOR"]];
        [msg setUrl:[d objectForKey:@"URL"]];
        [msg setType:[d objectForKey:@"TYPE"]];
        [msg setDate:[d objectForKey:@"DATE"]];
        [msg setRead:[d objectForKey:@"READ"]];
        [arrays addObject:msg];
    }
    return arrays;
}

- (BOOL)insertMessageNotification:(Message*)message
{
    NSString *SQL=[NSString stringWithFormat:@"INSERT INTO MESSAGENOTIFICATION (TITLE,CONTEXT,OPERATOR,URL,TYPE,DATE,READ) VALUES ('%@','%@','%@','%@','%@','%@','0')",message.title,message.content,message.oper,message.url,message.type,message.date];
    return [self execSql:SQL];
}

- (BOOL)updateMessageNotification:(Message*)message
{
    NSString *SQL=[NSString stringWithFormat:@"UPDATE MESSAGENOTIFICATION SET READ = '1' WHERE ID = %@",message.key];
    return [self execSql:SQL];
}

- (BOOL)deleteMessageNotification:(Message*)message
{
    NSString *SQL=[NSString stringWithFormat:@"DELETE FROM MESSAGENOTIFICATION WHERE ID = %@",message.key];
    return [self execSql:SQL];
}

- (NSInteger)getNoReadMessageNotificationCount
{
    NSString *SQL=@"SELECT COUNT(*) FROM MESSAGENOTIFICATION WHERE READ='0'";
    return [self queryWithCountWithSQL:SQL];
}

@end