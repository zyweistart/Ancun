//
//  ACFeedBacksViewController.m
//  Ancun
//
//  Created by Start on 4/8/14.
//
//

#import "ACFeedBacksViewController.h"
#import "LoginTextField.h"

@interface ACFeedBacksViewController () <UITextViewDelegate,UITextFieldDelegate>

@end

@implementation ACFeedBacksViewController {
    UITextView *tvContent;
    UITextField *txtEmail;
    UILabel *lblContentPlaceholder;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title=@"意见反馈";
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UIControl *container=[[UIControl alloc]initWithFrame:CGRectMake1(0, 0, WIDTH, HEIGHT-STATUSHEIGHT-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
        [container addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:container];
        
        UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake1(14.5, 10, 291, 194)];
        [view setUserInteractionEnabled:YES];
        [view setImage:[UIImage imageNamed:@"bg1"]];
        [container addSubview:view];
        
        tvContent=[[UITextView alloc] initWithFrame:CGRectMake1(17, 21.25, 257, 87)];
        tvContent.userInteractionEnabled=YES;
        tvContent.layer.cornerRadius = 5;
        tvContent.layer.masksToBounds = YES;
        [tvContent setDelegate:self];
        [view addSubview:tvContent];
        
        lblContentPlaceholder=[[UILabel alloc]initWithFrame:CGRectMake1(5, 5, 247, 20)];
        [lblContentPlaceholder setText:@"请输入反馈信息，我们将为您不断改进"];
        [lblContentPlaceholder setFont:[UIFont systemFontOfSize:13]];
        [lblContentPlaceholder setTextColor:[UIColor grayColor]];
        [lblContentPlaceholder setBackgroundColor:[UIColor clearColor]];
        [tvContent addSubview:lblContentPlaceholder];
        
        txtEmail=[[LoginTextField alloc] initWithFrame:CGRectMake1(17, 128, 257, 45) Placeholder:@"电子邮箱(可选)"];
        txtEmail.layer.cornerRadius = 5;
        [txtEmail setDelegate:self];
        [txtEmail setFont:[UIFont systemFontOfSize: 15]];
        [txtEmail setKeyboardType:UIKeyboardTypePhonePad];
        [view addSubview:txtEmail];
        
        UIButton *btnSubmit=[[UIButton alloc]initWithFrame:CGRectMake1(14.5, 224, 291, 40)];
        [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        btnSubmit.titleLabel.font=[UIFont systemFontOfSize:22];
        btnSubmit.layer.cornerRadius=5;
        btnSubmit.layer.masksToBounds=YES;
        [btnSubmit setBackgroundColor:[UIColor colorWithRed:(69/255.0) green:(168/255.0) blue:(249/255.0) alpha:1]];
        [btnSubmit addTarget:self action:@selector(submitFeedBack:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btnSubmit];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        [Common alert:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)submitFeedBack:(id)sender {
    NSString *content=tvContent.text;
    NSString *email=txtEmail.text;
    if([content isEqualToString:@""]){
        [Common alert:@"请输入反馈内容"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:content forKey:@"feedcontent"];
        [requestParams setObject:email forKey:@"email"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest loginhandle:@"v4Feedback" requestParams:requestParams];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y-=80;
        self.view.frame=curFrame;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y=64;
        self.view.frame=curFrame;
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    lblContentPlaceholder.hidden=YES;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if([[tvContent text]isEqualToString:@""]){
        lblContentPlaceholder.hidden=NO;
    }else{
        lblContentPlaceholder.hidden=YES;
    }
    return YES;
}

- (void)backgroundDoneEditing:(id)sender{
    [tvContent resignFirstResponder];
    [txtEmail resignFirstResponder];
}

@end