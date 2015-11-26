//
//  BeinDangerDetailViewController.h
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@protocol BeinDangerDetailDelegate

@optional
- (void)handleBeinDangerDetailCallBack;

@end

@interface BeinDangerDetailViewController : BaseTableViewController

- (void)loadHttpData;
- (id)initWithData:(NSDictionary *)data isHistory:(BOOL)isHistory;

@end
