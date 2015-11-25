//
//  CameraViewCell.m
//  Car
//
//  Created by Start on 11/24/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CameraViewCell.h"

@implementation CameraViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithArray:(NSArray*)array Controller:(UIViewController*)controller {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:BCOLOR(244)];
        NSInteger count=[array count];
        for(int i=0;i<count;i++){
            NSDictionary *data=[array objectAtIndex:i];
            CameraView *cameraV=[[CameraView alloc]initWithFrame:CGRectMake1(i%2*160, i/2*132, 160, 132)];
            [cameraV setBackgroundColor:BCOLOR(244)];
            [cameraV.lblInfo setText:[data objectForKey:@"title"]];
            [cameraV setIsDelete:YES];
            [cameraV setDelegate:self];
            [cameraV setControler:controller];
            [self addSubview:cameraV];
        }
        XLButton *bSubmit=[[XLButton alloc]initWithFrame:CGRectMake1(10, (count/2+count%2)*132+10, 300, 40) Name:@"提交照片" Type:3];
        [bSubmit addTarget:self action:@selector(goSubmit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bSubmit];
    }
    return self;
}

- (void)goSubmit
{
    NSLog(@"提交了");
}

@end