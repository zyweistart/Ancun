#import <UIKit/UIKit.h>

@interface ACModifyPwdViewController : BaseViewController<HttpViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *inputOldPassword;

@property (retain, nonatomic) IBOutlet UITextField *inputNewPassword;

@property (retain, nonatomic) IBOutlet UITextField *inputReNewPassword;

- (IBAction)submitPwdModify:(id)sender;

- (IBAction)backgroundDoneEditing:(id)sender;

@end
