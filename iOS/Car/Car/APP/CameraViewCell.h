//
//  CameraViewCell.h
//  Car
//
//  Created by Start on 11/24/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"

@interface CameraViewCell : UITableViewCell<CameraViewDelegate,HttpViewDelegate>

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArray:(NSArray*)array Controller:(UIViewController*)controller;

@property (strong,nonatomic) UIViewController *currentController;
@property (strong,nonatomic) NSDictionary *cData;
@property (strong,nonatomic) HttpRequest *hRequest;

@end
