//
//  CTextField.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "CTextField.h"

@implementation CTextField

- (id)initWithFrame:(CGRect)rect Placeholder:(NSString*)ph
{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [self setPlaceholder:ph];
        [self setTextColor:DEFAULTITLECOLOR(190)];
        [self setFont:[UIFont systemFontOfSize:14]];
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
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

@end