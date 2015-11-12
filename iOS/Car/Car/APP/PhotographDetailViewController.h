//
//  PhotographDetailViewController.h
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotographDetailViewController : BaseViewController<UIAlertViewDelegate>

- (id)initWithData:(NSDictionary*)data;
@property (strong,nonatomic)NSDictionary *cData;

@end
