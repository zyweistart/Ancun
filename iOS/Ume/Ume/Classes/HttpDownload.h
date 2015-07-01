//
//  HttpDownload.h
//  Ume
//
//  Created by Start on 15/7/1.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpDownload : NSObject

- (void)AsynchronousDownloadImageWithUrl:(NSString *)u ShowImageView:(UIImageView*)showImage;

@end
