//
//  CameraViewCell.m
//  Car
//
//  Created by Start on 11/24/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CameraViewCell.h"

@implementation CameraViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArray:(NSArray*)array Controller:(BeinDangerDetailViewController*)controller {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.currentController=controller;
        [self setBackgroundColor:[UIColor whiteColor]];
        NSInteger count=[array count];
        for(int i=0;i<count;i++){
            NSDictionary *data=[array objectAtIndex:i];
            CameraView *cameraV=[[CameraView alloc]initWithFrame:CGRectMake1(i%2*160, i/2*132, 160, 132)];
            [cameraV setBackgroundColor:[UIColor whiteColor]];
            [cameraV.lblInfo setText:[data objectForKey:@"title"]];
            [cameraV setDelegate:self];
            [cameraV setControler:controller];
            [cameraV setType:6];
            [self addSubview:cameraV];
            NSString *uploadUrl=[data objectForKey:@"uploadUrl"];
            if(![uploadUrl isEmpty]){
                [cameraV loadHttpImage:[data objectForKey:@"uploadUrl"]];
                [cameraV setStatus:NO];
            }
        }
        XLButton *bSubmit=[[XLButton alloc]initWithFrame:CGRectMake1(10, (count/2+count%2)*132+10, 300, 40) Name:@"提交照片" Type:3];
        [bSubmit addTarget:self action:@selector(goSubmit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bSubmit];
    }
    return self;
}

- (void)goSubmit
{
    NSMutableString *urls=[[NSMutableString alloc]init];
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[CameraView class]]){
            CameraView *cv=(CameraView*)view;
            if(cv.imageNetAddressUrl==nil||[cv.imageNetAddressUrl isEmpty]){
                [Common alert:@"请补拍所需的照片"];
                return ;
            }else{
                [urls appendFormat:@"%@,",cv.imageNetAddressUrl];
            }
        }
    }
    NSRange deleteRange = {[urls length]-1,1};
    [urls deleteCharactersInRange:deleteRange];
    NSString *cid=[self.cData objectForKey:@"id"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"bpConfirm" forKey:@"act"];
    [params setObject:urls forKey:@"assessmentPic"];
    [params setObject:cid forKey:@"id"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setView:self.currentController.view];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [self.currentController loadHttpData];
        }
    }
}

@end