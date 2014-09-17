//
//  ACDialsViewController.h
//  Ancun
//
//  Created by Start on 3/31/14.
//
//

#import <UIKit/UIKit.h>

@interface ACDialsViewController : BaseViewController<ABNewPersonViewControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@end

