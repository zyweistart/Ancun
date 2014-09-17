#import <UIKit/UIKit.h>

@interface ACFeedBackViewController : BaseViewController<UITextViewDelegate,HttpViewDelegate>

@property (retain, nonatomic) IBOutlet UITextView *fbContent;
@property (retain, nonatomic) IBOutlet UITextField *fbContact;
@property (retain, nonatomic) IBOutlet UILabel *lblContentPlaceholder;

- (IBAction)submitFeedBack:(id)sender;
- (IBAction)backgroundDoneEditing:(id)sender;
- (IBAction)viewMoveUp:(id)sender;
- (IBAction)viewMoveDown:(id)sender;



@end
