//
//  InsuranceCompanyViewController.h
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"

@interface InsuranceCompanyViewController : BaseEGOTableViewPullRefreshViewController

@property (strong,nonatomic) NSMutableArray *dataKeys;
@property (strong,nonatomic) NSMutableDictionary *dataResults;

//地图信息
@property (strong,nonatomic) NSDictionary *mapData;

- (id)initWithType:(int)type;

@end