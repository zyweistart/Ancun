#import <Foundation/Foundation.h>
#import "Periodical.h"

@interface PeriodicalService : NSObject

- (NSArray *)getListWithBookId:(NSString *)bookId;
- (BOOL)save:(NSDictionary*)data bookId:(NSString *)bookId;
- (NSMutableDictionary*)periodicalConvertDictionary:(Periodical*)periodical;

@end
