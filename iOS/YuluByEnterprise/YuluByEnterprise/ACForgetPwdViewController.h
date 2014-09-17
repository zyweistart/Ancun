#import <UIKit/UIKit.h>

@interface ACForgetPwdViewController : BaseViewController<HttpViewDelegate> {
    int _second;
    NSTimer *_verificationCodeTime;
    NSString *_phone;
    NSString *_verificationCode;
}

@property (retain, nonatomic) IBOutlet UIView *regFirstView;
@property (retain, nonatomic) IBOutlet UIView *regSecondView;
@property (retain, nonatomic) IBOutlet UIControl *regThirdView;
@property (retain, nonatomic) IBOutlet UIControl *regFourthView;

@property (retain, nonatomic) IBOutlet UITextField *regInputPhone;
@property (retain, nonatomic) IBOutlet UITextField *regInputVerificationCode;
@property (retain, nonatomic) IBOutlet UITextField *regInputPassword;
@property (retain, nonatomic) IBOutlet UITextField *regInputRePassword;

@property (retain, nonatomic) IBOutlet UIButton *regBtnReVerificationCode;

@property (retain, nonatomic) IBOutlet UIView *regViewVerificationCodeTip;

@property (retain, nonatomic) IBOutlet UILabel *regLblVerificationCodeSecond;

- (IBAction) validPhoneByVerificationCode;

- (IBAction) getVerificationCode:(id)sender;

- (IBAction) submitVerificationCode:(id)sender;

- (IBAction) setPassword:(id)sender;

- (IBAction) forgetPwdDone:(id)sender;

- (IBAction)backgroundDoneEditing:(id)sender;

@end
