//
//  ACAccountPay2Cell.h
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import <UIKit/UIKit.h>

@interface ACAccountPay2Cell : UITableViewCell

@property (strong, nonatomic) UILabel *lblName;
@property (strong, nonatomic) UILabel *lblDescription;

@property (strong,nonatomic) NSMutableDictionary *data;
@property (strong,nonatomic) UIViewController *controler;

@end
