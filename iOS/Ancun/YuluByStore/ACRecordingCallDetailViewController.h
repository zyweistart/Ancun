//
//  ACRecordingCallDetailViewController.h
//  Ancun
//
//  Created by Start on 4/3/14.
//
//

#import <UIKit/UIKit.h>

@interface ACRecordingCallDetailViewController : BaseViewController

- (id)initWithData:(NSDictionary *)data;

@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;

@property (strong,nonatomic) HttpRequest *hRequest;

@end
