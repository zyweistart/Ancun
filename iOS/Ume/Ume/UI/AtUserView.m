//
//  AtUserView.m
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "AtUserView.h"
#import "CLabel.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation AtUserView{
    UIButton *bClose;
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //@某人
        self.mAddatUser=[[UIButton alloc]initWithFrame:CGRectMake1(10,10,40,40)];
        self.mAddatUser.layer.cornerRadius=self.mAddatUser.bounds.size.width/2;
        self.mAddatUser.layer.masksToBounds=YES;
        [self.mAddatUser setBackgroundColor:DEFAULTITLECOLOR(216)];
        [self.mAddatUser setImage:[UIImage imageNamed:@"icon-nav-share"] forState:UIControlStateNormal];
        [self addSubview:self.mAddatUser];
        
    }
    return self;
}

- (void)goClose:(id)sender
{
    
}

- (void)setAtUserLayout:(NSArray*)datas
{
    [self.mAddatUser setHidden:YES];
    
    NSUInteger count=[datas count]+1;
    NSUInteger row=count/4;
    if([datas count]%4>0){
        row++;
    }
    for(int i=0;i<[datas count];i++){
        for(int j=0;j<4;j++){
            NSString *name=[datas objectAtIndex:i];
            CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1((60*i), 10, 60, 30) Text:name];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:lbl];
            
        }
    }
}

@end