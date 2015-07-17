//
//  MeetXDViewController.h
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface MeetXDViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSMutableArray *dataItemArray;

@end
