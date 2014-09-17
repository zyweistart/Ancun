#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (strong,nonatomic) UIImageView *numberImage;

- (id)initWithPageNumber:(NSUInteger)page;

@end
