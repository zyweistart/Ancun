//
//  DiscoverCell.h
//  Ume
//
//  Created by Start on 5/29/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLabel.h"

@interface DiscoverCell : UITableViewCell

@property (strong,nonatomic)UIImageView *image;
@property (strong,nonatomic)CLabel *cTitle;
@property (strong,nonatomic)CLabel *cDescription;

@end
