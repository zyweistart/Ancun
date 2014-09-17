#import <UIKit/UIKit.h>

@interface ACRecordingDetailViewController : BaseViewController<ResultDelegate,HttpViewDelegate,UITextViewDelegate,UIActionSheetDelegate> {
    NSMutableDictionary *_mainData;
}
@property (strong,nonatomic) NSString *fileno;

@property (strong, nonatomic) IBOutlet UILabel *lbl_callerno;
@property (strong, nonatomic) IBOutlet UILabel *lbl_calledno;
@property (strong, nonatomic) IBOutlet UILabel *lbl_begintime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_endtime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_duration;
@property (strong, nonatomic) IBOutlet UITextView *tv_remark;
@property (strong, nonatomic) IBOutlet UILabel *lblRemarkTip;

@property (strong, nonatomic) IBOutlet UIButton *btn_notary;
@property (strong, nonatomic) IBOutlet UIButton *btn_extraction;

@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;
@property (strong,nonatomic) NSMutableDictionary *extractionDic;
//出证
- (IBAction)notary:(id)sender;
//提取码
- (IBAction)extraction:(id)sender;

- (IBAction)backgroundDoneEditing:(id)sender;

@end
