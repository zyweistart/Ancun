//
//  ACPaymentViewController.h
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ACPaymentViewController : BaseViewController <HttpViewDelegate>

- (id)initWithData:(NSDictionary *)data;

@property (strong,nonatomic)HttpRequest *hRequest;

- (void)paynmentedStep;

- (void)paynmentingStep;

- (void)successStep;

@end
