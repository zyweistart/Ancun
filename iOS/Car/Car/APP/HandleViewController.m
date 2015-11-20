//
//  HandleViewController.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define KEYTIME @"KEYTIME"
#define KEYLATITUDE @"KEYLATITUDE"
#define KEYLONGITUDE @"KEYLONGITUDE"
#define KEYADDRESSNAME @"KEYADDRESSNAME"

#import "HandleViewController.h"
#import "AccidentCerView.h"

@interface HandleViewController ()

@end

@implementation HandleViewController{
    XLLabel *lblCompany;
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
    [cameraView4.lblInfo setText:@"当事人驾驶证、行驶证"];
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
        [cameraView4.lblInfo setText:@"当事人1驾驶证、行驶证"];
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
        if(self.insuranceOData){
            //两车事故
            [mAccidentCerView1.cameraViewPai.lblInfo setText:@"当事人1驾驶证、行驶证"];
        }else{
            //单车事故
            [mAccidentCerView1.cameraViewPai.lblInfo setText:@"当事人驾驶证、行驶证"];
        }
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
    [obj setImageNetAddressUrl:to.imageNetAddressUrl];
    [obj.currentImageView setImage:to.currentImageView.image];
    [obj.pai setHidden:YES];
    [obj.rPai setHidden:NO];
}

- (void)resetCameraView:(CameraView*)camera
{
    [camera setIsDelete:YES];
    [camera setDelegate:self];
    [camera resetCamera];
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
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"addAccident" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[User getInstance].uid forKey:@"uid"];
    [dic setObject:cameraView1.imageNetAddressUrl forKey:@"accidentPic1"];
    [dic setObject:cameraView2.imageNetAddressUrl forKey:@"accidentPic2"];
    [dic setObject:cameraView3.imageNetAddressUrl forKey:@"accidentPic3"];
    [dic setObject:cameraView4.imageNetAddressUrl forKey:@"accidentPic4"];
    [dic setObject:@""forKey:@"accidentPic5"];
    [dic setObject:[self.insuranceData objectForKey:@"insurerId"] forKey:@"insuranceOne"];
    [dic setObject:@"" forKey:@"insuranceTwo"];
    [dic setObject:[self.mapData objectForKey:KEYADDRESSNAME] forKey:@"address"];
    [dic setObject:[self.mapData objectForKey:KEYTIME] forKey:@"happenTime"];
    [dic setObject:[mAccidentCerView1.tfPhone text] forKey:@"mobile1"];
    [dic setObject:[mAccidentCerView1.tfCarNumber text] forKey:@"carNoOne"];
    [dic setObject:[mAccidentCerView2.tfPhone text] forKey:@"mobile2"];
    [dic setObject:[mAccidentCerView2.tfCarNumber text] forKey:@"carNoTwo"];
    if(self.insuranceOData){
        if([cameraView4.imageNetAddressUrl isEmpty]){
            [Common alert:@"请上传当事人1驾驶证、行驶证"];
            return;
        }
        if([cameraView5.imageNetAddressUrl isEmpty]){
            [Common alert:@"请上传当事人2驾驶证、行驶证"];
            return;
        }
        //两车事故
        [dic setObject:@"2" forKey:@"type"];
        [dic setObject:[self.insuranceOData objectForKey:@"insurerId"] forKey:@"insuranceTwo"];
        [dic setObject:cameraView5.imageNetAddressUrl forKey:@"accidentPic5"];
        NSArray *picMores=@[cameraView6.imageNetAddressUrl,
                            cameraView7.imageNetAddressUrl,
                            cameraView8.imageNetAddressUrl,
                            cameraView9.imageNetAddressUrl];
        NSMutableString *addressUrls=[[NSMutableString alloc]init];
        for(NSString *pic in picMores){
            if(![pic isEmpty]){
                [addressUrls appendFormat:@"%@,",pic];
            }
        }
        if([addressUrls length]>0){
            NSRange deleteRange1 = {[addressUrls length]-1,1};
            [addressUrls deleteCharactersInRange:deleteRange1];
        }
        [dic setObject:addressUrls forKey:@"accidentPicMore"];
    }else{
        if([cameraView4.imageNetAddressUrl isEmpty]){
            [Common alert:@"请上传当事人驾驶证、行驶证"];
            return;
        }
        //单车事故
        [dic setObject:@"1" forKey:@"type"];
        NSArray *picMores=@[cameraView5.imageNetAddressUrl,
                            cameraView6.imageNetAddressUrl,
                            cameraView7.imageNetAddressUrl,
                            cameraView8.imageNetAddressUrl];
        NSMutableString *addressUrls=[[NSMutableString alloc]init];
        for(NSString *pic in picMores){
            if(![pic isEmpty]){
                [addressUrls appendFormat:@"%@,",pic];
            }
        }
        if([addressUrls length]>0){
            NSRange deleteRange1 = {[addressUrls length]-1,1};
            [addressUrls deleteCharactersInRange:deleteRange1];
        }
        [dic setObject:addressUrls forKey:@"accidentPicMore"];
    }
    [self.hRequest setJsonParams:dic];
    [self.hRequest setDelegate:self];
    [self.hRequest setView:self.view];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
    NSLog(@"%@",dic);
}

- (void)accidentCerViewOK:(id)sender
{
    if([sender tag]==1){
        if(mAccidentCerView1.cameraViewPai.currentImage){
            [cameraView4 setImageNetAddressUrl:mAccidentCerView1.cameraViewPai.imageNetAddressUrl];
            [cameraView4 setCurrentImage:mAccidentCerView1.cameraViewPai.currentImage];
            [cameraView4.currentImageView setImage:cameraView4.currentImage];
        }
        [mAccidentCerView1 setHidden:YES];
    }else if([sender tag]==2){
        if(mAccidentCerView2.cameraViewPai.currentImage){
            [cameraView5 setImageNetAddressUrl:mAccidentCerView2.cameraViewPai.imageNetAddressUrl];
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

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [Common alert:@"事故上报成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

@end