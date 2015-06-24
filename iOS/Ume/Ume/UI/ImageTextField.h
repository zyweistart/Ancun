//
//  ImageTextField.h
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextField : UIView<UITextFieldDelegate>{
    BOOL isEnablePadding;
    float paddingLeft;
    float paddingRight;
    float paddingTop;
    float paddingBottom;
}

@property CGFloat width;
@property CGFloat height;
@property (strong,nonatomic)UIScrollView *scrollFrame;
@property (strong,nonatomic)UIImageView *image;
@property (strong,nonatomic)UITextField *textField;

- (id)initWithFrame:(CGRect)rect Image:(NSString*)imageNamed Placeholder:(NSString*)ph;

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left;

@end
