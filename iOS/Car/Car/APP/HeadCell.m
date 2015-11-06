//
//  HeadCell.m
//  Car
//
//  Created by Start on 11/6/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "HeadCell.h"

@implementation HeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ivHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(250, 2, 41, 41)];
        self.ivHeader.layer.cornerRadius=self.ivHeader.bounds.size.width/2;
        self.ivHeader.layer.masksToBounds=YES;
        [self.ivHeader setImage:[UIImage imageNamed:@"未上传人像"]];
        [self addSubview:self.ivHeader];
    }
    return self;
}

@end