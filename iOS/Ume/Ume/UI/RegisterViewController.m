//
//  RegisterViewController.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterGetCheckCodeViewController.h"
#import "ImageTextField.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    ImageTextField *tPhone;
    ImageTextField *tPassword;
    ImageTextField *tNickname;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"注册"];
        UIButton *bNextSteup = [UIButton buttonWithType:UIButtonTypeCustom];
        [bNextSteup setFrame:CGRectMake1(0, 0, 50, 30)];
        [bNextSteup setTitle:@"下一步" forState:UIControlStateNormal];
        [bNextSteup.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bNextSteup setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [bNextSteup addTarget:self action:@selector(goNextSteup:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bNextSteup];
        
        UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake1(140, 20, 60, 60)];
        [headerImage setImage:[UIImage imageNamed:@"camera_button_take"]];
        [self.view addSubview:headerImage];
        tPhone=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 100, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"手机号"];
        [tPhone.textField setSecureTextEntry:YES];
        [self.view addSubview:tPhone];
        tPassword=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 150, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"密码"];
        [tPassword.textField setSecureTextEntry:YES];
        [self.view addSubview:tPassword];
        tNickname=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 200, 280, 40) Image:@"tabBar_cameraButton_ready_matte" Placeholder:@"昵称"];
        [self.view addSubview:tNickname];
    }
    return self;
}

- (void)goNextSteup:(id)sender
{
    [self.navigationController pushViewController:[[RegisterGetCheckCodeViewController alloc]init] animated:YES];
}

@end
