//
//  AccidentCerView.h
//  Car
//
//  Created by Start on 11/16/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"
#import "HttpRequest.h"

@protocol AccidentCerViewDelegate

@optional
- (void)accidentCerViewOK:(id)sender;
- (void)accidentCerViewCancel:(id)sender;

@end

@interface AccidentCerView : UIView<HttpViewDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@property (strong,nonatomic)CameraView *cameraViewPai;
@property (strong,nonatomic)XLLabel *lblCompany;
@property (strong,nonatomic)XLButton *bOk;
@property (strong,nonatomic)XLButton *bCancel;

@property (strong,nonatomic)XLTextField *tfCarNumber;
@property (strong,nonatomic)XLTextField *tfPhone;
@property (strong,nonatomic)XLTextField *tfCode;

@property (strong,nonatomic) NSObject<AccidentCerViewDelegate> *delegate;

@end
