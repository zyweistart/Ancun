//
//  ReplyMDCell.h
//  Ume
//
//  Created by Start on 15/7/2.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLabel.h"
#import "PlayerVoiceButton.h"

@interface ReplyMDCell : UITableViewCell

@property (strong,nonatomic)UIImageView *meHeader;
@property (strong,nonatomic)CLabel *lblName;
@property (strong,nonatomic)CLabel *lblTime;
@property (strong,nonatomic)CLabel *lblValue;
@property (strong,nonatomic)UIButton *lblPCount;
@property (strong,nonatomic)UIButton *lblZCount;

@property (strong,nonatomic)PlayerVoiceButton *player;
@end
