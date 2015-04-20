//
//  RecordsSQL.h
//  Ancun
//
//  Created by Start on 4/17/15.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define DBNAME @"ancun.sqlite"
#define TABLENAME @"RECORDS"
#define ACCOUNT @"ACCOUNT"
#define FILENAME @"FILENAME"
#define RECORDTIME @"RECORDTIME"
#define LONGTIME @"LONGTIME"
#define REMARK @"REMARK"

@interface RecordsSQL : NSObject

- (void)openDB;

-(void)execSql:(NSString *)sql;

//- (void)createTableSQL;

- (void)closeDB;

- (NSMutableArray*)getAllRecordWithAccount:(NSString*)account;

@end
