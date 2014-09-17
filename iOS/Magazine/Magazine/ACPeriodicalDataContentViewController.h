#import "BaseViewController.h"
#import "Book.h"

@interface ACPeriodicalDataContentViewController : BaseViewController

- (id)initWithData:(NSDictionary *)data;

- (void)loadData;

@property NSUInteger index;

@property (strong,nonatomic) Book *book;

@end
