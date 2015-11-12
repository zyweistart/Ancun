//
//  PhotographDetailViewController.m
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PhotographDetailViewController.h"
#import "UIButton+Utils.h"

@implementation PhotographDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"随手拍"];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [lblName setText:@"KFJDLKSJAFLDSF.JPG"];
    [lblName setFont:GLOBAL_FONTSIZE(15)];
    [lblName setTextColor:[UIColor whiteColor]];
    [lblName setBackgroundColor:BCOLOR(50)];
    [self.view addSubview:lblName];
    UIImageView *pImageV=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 40, 320, 150)];
    [pImageV setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:pImageV];
    UIView *operatorView=[[UIView alloc]initWithFrame:CGRectMake1(0, 190, 320, 80)];
    [operatorView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:operatorView];
    UIButton *bPlayer=[[UIButton alloc]initWithFrame:CGRectMake1(70, 20, 60, 40)];
    [bPlayer setImage:[UIImage imageNamed:@"播放_开始"] forState:UIControlStateNormal];
    [bPlayer addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bPlayer];
    UIButton *bName=[[UIButton alloc]initWithFrame:CGRectMake1(130, 20, 60, 40)];
    [bName setImage:[UIImage imageNamed:@"重命名"] forState:UIControlStateNormal];
    [bName addTarget:self action:@selector(goReName) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bName];
    UIButton *bDel=[[UIButton alloc]initWithFrame:CGRectMake1(190, 20, 60, 40)];
    [bDel setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [bDel addTarget:self action:@selector(goDelete) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bDel];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 280,70, 30) Text:@"文件大小:"];
    [self.view addSubview:lbl];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 310,70, 30) Text:@"文件类型:"];
    [self.view addSubview:lbl];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(15, 340,70, 30) Text:@"存证时间:"];
    [self.view addSubview:lbl];
}

- (void)goDetail
{
    NSLog(@"播放");
}

- (void)goReName
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"重命名" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)goDelete
{
    NSLog(@"删除");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *tf=[alertView textFieldAtIndex:0];
    [tf resignFirstResponder];
    if(buttonIndex==1){
        NSString *name=[tf text];
        if(![name isEmpty]){
            NSLog(@"%@",name);
        }
    }
}

@end