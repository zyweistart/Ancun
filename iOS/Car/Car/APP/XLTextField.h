//
//  XLTextField.h
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLTextField : UITextField<UITextFieldDelegate>

- (void)setStyle:(int)style;
@property (strong,nonatomic)UITextField *goNextTextField;

@end
