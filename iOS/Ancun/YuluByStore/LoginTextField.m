//
//  LoginTextField.m
//  Ancun
//
//  Created by Start on 4/29/15.
//
//

#import "LoginTextField.h"

@implementation LoginTextField

- (id)initWithFrame:(CGRect)rect Placeholder:(NSString*)placeholder
{
    self=[super initWithFrame:rect];
    if(self){
        [self setPlaceholder:placeholder];
        self.userInteractionEnabled=YES;
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setFont:[UIFont systemFontOfSize: 22]];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [self setSecureTextEntry:YES];
//        [self setDelegate:self];
        [self setReturnKeyType:UIReturnKeyDone];
    }
    return self;
}

@end
