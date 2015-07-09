//
//  AtUserView.m
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "AtUserView.h"
#import "CLabel.h"
#import "ContactViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation AtUserView{
    UIButton *mAddatUser;
    UIButton *bClose;
}


- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //@某人
        mAddatUser=[[UIButton alloc]initWithFrame:CGRectMake1(10,10,40,40)];
        mAddatUser.layer.cornerRadius=mAddatUser.bounds.size.width/2;
        mAddatUser.layer.masksToBounds=YES;
        [mAddatUser setBackgroundColor:DEFAULTITLECOLOR(216)];
        [mAddatUser setImage:[UIImage imageNamed:@"icon-nav-share"] forState:UIControlStateNormal];
        [mAddatUser addTarget:self action:@selector(goAddAtUser:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mAddatUser];
        
    }
    return self;
}

- (void)goClose:(id)sender
{
    
}

- (void)goAddAtUser:(id)sender
{
    [self.currentController.navigationController pushViewController:[[ContactViewController alloc]init] animated:YES];
}

@end