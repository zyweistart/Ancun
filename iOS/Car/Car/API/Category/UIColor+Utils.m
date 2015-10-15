//
//  UIColor.m
//  XinHu
//
//  Created by Start on 15/8/11.
//  Copyright (c) 2015年 AnCun. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor(Utils)

- (UIImage*)TransformationWithImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
