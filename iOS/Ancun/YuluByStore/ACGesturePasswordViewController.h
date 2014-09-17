//
//  ACGesturePasswordViewController.h
//  Ancun
//
//  Created by Start on 4/10/14.
//
//

#import "BaseViewController.h"
#import "KKGestureLockView.h"

@interface ACGesturePasswordViewController : BaseViewController<KKGestureLockViewDelegate>

@property (strong,nonatomic) KKGestureLockView *lockView;
@property (strong,nonatomic) UILabel *lblInfo;

- (id)initWithFlag:(BOOL)flag;

@property BOOL flag;

@end
