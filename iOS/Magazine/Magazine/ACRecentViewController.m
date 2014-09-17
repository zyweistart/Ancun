#import "ACRecentViewController.h"
#import "ACPeriodicalDetailViewController.h"
#import "ACShelf2Cell.h"
#import "BookService.h"

@implementation ACRecentViewController{
    BookService *bookService;
}

- (id)init
{
    self=[super init];
    if(self){
        [self.collectionView registerClass:[ACShelf2Cell class] forCellWithReuseIdentifier:CELLIDENTIFIER];
        bookService=[[BookService alloc]init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:[bookService getList]];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 177);
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ACShelf2Cell *shelfCell = (ACShelf2Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    
    NSMutableDictionary *data=[bookService bookConvertDictionary:[self.dataItemArray objectAtIndex:indexPath.row]];
    [shelfCell.title setText:[data objectForKey:@"periods"]];
    [shelfCell.price setText:[NSString stringWithFormat:@"%d",[indexPath row]+1]];
    
    NSString *frontPageUrl=[data objectForKey:@"frontPageUrl"];
    NSString *fileName=[frontPageUrl substringWithRange:NSMakeRange(33,25)];
    [Common loadImageWithImageView:shelfCell.image url:frontPageUrl fileName:fileName];
    return shelfCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *data=[bookService bookConvertDictionary:[self.dataItemArray objectAtIndex:indexPath.row]];
    ACPeriodicalDetailViewController *periodicalDetailViewController=[[ACPeriodicalDetailViewController alloc]initWithData:data];
    UINavigationController *periodicalDetailViewControllerNav=[[UINavigationController alloc]initWithRootViewController:periodicalDetailViewController];
    [self presentViewController:periodicalDetailViewControllerNav animated:YES completion:nil];
    [periodicalDetailViewController loadDataDataItemArray];
}

@end
