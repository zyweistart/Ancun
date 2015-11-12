//
//  RecordDetailViewController.h
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordDetailViewController : BaseViewController

- (id)initWithData:(NSDictionary*)data;
@property (strong,nonatomic)NSDictionary *cData;

@end
