//
//  RecordsSQL.m
//  Ancun
//
//  Created by Start on 4/17/15.
//
//

#import "RecordsSQL.h"

@implementation RecordsSQL{
    sqlite3 *db;
}

- (void)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    [self createTableSQL];
}

- (void)createTableSQL
{
    NSString *createTableSQL=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT)",TABLENAME,ACCOUNT,FILENAME,RECORDTIME,LONGTIME,REMARK];
    [self execSql:createTableSQL];
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}

- (void)closeDB
{
    sqlite3_close(db);
}

- (NSMutableArray*)getAllRecordWithAccount:(NSString*)account
{
    NSMutableArray *dataItems=[[NSMutableArray alloc]init];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT FILENAME,RECORDTIME,LONGTIME,REMARK FROM %@ WHERE ACCOUNT='%@' ORDER BY RECORDTIME DESC",TABLENAME,account];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *fileName = (char*)sqlite3_column_text(statement, 0);
            NSString *nsFileNameStr = [[NSString alloc]initWithUTF8String:fileName];
            
            char *recordTime = (char*)sqlite3_column_text(statement, 1);
            NSString *nsRecordTimeStr = [[NSString alloc]initWithUTF8String:recordTime];
            
            char *longTime = (char*)sqlite3_column_text(statement, 2);
            NSString *nsLongTimeStr = [[NSString alloc]initWithUTF8String:longTime];
            
            char *remark = (char*)sqlite3_column_text(statement, 3);
            NSString *nsRemarkStr = [[NSString alloc]initWithUTF8String:remark];
            
            NSDictionary *data=[NSDictionary dictionaryWithObjectsAndKeys:
                                nsFileNameStr,FILENAME,
                                nsRecordTimeStr,RECORDTIME,
                                nsLongTimeStr,LONGTIME,
                                nsRemarkStr,REMARK, nil];
            [dataItems addObject:data];
        }
    }
    return dataItems;
}

@end