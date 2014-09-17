//
//  ACExtractionCodeDetailViewController.h
//  Ancun
//
//  Created by Start on 4/8/14.
//
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>

@interface ACExtractionCodeDetailViewController : BaseViewController<MFMessageComposeViewControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@property (retain,nonatomic) NSString *fileno;
@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;

- (id)initWithLoad:(BOOL)load fileNo:(NSString *)fileNo extractionDics:(NSMutableDictionary*)dics;

@end
