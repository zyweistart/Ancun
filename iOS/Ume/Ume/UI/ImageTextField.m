//
//  ImageTextField.m
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "ImageTextField.h"
#define  NAVIGATION_BAR_HEIGHT 40

@implementation ImageTextField

- (id)initWithFrame:(CGRect)rect Image:(NSString*)imageNamed Placeholder:(NSString*)ph
{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 5, 30, 30)];
        [self.image setImage:[UIImage imageNamed:imageNamed]];
        [self addSubview:self.image];
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(CGWidth(50), 0, rect.size.width-CGWidth(50), rect.size.height)];
        [self.textField setPlaceholder:ph];
        [self.textField setDelegate:self];
        [self.textField setTextColor:DEFAULTITLECOLOR(190)];
        [self.textField setFont:[UIFont systemFontOfSize:18]];
        [self.textField setTextAlignment:NSTextAlignmentLeft];
        [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:self.textField];
        [self setPadding:YES top:0 right:5 bottom:0 left:5];
    }
    return self;
}

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left {
    isEnablePadding = enable;
    paddingTop = top;
    paddingRight = right;
    paddingBottom = bottom;
    paddingLeft = left;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (isEnablePadding) {
        return CGRectMake(bounds.origin.x + paddingLeft,
                          bounds.origin.y + paddingTop,
                          bounds.size.width - paddingRight, bounds.size.height - paddingBottom);
    } else {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollFrame.contentSize = CGSizeMake1(self.width,self.height+216);
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.scrollFrame];
    if(self.scrollFrame.contentOffset.y-pt.y+NAVIGATION_BAR_HEIGHT<=0){
        [self.scrollFrame setContentOffset:CGPointMake(0, pt.y-NAVIGATION_BAR_HEIGHT) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    //开始动画
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    self.scrollFrame.contentSize = CGSizeMake1(self.width,self.height);
    //动画结束
    [UIView commitAnimations];
    return YES;
}

@end