//
//  UIImage+Utils.m
//  Ume
//
//  Created by Start on 15/6/15.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage(Utils)

- (UIImage *)scaleImagetoScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*scaleSize,self.size.height*scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
