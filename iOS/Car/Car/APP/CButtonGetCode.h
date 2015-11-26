//
//  CButtonGetCode.h
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define GLOBAL_SECOND 60
#define GLOBAL_GETCODE_STRING @"%ds后重发"

#import "XLButton.h"

@interface CButtonGetCode : XLButton<HttpViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;
- (id)initWithFrame:(CGRect)frame View:(UIView*)view;
- (void)goGetCode:(NSString*)phone Type:(NSString*)type;

@end
