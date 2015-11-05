//
//  ACPaymentAlipayViewController.h
//  Ancun
//
//  Created by Start on 11/4/15.
//
//

#import "BaseViewController.h"

@interface ACPaymentAlipayViewController : BaseViewController <HttpViewDelegate>

- (id)initWithData:(NSDictionary *)data;

@property (strong,nonatomic)HttpRequest *hRequest;

- (void)paynmentedStep;

- (void)paynmentingStep;

- (void)successStep;

@end

