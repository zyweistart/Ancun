//
//  XLZoomImage.m
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "XLZoomImage.h"

@implementation XLZoomImage{
    NSString *imageUrl;
}

- (id)initWithBounds:(UIView*)view withImageURL:(NSString*)url
{
    imageUrl=url;
    self=[super initWithFrame:view.bounds];
    if(self){
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goHideView)]];
        [self setBackgroundColor:[UIColor blackColor]];
        [view addSubview:self];
        [self setHidden:YES];
    }
    return self;
}

- (void)showView
{
    [self setHidden:NO];
    if(![imageUrl isEmpty]){
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setView:self];
        [self.hRequest setDelegate:self];
        [self.hRequest setIsFileDownload:YES];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:nil WithURL:imageUrl];
    }
}

- (void)goHideView
{
    [self setHidden:YES];
    [self removeFromSuperview];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response responseString]);
}

- (void)requestFailed:(int)reqCode
{
    NSLog(@"请求失败编号:%d",reqCode);
}

@end
