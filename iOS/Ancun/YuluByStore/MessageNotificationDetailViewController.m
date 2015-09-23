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

@implementation MessageNotificationDetailViewController

- (id)initWithMessage:(Message*)message{
    self = [super init];
    if (self) {
        self.title=@"消息通知";
        self.message=message;
//        [self.message setOper:@"6"];
//        [self.message setContent:@"消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知消息通知"];
//        [self.message setUrl:@"http://www.baidu.com@http://file.ynet.com/2/1509/23/10402348-500.jpg"];
//        [self.message setUrl:@"http://www.qq.com"];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
        [self.lblTitle setText:message.title];
        [self.lblTitle setFont:[UIFont systemFontOfSize:17]];
        [self.lblTitle setTextColor:[UIColor blackColor]];
        [self.view addSubview:self.lblTitle];
        self.lblDate=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 20)];
        [self.lblDate setText:message.date];
        [self.lblDate setFont:[UIFont systemFontOfSize:15]];
        [self.lblDate setTextColor:[UIColor grayColor]];
        [self.view addSubview:self.lblDate];
        UIFont *font=[UIFont systemFontOfSize:16];
        NSDictionary *attrs = @{NSFontAttributeName:font};
        CGSize size=[message.content boundingRectWithSize:CGSizeMake1(300, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        self.lblContent=[[UILabel alloc]initWithFrame:CGRectMake(CGWidth(10), CGHeight(70), CGWidth(300), size.height)];
        [self.lblContent setText:message.content];
        [self.lblContent setFont:font];
        [self.lblContent setTextColor:[UIColor grayColor]];
        [self.lblContent setNumberOfLines:0];
        [self.lblContent sizeToFit];
        [self.view addSubview:self.lblContent];
        //顶
        CGFloat topHeight=CGHeight(70)+size.height+CGHeight(10);
        if([@"5" isEqualToString:self.message.oper]){
            //图片
            NSArray *list=[self.message.url componentsSeparatedByString:@"@"];
            if([list count]==2){
                self.imImage=[[UIImageView alloc]initWithFrame:CGRectMake(CGWidth(10), topHeight, CGWidth(300), CGHeight(100))];
                [self.imImage setBackgroundColor:[UIColor clearColor]];
                [self.imImage setUserInteractionEnabled:YES];
                [self.imImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goOpenLink)]];
                [self.view addSubview:self.imImage];
                [self.hDownload AsynchronousDownloadWithUrl:[list objectAtIndex:1] RequestCode:500 Object:self.imImage];
            }
        }else if([@"6" isEqualToString:self.message.oper]){
            //链接
            self.lblLinkAddress=[[UILabel alloc]initWithFrame:CGRectMake(CGWidth(10), topHeight, CGWidth(300), CGHeight(20))];
            [self.lblLinkAddress setText:message.url];
            [self.lblLinkAddress setFont:[UIFont systemFontOfSize:15]];
            [self.lblLinkAddress setTextColor:[UIColor grayColor]];
            [self.lblLinkAddress setUserInteractionEnabled:YES];
            [self.lblLinkAddress addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goOpenLink2)]];
            [self.view addSubview:self.lblLinkAddress];
        }else if([@"2" isEqualToString:self.message.oper]){
            //按钮
        }
    }
    return self;
}

- (void)goOpenLink
{
    NSArray *list=[self.message.url componentsSeparatedByString:@"@"];
    NSString *urlText = [list objectAtIndex:0];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}

- (void)goOpenLink2
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.message.url]];
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(![@"" isEqualToString:path]){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
            }
        }
    }
}

@end