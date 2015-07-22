//
//  MessageSXCell.h
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSXCell : UITableViewCell

@property (strong,nonatomic)ImageViewHeader *meHeader;
@property (strong,nonatomic)CLabel *lblName;
@property (strong,nonatomic)CLabel *lblContent;
@property (strong,nonatomic)CLabel *lblTime;

@end
