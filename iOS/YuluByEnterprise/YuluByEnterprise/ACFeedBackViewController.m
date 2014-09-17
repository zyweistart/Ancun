#import "ACFeedBackViewController.h"

@interface ACFeedBackViewController ()

@end

@implementation ACFeedBackViewController{
    HttpRequest *_feedBackHttp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACFeedBackViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACFeedBackViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"意见反馈";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _lblContentPlaceholder.hidden=NO;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        [Common notificationMessage:@"反馈成功" inView:self.view];
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (IBAction)submitFeedBack:(id)sender {
    NSString *content=_fbContent.text;
    if([content isEqualToString:@""]){
        [Common alert:@"请输入反馈内容"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:content forKey:@"feedcontent"];
        [requestParams setObject:_fbContact.text forKey:@"email"];
        _feedBackHttp=[[HttpRequest alloc]init];
        [_feedBackHttp setDelegate:self];
        [_feedBackHttp setController:self];
        [_feedBackHttp setIsShowMessage:YES];
        [_feedBackHttp loginhandle:@"v4Feedback" requestParams:requestParams];
    }
}

- (IBAction)backgroundDoneEditing:(id)sender {
    [_fbContent resignFirstResponder];
}

- (IBAction)viewMoveUp:(id)sender {
    
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y-=80;
        self.view.frame=curFrame;
    }];
}

- (IBAction)viewMoveDown:(id)sender {
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y=0;
        self.view.frame=curFrame;
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _lblContentPlaceholder.hidden=YES;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if([[_fbContent text]isEqualToString:@""]){
        _lblContentPlaceholder.hidden=NO;
    }else{
        _lblContentPlaceholder.hidden=YES;
    }
    return YES;
}

@end
