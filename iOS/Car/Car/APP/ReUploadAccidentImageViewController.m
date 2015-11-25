//
//  ReUploadAccidentImageViewController.m
//  Car
//
//  Created by Start on 11/25/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ReUploadAccidentImageViewController.h"

@interface ReUploadAccidentImageViewController ()

@end

@implementation ReUploadAccidentImageViewController{
    XLLabel *lblCompany;
    UIScrollView *scrollView;
    CameraView *cameraView1;
    CameraView *cameraView2;
    CameraView *cameraView3;
    CameraView *cameraView4;
    CameraView *cameraView5;
}

- (id)initWithData:(NSDictionary *)data
{
    [self setCData:data];
    NSLog(@"%@",self.cData);
    self=[super init];
    if(self){
        [self setTitle:@"现场拍照取证"];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView setContentSize:CGSizeMake1(320, 396+50)];
    [scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [scrollView setBackgroundColor:BCOLOR(244)];
    [self.view addSubview:scrollView];
    XLButton *bSubmit=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), self.view.bounds.size.height-64-CGHeight(45), CGWidth(300),CGHeight(40)) Name:@"提交照片" Type:3];
    [bSubmit addTarget:self action:@selector(goSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bSubmit];
    //图1
    cameraView1=[[CameraView alloc]initWithFrame:CGRectMake1(0, 0, 160, 132)];
    [cameraView1.lblInfo setText:@"碰撞部位局部照"];
    [cameraView1.currentImageView setImage:[UIImage imageNamed:@"局部照"]];
    [cameraView1 setControler:self];
    [scrollView addSubview:cameraView1];
    //图2
    cameraView2=[[CameraView alloc]initWithFrame:CGRectMake1(160, 0, 160, 132)];
    [cameraView2.lblInfo setText:@"前车前方5米前景"];
    [cameraView2.currentImageView setImage:[UIImage imageNamed:@"前景"]];
    [cameraView2 setControler:self];
    [scrollView addSubview:cameraView2];
    //图3
    cameraView3=[[CameraView alloc]initWithFrame:CGRectMake1(0, 132, 160, 132)];
    [cameraView3.lblInfo setText:@"后车后方5米后景"];
    [cameraView3.currentImageView setImage:[UIImage imageNamed:@"后景"]];
    [cameraView3 setControler:self];
    [scrollView addSubview:cameraView3];
    //图4
    cameraView4=[[CameraView alloc]initWithFrame:CGRectMake1(160, 132, 160, 132)];
    [cameraView4.lblInfo setText:@"当事人1驾驶证、行驶证"];
    [cameraView4.currentImageView setImage:[UIImage imageNamed:@"证件小"]];
    [scrollView addSubview:cameraView4];
    //图5
    cameraView5=[[CameraView alloc]initWithFrame:CGRectMake1(0, 264, 160, 132)];
    [cameraView5.lblInfo setText:@"当事人2驾驶证、行驶证"];
    [cameraView5.currentImageView setImage:[UIImage imageNamed:@"证件小"]];
    [scrollView addSubview:cameraView5];
    NSString *images=[self.cData objectForKey:@"images"];
    NSArray *foo=[images componentsSeparatedByString:@","];
    if([foo count]==4){
        [cameraView1 loadHttpImage:[foo objectAtIndex:0]];
        [cameraView2 loadHttpImage:[foo objectAtIndex:1]];
        [cameraView3 loadHttpImage:[foo objectAtIndex:2]];
        [cameraView4 loadHttpImage:[foo objectAtIndex:3]];
    }
    if([foo count]==5){
        [cameraView5 loadHttpImage:[foo objectAtIndex:4]];
    }else{
        [cameraView5 setHidden:YES];
    }
    [cameraView1 setStatus:YES];
    [cameraView2 setStatus:NO];
    [cameraView3 setStatus:NO];
    [cameraView4 setStatus:YES];
    [cameraView5 setStatus:YES];
}

- (void)CameraSuccess:(CameraView*)camera
{
}

- (void)CameraDelete:(CameraView *)camera
{
}

- (void)goSubmit
{
    NSLog(@"提交照片");
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            
        }
    }
}

@end
