//
//  ACShelfLoadingCell.h
//  Magazine
//
//  Created by Start on 5/27/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLIDENTIFIERLOADINGCELL @"CollectionViewLoadingCell"

@interface CollectionViewLoadingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *load;

@end
