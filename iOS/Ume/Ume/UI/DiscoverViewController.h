//
//  DiscoverViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HMBannerView.h"

@interface DiscoverViewController : BaseTableViewController<HMBannerViewDelegate>

@property (nonatomic, strong) HMBannerView *bannerView;

@end
