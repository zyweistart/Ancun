//
//  ACRegistrationViewController.h
//  Ancun
//
//  Created by Start on 4/2/14.
//
//

#import <UIKit/UIKit.h>
#import "LoginTextField.h"
#import "ACButton.h"

#define SECOND 60

@interface ACRegistrationViewController : BaseViewController <UITextFieldDelegate,HttpViewDelegate>{
    
    NSTimer *_verificationCodeTime;
    
    NSString *_phone;
    NSString *_password;
    NSString *_verificationCode;
    
    int _second;
    UILabel *_lblVerificationCodeInfo;
    ACButton *_btnGetVerificationCode;
    UILabel *_lblTitlte;
    UIImageView *step2;
    UIImageView *step3;
    UIControl *_regFirstView;
    UIControl *_regSecondView;
    UIControl *_regThirdView;
    UIControl *_regFourthView;
    LoginTextField *_regInputPhone;
    LoginTextField *_regInputVerificationCode;
    LoginTextField *_regInputPassword;
    LoginTextField *_regInputRePassword;
    UIButton *_btnReadAgreementCheck;
    UIButton *_btnReadAgreement;
    UILabel *_lblSuccessInfo;
    int _type;
}

- (void)backgroundDoneEditing:(id)sender;
- (void)setPassword:(id)sender;

@property (strong,nonatomic) HttpRequest *hRequest;

@end