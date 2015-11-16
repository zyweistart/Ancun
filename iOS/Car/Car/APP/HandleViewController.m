//
//  HandleViewController.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "HandleViewController.h"
#import "UIImage+Utils.h"
#import "CameraUtility.h"
#import "AccidentCerView.h"

@interface HandleViewController ()

@end

@implementation HandleViewController{
    UIScrollView *scrollView;
    CameraView *cameraView1;
    CameraView *cameraView2;
    CameraView *cameraView3;
    CameraView *cameraView4;
    CameraView *cameraView5;
    CameraView *cameraView6;
    CameraView *cameraView7;
    CameraView *cameraView8;
    CameraView *cameraView9;
    XLLabel *lblCompany;
    
    AccidentCerView *mAccidentCerView1;
    AccidentCerView *mAccidentCerView2;
}

- (id)initWithData:(NSDictionary *)data
{
    [self setInsuranceOData:data];
    self=[super init];
    if(self){
        [self setTitle:@"现场拍照取证 "];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView setContentSize:CGSizeMake1(320, 660+50)];
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
    [cameraView4.pai setTag:1];
    [cameraView4.pai addTarget:self action:@selector(goPai:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraView4];
    //图5
    cameraView5=[[CameraView alloc]initWithFrame:CGRectMake1(0, 264, 160, 132)];
    [scrollView addSubview:cameraView5];
    //图6
    cameraView6=[[CameraView alloc]initWithFrame:CGRectMake1(160, 264, 160, 132)];
    [cameraView6.lblInfo setText:@"补充照片"];
    [cameraView6 setControler:self];
    [cameraView6 setDelegate:self];
    [cameraView6 setIsDelete:YES];
    [scrollView addSubview:cameraView6];
    //图7
    cameraView7=[[CameraView alloc]initWithFrame:CGRectMake1(0, 396, 160, 132)];
    [cameraView7.lblInfo setText:@"补充照片"];
    [cameraView7 setControler:self];
    [cameraView7 setDelegate:self];
    [cameraView7 setIsDelete:YES];
    [scrollView addSubview:cameraView7];
    //图8
    cameraView8=[[CameraView alloc]initWithFrame:CGRectMake1(160, 396, 160, 132)];
    [cameraView8.lblInfo setText:@"补充照片"];
    [cameraView8 setControler:self];
    [cameraView8 setDelegate:self];
    [cameraView8 setIsDelete:YES];
    [scrollView addSubview:cameraView8];
    //图9
    cameraView9=[[CameraView alloc]initWithFrame:CGRectMake1(0, 528, 160, 132)];
    [cameraView9.lblInfo setText:@"补充照片"];
    [cameraView9 setControler:self];
    [cameraView9 setDelegate:self];
    [cameraView9 setIsDelete:YES];
    [scrollView addSubview:cameraView9];
    
    [cameraView7 setHidden:YES];
    [cameraView8 setHidden:YES];
    [cameraView9 setHidden:YES];
    if(self.insuranceOData){
        //两车事故
        [cameraView5.lblInfo setText:@"当事人2驾驶证、行驶证"];
        [cameraView5.currentImageView setImage:[UIImage imageNamed:@"证件小"]];
        [cameraView5.pai setTag:2];
        [cameraView5.pai addTarget:self action:@selector(goPai:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        //单车事故
        [cameraView5.lblInfo setText:@"补充照片"];
        [cameraView5 setControler:self];
        [cameraView5 setDelegate:self];
        [cameraView5 setIsDelete:YES];
        [cameraView6 setHidden:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(mAccidentCerView1==nil){
        mAccidentCerView1=[[AccidentCerView alloc]initWithFrame:self.view.bounds];
        [mAccidentCerView1 setHidden:YES];
        [mAccidentCerView1 setDelegate:self];
        [mAccidentCerView1.cameraViewPai setDelegate:self];
        [mAccidentCerView1.cameraViewPai setControler:self];
        [mAccidentCerView1.cameraViewPai.lblInfo setText:@"当事人1驾驶证、行驶证"];
        [mAccidentCerView1.bOk setTag:1];
        [mAccidentCerView1.bCancel setTag:1];
        [self.navigationController.view addSubview:mAccidentCerView1];
    }
    if(mAccidentCerView2==nil){
        mAccidentCerView2=[[AccidentCerView alloc]initWithFrame:self.view.bounds];
        [mAccidentCerView2 setHidden:YES];
        [mAccidentCerView2 setDelegate:self];
        [mAccidentCerView2.cameraViewPai setDelegate:self];
        [mAccidentCerView2.cameraViewPai setControler:self];
        [mAccidentCerView2.cameraViewPai.lblInfo setText:@"当事人2驾驶证、行驶证"];
        [mAccidentCerView2.bOk setTag:2];
        [mAccidentCerView2.bCancel setTag:2];
        [self.navigationController.view addSubview:mAccidentCerView2];
    }
}

- (void)CameraSuccess:(CameraView*)camera
{
    if(camera==cameraView5){
        if(cameraView5.currentImage){
            [cameraView6 setHidden:NO];
        }
    }else if(camera==cameraView6){
        if(cameraView6.currentImage){
            [cameraView7 setHidden:NO];
        }
    }else if(camera==cameraView7){
        if(cameraView7.currentImage){
            [cameraView8 setHidden:NO];
        }
    }else if(camera==cameraView8){
        if(cameraView8.currentImage){
            [cameraView9 setHidden:NO];
        }
    }
}

- (void)CameraDelete:(CameraView *)camera
{
    if(camera==cameraView5){
        if(cameraView6.currentImage){
            [self cameraCopy:cameraView5 To:cameraView6];
            [self resetCameraView:cameraView6];
            [cameraView6 setHidden:NO];
            [cameraView7 setHidden:YES];
            [cameraView8 setHidden:YES];
            [cameraView9 setHidden:YES];
            if(cameraView7.currentImage){
                [self cameraCopy:cameraView6 To:cameraView7];
                [self resetCameraView:cameraView7];
                [cameraView7 setHidden:NO];
                [cameraView8 setHidden:YES];
                [cameraView9 setHidden:YES];
                if(cameraView8.currentImage){
                    [self cameraCopy:cameraView7 To:cameraView8];
                    [self resetCameraView:cameraView8];
                    [cameraView8 setHidden:NO];
                    [cameraView9 setHidden:YES];
                    if(cameraView9.currentImage){
                        [self cameraCopy:cameraView8 To:cameraView9];
                        [self resetCameraView:cameraView9];
                        [cameraView9 setHidden:NO];
                    }
                }
            }
        }else{
            [cameraView6 setHidden:YES];
        }
    }else if(camera==cameraView6){
        if(cameraView7.currentImage){
            [self cameraCopy:cameraView6 To:cameraView7];
            [self resetCameraView:cameraView7];
            [cameraView7 setHidden:NO];
            [cameraView8 setHidden:YES];
            [cameraView9 setHidden:YES];
            if(cameraView8.currentImage){
                [self cameraCopy:cameraView7 To:cameraView8];
                [self resetCameraView:cameraView8];
                [cameraView8 setHidden:NO];
                [cameraView9 setHidden:YES];
                if(cameraView9.currentImage){
                    [self cameraCopy:cameraView8 To:cameraView9];
                    [self resetCameraView:cameraView9];
                    [cameraView9 setHidden:NO];
                }
            }
        }else{
            [cameraView7 setHidden:YES];
        }
    }else if(camera==cameraView7){
        if(cameraView8.currentImage){
            [self cameraCopy:cameraView7 To:cameraView8];
            [self resetCameraView:cameraView8];
            [cameraView8 setHidden:NO];
            [cameraView9 setHidden:YES];
            if(cameraView9.currentImage){
                [self cameraCopy:cameraView8 To:cameraView9];
                [self resetCameraView:cameraView9];
                [cameraView9 setHidden:NO];
            }
        }else{
            [cameraView7 setHidden:YES];
        }
    }else if(camera==cameraView8){
        if(cameraView9.currentImage){
            [self cameraCopy:cameraView8 To:cameraView9];
            [self resetCameraView:cameraView9];
            [cameraView9 setHidden:NO];
        }else{
            [cameraView8 setHidden:YES];
        }
    }
}

- (void)cameraCopy:(CameraView*)obj To:(CameraView*)to
{
    [obj setDelegate:self];
    [obj setIsDelete:to.isDelete];
    [obj setCurrentImage:to.currentImage];
    [obj.currentImageView setImage:to.currentImageView.image];
    [obj.pai setHidden:YES];
    [obj.rPai setHidden:NO];
}

- (void)resetCameraView:(CameraView*)camera
{
    [camera setIsDelete:YES];
    [camera setDelegate:self];
    [camera setCurrentImage:nil];
    [camera.currentImageView setImage:nil];
    [camera.pai setHidden:NO];
    [camera.rPai setHidden:YES];
}

- (void)goSubmit
{
    NSLog(@"地图wyth :%@",self.mapData);
    NSLog(@"保险公司一:%@",self.insuranceData);
    NSLog(@"保险公司二:%@",self.insuranceOData);
    NSLog(@"碰撞部位局部照:%@",cameraView1.currentImage);
    NSLog(@"前车前方5米前景:%@",cameraView2.currentImage);
    NSLog(@"后车后方5米后景:%@",cameraView3.currentImage);
    NSLog(@"当事人1驾驶证、行驶证:%@",cameraView4.currentImage);
    NSLog(@"当事人1驾驶证、行驶证车牌号:%@",[mAccidentCerView1.tfCarNumber text]);
    NSLog(@"当事人1驾驶证、行驶证手机号:%@",[mAccidentCerView1.tfPhone text]);
    NSLog(@"当事人1驾驶证、行驶证验证码:%@",[mAccidentCerView1.tfCode text]);
    if(self.insuranceOData){
        NSLog(@"当事人2驾驶证、行驶证:%@",cameraView5.currentImage);
        NSLog(@"当事人2驾驶证、行驶证车牌号:%@",[mAccidentCerView2.tfCarNumber text]);
        NSLog(@"当事人2驾驶证、行驶证手机号:%@",[mAccidentCerView2.tfPhone text]);
        NSLog(@"当事人2驾驶证、行驶证验证码:%@",[mAccidentCerView2.tfCode text]);
        NSLog(@"补充照片1:%@",cameraView6.currentImage);
        NSLog(@"补充照片2:%@",cameraView7.currentImage);
        NSLog(@"补充照片3:%@",cameraView8.currentImage);
        NSLog(@"补充照片4:%@",cameraView9.currentImage);
    }else{
        NSLog(@"补充照片1:%@",cameraView5.currentImage);
        NSLog(@"补充照片2:%@",cameraView6.currentImage);
        NSLog(@"补充照片3:%@",cameraView7.currentImage);
        NSLog(@"补充照片4:%@",cameraView8.currentImage);
    }
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)accidentCerViewOK:(id)sender
{
    if([sender tag]==1){
        if(mAccidentCerView1.cameraViewPai.currentImage){
            [cameraView4 setCurrentImage:mAccidentCerView1.cameraViewPai.currentImage];
            [cameraView4.currentImageView setImage:cameraView4.currentImage];
        }
        [mAccidentCerView1 setHidden:YES];
    }else if([sender tag]==2){
        if(mAccidentCerView2.cameraViewPai.currentImage){
            [cameraView5 setCurrentImage:mAccidentCerView2.cameraViewPai.currentImage];
            [cameraView5.currentImageView setImage:cameraView5.currentImage];
        }
        [mAccidentCerView2 setHidden:YES];
    }
}

- (void)accidentCerViewCancel:(id)sender
{
    if([sender tag]==1){
        [mAccidentCerView1 setHidden:YES];
    }else if([sender tag]==2){
        [mAccidentCerView2 setHidden:YES];
    }
}

- (void)goPai:(UIButton*)sender
{
    if([sender tag]==1){
        [mAccidentCerView1 setHidden:NO];
    }else if([sender tag]==2){
        [mAccidentCerView2 setHidden:NO];
    }
}

@end