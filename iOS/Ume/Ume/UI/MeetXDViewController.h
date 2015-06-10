//
//  MeetXDViewController.h
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import "JHGridTableView.h"

@interface MeetXDViewController : BaseViewController<JHGridTableViewDatasource,JHGridTableViewDelegate>
{
    JHGridTableView *gridTableView;
}

@end
