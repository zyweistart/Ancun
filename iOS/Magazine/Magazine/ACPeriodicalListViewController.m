#import "ACPeriodicalListViewController.h"
#import "ACPeriodicalRootContentViewController.h"
#import "BookService.h"

@interface ACPeriodicalListViewController () <UIActionSheetDelegate>

@property (strong,nonatomic)NSDictionary *data;

@end

@implementation ACPeriodicalListViewController {
    Book *book;
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.data=data;
        self.title=[NSString stringWithFormat:@"期刊号%@",[self.data objectForKey:@"periods"]];
    }
    return self;
}

- (void)loadData:(NSArray *)dataItem
{
    [self.dataItemArray addObjectsFromArray:dataItem];
    [self.tableView reloadData];
    
    BookService *bookService=[[BookService alloc]init];
    NSString *periods=[self.data objectForKey:@"periods"];
    book=[bookService get:periods];
    if(book!=nil){
        if([[book readpotin]intValue]>0){
            [Common actionSheet:self message:@"是否上次继续阅读" ok:@"继续阅读" tag:1];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *d=[self.dataItemArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[d objectForKey:@"bigTitle"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACPeriodicalRootContentViewController *periodicalContentViewController=[[ACPeriodicalRootContentViewController alloc]initWithData:self.dataItemArray Index:indexPath.row book:book];
    [periodicalContentViewController setTitle:[self.data objectForKey:@"periods"]];
    [self.navigationController pushViewController:periodicalContentViewController animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:[[book index]intValue] inSection:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:path];
}

@end