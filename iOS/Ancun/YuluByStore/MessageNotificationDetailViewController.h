//
//  MessageNotificationDetailViewController.h
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import "BaseViewController.h"
#import "Message.h"

@interface MessageNotificationDetailViewController : BaseViewController

@property (strong,nonatomic)Message *message;

- (id)initWithMessage:(Message*)message;

@end