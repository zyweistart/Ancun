//
//  BeinDangerHistoryViewController.h
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEGOTableViewPullRefreshViewController.h"

@interface BeinDangerHistoryViewController : BaseEGOTableViewPullRefreshViewController

@property (strong,nonatomic) NSMutableArray *dataKeys;
@property (strong,nonatomic) NSMutableDictionary *dataResults;

@end