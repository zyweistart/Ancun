//
//  BeinDangerHistoryCell.h
//  Car
//
//  Created by Start on 11/3/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeinDangerHistoryCell : UITableViewCell

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)XLLabel *lblTime;
@property (strong,nonatomic)XLLabel *lblStatus;
@property (strong,nonatomic)XLLabel *lblAddress;

- (void)addSubImage:(NSString*)imageNamed;

@end
