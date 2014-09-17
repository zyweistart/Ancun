#import <UIKit/UIKit.h>
#import "HttpRequest.h"

@interface BaseViewController : UIViewController<HttpViewDelegate>

- (void)buildUI56;

- (void)buildUI7;

- (void)close:(id)sender;

@property (nonatomic,strong) HttpRequest *hRequest;

@end