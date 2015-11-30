//
//  ReUploadAccidentImageViewController.m
//  Car
//
//  Created by Start on 11/25/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ReUploadAccidentImageViewController.h"
#import "WaitHandleViewController.h"

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
    [cameraView4 setControler:self];
    [scrollView addSubview:cameraView4];
    //图5
    cameraView5=[[CameraView alloc]initWithFrame:CGRectMake1(0, 264, 160, 132)];
    [cameraView5.lblInfo setText:@"当事人2驾驶证、行驶证"];
    [cameraView5.currentImageView setImage:[UIImage imageNamed:@"证件小"]];
    [cameraView5 setControler:self];
    [scrollView addSubview:cameraView5];
    
    NSString *accidentPic1=[self.cData objectForKey:@"accidentPic1"];
    NSString *accidentPic2=[self.cData objectForKey:@"accidentPic2"];
    NSString *accidentPic3=[self.cData objectForKey:@"accidentPic3"];
    NSString *accidentPic4=[self.cData objectForKey:@"accidentPic4"];
    NSString *accidentPic5=[self.cData objectForKey:@"accidentPic5"];
    [cameraView1 loadHttpImage:accidentPic1];
    [cameraView2 loadHttpImage:accidentPic2];
    [cameraView3 loadHttpImage:accidentPic3];
    [cameraView4 loadHttpImage:accidentPic4];
    NSString *type=[self.cData objectForKey:@"type"];
    if([@"1" isEqualToString:type]){
        //单车事故
        [cameraView5 setHidden:YES];
    }else{
        [cameraView5 loadHttpImage:accidentPic5];
    }
    
    [cameraView1 setStatus:YES];
    [cameraView2 setStatus:YES];
    [cameraView3 setStatus:YES];
    [cameraView4 setStatus:YES];
    [cameraView5 setStatus:YES];
    NSArray *picData=[self.cData objectForKey:@"picData"];
    for(NSDictionary *da in picData){
        NSString *url=[da objectForKey:@"pic"];
        if([accidentPic1 isEqualToString:url]){
            [cameraView1 setStatus:NO];
        }else if([accidentPic2 isEqualToString:url]){
            [cameraView2 setStatus:NO];
        }else if([accidentPic3 isEqualToString:url]){
            [cameraView3 setStatus:NO];
        }else if([accidentPic4 isEqualToString:url]){
            [cameraView4 setStatus:NO];
        }else if([accidentPic5 isEqualToString:url]){
            [cameraView5 setStatus:NO];
        }
    }
}

- (void)goSubmit
{
    if([cameraView1.imageNetAddressUrl isEmpty]){
        [Common alert:@"请上传碰撞部位局部照"];
        return;
    }
    if([cameraView2.imageNetAddressUrl isEmpty]){
        [Common alert:@"请上传前车前方5米前景照"];
        return;
    }
    if([cameraView3.imageNetAddressUrl isEmpty]){
        [Common alert:@"请上传后车后方5米后景照"];
        return;
    }
    if([cameraView4.imageNetAddressUrl isEmpty]){
        [Common alert:@"请上传当事人驾驶证、行驶证"];
        return;
    }
    NSString *cid=[self.cData objectForKey:@"id"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"updateAccidentPic" forKey:@"act"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[User getInstance].uid forKey:@"uid"];
    [dic setObject:cid forKey:@"id"];
    [dic setObject:cameraView1.imageNetAddressUrl forKey:@"accidentPic1"];
    [dic setObject:cameraView2.imageNetAddressUrl forKey:@"accidentPic2"];
    [dic setObject:cameraView3.imageNetAddressUrl forKey:@"accidentPic3"];
    [dic setObject:cameraView4.imageNetAddressUrl forKey:@"accidentPic4"];
    NSString *type=[self.cData objectForKey:@"type"];
    if([@"1" isEqualToString:type]){
        [dic setObject:@""forKey:@"accidentPic5"];
    }else{
        //多车
        if([cameraView5.imageNetAddressUrl isEmpty]){
            [Common alert:@"请上传当事人2驾驶证、行驶证"];
            return;
        }
        //两车事故
        [dic setObject:cameraView5.imageNetAddressUrl forKey:@"accidentPic5"];
    }
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setJsonParams:dic];
    [self.hRequest setDelegate:self];
    [self.hRequest setView:self.view];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [self.navigationController pushViewController:[[WaitHandleViewController alloc]initWithData:self.cData] animated:YES];
        }
    }
}

@end
