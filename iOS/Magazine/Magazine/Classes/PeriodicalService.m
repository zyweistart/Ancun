#import "PeriodicalService.h"
#import "ACAppDelegate.h"

@implementation PeriodicalService

- (NSArray *)getListWithBookId:(NSString *)bookId
{
    ACAppDelegate *delegate=(ACAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *objectContext=delegate.managedObjectContext;
    
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Periodical" inManagedObjectContext:objectContext];
    [request setEntity:entity];
    NSPredicate *query=[NSPredicate predicateWithFormat:@"bookId == %@",bookId];
    [request setPredicate:query];
    
    NSError *error=nil;
    return [objectContext executeFetchRequest:request error:&error];
}

- (BOOL)save:(NSDictionary*)data bookId:(NSString *)bookId
{
    ACAppDelegate *delegate=(ACAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *objectContext=delegate.managedObjectContext;
    Periodical *periodical=(Periodical*)[NSEntityDescription insertNewObjectForEntityForName:@"Periodical" inManagedObjectContext:objectContext];
    [periodical setBigTitle:[data objectForKey:@"bigTitle"]];
    [periodical setContenturl:[data objectForKey:@"contenturl"]];
    [periodical setDownloadUrl:[data objectForKey:@"downloadUrl"]];
    [periodical setSmallTitle:[data objectForKey:@"smallTitle"]];
    [periodical setPeriods:[data objectForKey:@"periods"]];
    [periodical setBookId:bookId];
    return [objectContext save:nil];
}

- (NSMutableDictionary*)periodicalConvertDictionary:(Periodical*)periodical
{
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setValue:[periodical bigTitle] forKey:@"bigTitle"];
    [data setValue:[periodical contenturl] forKey:@"contenturl"];
    [data setValue:[periodical downloadUrl] forKey:@"downloadUrl"];
    [data setValue:[periodical smallTitle] forKey:@"smallTitle"];
    [data setValue:[periodical periods] forKey:@"periods"];
    [data setValue:[periodical bookId] forKey:@"bookId"];
    return data;
}

@end
