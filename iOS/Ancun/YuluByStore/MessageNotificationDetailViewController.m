//
//  MessageNotificationDetailViewController.m
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import "MessageNotificationDetailViewController.h"

@interface MessageNotificationDetailViewController ()

@end

@implementation MessageNotificationDetailViewController{
    SQLiteOperate *db;
}

- (id)initWithMessage:(Message*)message{
    self = [super init];
    if (self) {
        self.title=@"消息通知";
        self.message=message;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        db=[[SQLiteOperate alloc]init];
        NSLog(@"%@",message);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end