#import <UIKit/UIKit.h>

@class ACRechargeNav;
@interface ACRechargeConfirmViewController : BaseViewController<HttpViewDelegate,UIActionSheetDelegate>{
    
    HttpRequest *_http;
    
}

@property (assign,nonatomic) int currentType;
@property (strong,nonatomic) NSMutableDictionary *data;
@property (strong,nonatomic) ACRechargeNav *rechargeNav;

- (void)layoutSuccessPage;

@end
