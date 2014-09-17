//
//  ACGestureStatusCell.m
//  Ancun
//
//  Created by Start on 4/14/14.
//
//

#import "ACGestureStatusCell.h"
#import "NSString+Utils.h"

@implementation ACGestureStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 25)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setText:@"开启密码锁定"];
        [lbl setTextColor:FONTCOLOR1];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lbl];
        
        UISwitch *si=[[UISwitch alloc]initWithFrame:CGRectMake(IOS7?250:220, IOS7?7:9, 0, 0)];
        
        NSString *gesturePwd=[Common getCache:DEFAULTDATA_GESTUREPWD];
        if([gesturePwd isNotEmpty]){
            [si setOn:YES];
        }else{
            [si setOn:NO];
        }
        
        [si addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:si];
    }
    return self;
}

- (void)onChange:(UISwitch *)sender
{
    [self.controller onChange:sender.on];
}

@end
