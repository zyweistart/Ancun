//
//  MessageZDWDCell.h
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageZDWDCell : UITableViewCell

@property (strong,nonatomic)CLabel *lblName;
@property (strong,nonatomic)CLabel *lblTime;
@property (strong,nonatomic)ImageViewHeader *meHeader;
@property (strong,nonatomic)UIImageView *mFelationship;
@property (strong,nonatomic)UIButton *bFelationShip;
@property (strong,nonatomic)PlayerVoiceButton *player;
@property (strong,nonatomic)ImageViewGesture *ivImage;
@property (strong,nonatomic)CLabel *lblContent;

@end
