//
//  ReplyMDCell.h
//  Ume
//
//  Created by Start on 15/7/2.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLabel.h"

@interface ReplyMDCell : UITableViewCell

@property (strong,nonatomic)UIImageView *meHeader;
@property (strong,nonatomic)CLabel *lblName;
@property (strong,nonatomic)CLabel *lblTime;
@property (strong,nonatomic)CLabel *lblValue;
@property (strong,nonatomic)CLabel *lblPCount;
@property (strong,nonatomic)CLabel *lblZCount;

@end
