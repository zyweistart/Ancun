//
//  MessageNotificationDetailViewController.h
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import "BaseViewController.h"
#import "Message.h"
#import "HttpDownload.h"

@interface MessageNotificationDetailViewController : BaseViewController<HttpDownloadDelegate>

@property (strong,nonatomic)HttpDownload *hDownload;

@property (strong,nonatomic)Message *message;

@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblDate;
@property (strong,nonatomic)UILabel *lblContent;
@property (strong,nonatomic)UILabel *lblLinkAddress;
@property (strong,nonatomic)UIImageView *imImage;
@property (strong,nonatomic)UIButton *goButton;

- (id)initWithMessage:(Message*)message;

@end