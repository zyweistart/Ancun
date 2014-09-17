//
//  ACFeedBacksViewController.m
//  Ancun
//
//  Created by Start on 4/8/14.
//
//

#import "ACFeedBacksViewController.h"

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
        
        UIControl *container=nil;
        if(IOS7){
            container=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-STATUSHEIGHT-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
        }else{
            container=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
        }
        [container addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:container];
        
        UIControl *view=[[UIControl alloc]initWithFrame:CGRectMake(14.5, 10, 291, 194)];
        [view addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
        [container addSubview:view];
        
        tvContent=[[UITextView alloc] initWithFrame:CGRectMake(17, 21.25, 257, 87)];
        [tvContent setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bigtxtbg"]]];
        [tvContent setDelegate:self];
        [view addSubview:tvContent];
        
        lblContentPlaceholder=[[UILabel alloc]initWithFrame:CGRectMake(5, IOS7?5:0, 247, 20)];
        [lblContentPlaceholder setText:@"请输入反馈信息，我们将为您不断改进"];
        [lblContentPlaceholder setFont:[UIFont systemFontOfSize:13]];
        [lblContentPlaceholder setTextColor:[UIColor grayColor]];
        [lblContentPlaceholder setBackgroundColor:[UIColor clearColor]];
        [tvContent addSubview:lblContentPlaceholder];
        
        txtEmail=[[UITextField alloc] initWithFrame:CGRectMake(17, 128, 257, 45)];
        [txtEmail setPlaceholder:@"电子邮箱(可选)"];
        [txtEmail setFont:[UIFont systemFontOfSize: 15]];
        [txtEmail setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtEmail setTextAlignment:NSTextAlignmentCenter];
        [txtEmail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [txtEmail setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtEmail setBackground:[UIImage imageNamed:@"txtbg"]];
        [txtEmail setDelegate:self];
        [txtEmail setText:@""];
        [view addSubview:txtEmail];
        
        UIButton *btnSubmit=[[UIButton alloc]initWithFrame:CGRectMake(14.5, 224, 291, 40)];
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
        if(IOS7){
            curFrame.origin.y=64;
        }else{
            curFrame.origin.y=0;
        }
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