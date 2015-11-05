#import "BaseTableViewController.h"

@interface ModifySingleDataViewController : BaseTableViewController

@property (nonatomic)NSInteger type;
@property (strong,nonatomic)NSString *textValue;
@property (strong,nonatomic)XLTextField *tfData;

- (id)initWithType:(NSInteger)type WithValue:(NSString*)value;

@end
