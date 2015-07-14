#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "HttpRequest.h"
#import "LoginViewController.h"

@interface TabBarFrameViewController : UITabBarController<UITabBarControllerDelegate,EAIntroDelegate,HttpViewDelegate,LoginDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

- (void)logout;

@end

