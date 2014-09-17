#import <UIKit/UIKit.h>

@interface ACDialViewController : BaseViewController<ABNewPersonViewControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *lbl_dial;
@property (retain, nonatomic) IBOutlet UILabel *lbl_name;

- (IBAction) btnTouchUpInside:(id)sender;

@end
