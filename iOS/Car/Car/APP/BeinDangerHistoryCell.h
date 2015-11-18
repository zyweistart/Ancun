//
//  BeinDangerHistoryCell.h
//  Car
//
//  Created by Start on 11/3/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownload.h"

@interface BeinDangerHistoryCell : UITableViewCell<HttpDownloadDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)XLLabel *lblTime;
@property (strong,nonatomic)XLLabel *lblStatus;
@property (strong,nonatomic)XLLabel *lblAddress;
@property (strong,nonatomic)HttpDownload *hDownload;

- (void)addSubImage:(NSString*)imageNamed;
//- (void)addSubImage:(UIImageView*)imv;

@property (strong,nonatomic)UIImageView *imageView1;
@property (strong,nonatomic)UIImageView *imageView2;
@property (strong,nonatomic)UIImageView *imageView3;
@property (strong,nonatomic)UIImageView *imageView4;
@property (strong,nonatomic)UIImageView *imageView5;
@property (strong,nonatomic)UIImageView *imageView6;
@property (strong,nonatomic)UIImageView *imageView7;
@property (strong,nonatomic)UIImageView *imageView8;
@property (strong,nonatomic)UIImageView *imageView9;

@end
