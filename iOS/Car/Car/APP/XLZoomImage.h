//
//  XLZoomImage.h
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"

@interface XLZoomImage : UIView<HttpViewDelegate>

- (id)initWithBounds:(UIView*)view withImageURL:(NSString*)url;

@property (strong,nonatomic)HttpRequest *hRequest;

- (void)showView;

@end
