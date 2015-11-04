//
//  XLTextField.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "XLTextField.h"

@implementation XLTextField

- (id)initWithFrame:(CGRect)rect
{
    self=[super initWithFrame:rect];
    if(self){
        [self setDelegate:self];
        [self setReturnKeyType:UIReturnKeyDone];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return self;
}

- (void)setStyle:(int)style
{
    if(style==1){
        UIColor *color=RGBCOLOR(78, 217, 222);
        self.layer.borderWidth=1;
        self.layer.borderColor=color.CGColor;
        [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        [self setTextColor:color];
    }else{
        UIColor *color=BCOLOR(207);
        self.layer.borderWidth=1;
        self.layer.borderColor=color.CGColor;
        [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        [self setTextColor:color];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if([textField returnKeyType]==UIReturnKeyNext){
        [self.goNextTextField becomeFirstResponder];
    }
    return YES;
}

@end