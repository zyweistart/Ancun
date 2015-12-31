//
//  PhotoTableCell.h
//  Witness
//
//  Created by Start on 12/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Photo.h"

@interface PhotoTableCell : BaseTableViewCell

@property (strong,nonatomic)UIImageView *photo;
@property (strong,nonatomic)UIImageView *ivLocal;
@property (strong,nonatomic)UILabel *lblName;
@property (strong,nonatomic)UILabel *lblAddress;
@property (strong,nonatomic)UILabel *lblTime;

@end
