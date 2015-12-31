//
//  BaseTableViewCell.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseEntity.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self layoutCell];
    }
    return self;
}

- (void)layoutCell
{
    //Layout Code
}

- (void)setCellData:(BaseEntity*)entity
{
    //Set Data
    [self.textLabel setText:@"请重新该方法完成数据设置"];
}

- (CGFloat)layoutHeight
{
    return 44;
}

@end
