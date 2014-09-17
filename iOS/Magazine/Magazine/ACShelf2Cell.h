//
//  ACShelf2Cell.h
//  Magazine
//
//  Created by Start on 5/26/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLIDENTIFIER @"ACShelf2Cell"

@interface ACShelf2Cell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
