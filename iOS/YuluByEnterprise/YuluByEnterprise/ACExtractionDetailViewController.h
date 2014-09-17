#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ACExtractionDetailViewController : BaseViewController<MFMessageComposeViewControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property BOOL load;
@property (retain,nonatomic) NSString *fileno;
@property (retain,nonatomic) NSMutableDictionary *extractionDics;
@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;

@property (retain, nonatomic) IBOutlet UILabel *lbl_accendcode;
@property (retain, nonatomic) IBOutlet UILabel *lbl_accendtime;

- (IBAction)cancelextraction:(id)sender;
- (IBAction)pasteBoard:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
