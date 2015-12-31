//
//  GlobalDefine.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

//机型宏
#define inch35 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define inch4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define inch47 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define inch55 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//宽高宏
//#define WIDTH 320.0
//#define HEIGHT (inch35?480.0:568.0)
//#define BOTTOMTABBARHEIGHT 49.0
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
//
CG_INLINE CGFloat
CGWidth(CGFloat width)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return width * myDelegate.autoSizeScaleX;
}
CG_INLINE CGFloat
CGHeight(CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return height * myDelegate.autoSizeScaleY;
}
CG_INLINE CGSize
CGSizeMake1(CGFloat width, CGFloat height)
{
    CGSize csize;
    csize.width = CGWidth(width);
    csize.height = CGHeight(height);
    return csize;
}
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = CGWidth(width);
    rect.size.height = CGHeight(height);
    return rect;
}
CG_INLINE CGFloat
CGRectMakeXX(CGFloat fValue)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CGFloat fValueX;
    fValueX = fValue/myDelegate.autoSizeScaleX;
    return fValueX;
}
CG_INLINE CGFloat
CGRectMakeYY(CGFloat fValue)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CGFloat fValueY;
    fValueY = fValue/myDelegate.autoSizeScaleY;
    return fValueY;
}
CG_INLINE CGFloat
Font1(CGFloat fontSize)
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return fontSize*myDelegate.autoSizeScaleX;
}
CG_INLINE CGFloat
scaleX()
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return myDelegate.autoSizeScaleX;
}

CG_INLINE CGFloat
scaleY()
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return myDelegate.autoSizeScaleY;
}
//弱引用
#define ACWeakSelf __weak typeof(&*self) weakSelf = self;
//状态栏高度
#define STATUSBARHEIGHT 20
//导航栏高度
#define NAVIGATIONHEIGHT 44
//标签栏高度
#define TABBARHEIGHT 49
//字体
#define GLOBAL_FONTSIZE(NUM) [UIFont systemFontOfSize:Font1(NUM)]
//颜色宏
#define RGBCOLOR(R,G,B) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:1]
#define RGBCOLOR_A(R,G,B,A) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:A]
#define BCOLOR(NUM) BCOLORA(NUM,1)
#define BCOLORA(NUM,ALPHA) [UIColor colorWithRed:(NUM/255.0) green:(NUM/255.0) blue:(NUM/255.0) alpha:ALPHA]

#endif /* GlobalDefine_h */