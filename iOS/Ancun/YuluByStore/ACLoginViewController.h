#import <UIKit/UIKit.h>

@interface ACLoginViewController : BaseViewController<UITabBarControllerDelegate,UITextFieldDelegate,HttpViewDelegate,ResultDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;
@property BOOL gotoAgainGesurePassword;

@end
