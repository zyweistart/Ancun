//
//  BeinDangerHistoryCell.m
//  Car
//
//  Created by Start on 11/3/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerHistoryCell.h"

@implementation BeinDangerHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //时间
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(5, 5, 35, 20)];
        [self.lblTime setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblTime];
        //地址
        self.lblAddress=[[XLLabel alloc]initWithFrame:CGRectMake1(40, 5, 200, 20)];
        [self addSubview:self.lblAddress];
        //状态
        self.lblStatus=[[XLLabel alloc]initWithFrame:CGRectMake1(245, 5, 70, 20)];
        [self.lblStatus setTextColor:RGBCOLOR(219, 83, 35)];
        [self.lblStatus setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lblStatus];
        //图片
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake1(5, 25, 310, 90)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.scrollView];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 115, 320, 1)];
        [line setBackgroundColor:BCOLOR(207)];
        [self addSubview:line];
        
        self.imageView1=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 5, 80, 80)];
        [self.imageView1 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView1];
        self.imageView2=[[UIImageView alloc]initWithFrame:CGRectMake1(90, 5, 80, 80)];
        [self.imageView2 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView2];
        self.imageView3=[[UIImageView alloc]initWithFrame:CGRectMake1(175, 5, 80, 80)];
        [self.imageView3 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView3];
        self.imageView4=[[UIImageView alloc]initWithFrame:CGRectMake1(260, 5, 80, 80)];
        [self.imageView4 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView4];
        self.imageView5=[[UIImageView alloc]initWithFrame:CGRectMake1(345, 5, 80, 80)];
        [self.imageView5 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView5];
        self.imageView6=[[UIImageView alloc]initWithFrame:CGRectMake1(430, 5, 80, 80)];
        [self.imageView6 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView6];
        self.imageView7=[[UIImageView alloc]initWithFrame:CGRectMake1(515, 5, 80, 80)];
        [self.imageView7 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView7];
        self.imageView8=[[UIImageView alloc]initWithFrame:CGRectMake1(600, 5, 80, 80)];
        [self.imageView8 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView8];
        self.imageView9=[[UIImageView alloc]initWithFrame:CGRectMake1(685, 5, 80, 80)];
        [self.imageView9 setBackgroundColor:[UIColor redColor]];
        [self.scrollView addSubview:self.imageView9];
        [self.scrollView setContentSize:CGSizeMake1(770, 90)];
    }
    return self;
}

- (void)addSubImage:(NSString*)imageNamed
{
//    NSInteger count=[[self.scrollView subviews]count];
//    CGFloat width=count*80+count*5;
//    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake1(width, 5, 80, 80)];
//    [imv setBackgroundColor:[UIColor redColor]];
//    [self.scrollView setContentSize:CGSizeMake1(width+80, 90)];
//    [self.scrollView addSubview:imv];
//    [self.hDownload AsynchronousDownloadWithUrl:imageNamed RequestCode:502 Object:imv];
    
    
   
    
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(![path isEmpty]){
        UIImageView *imageView=(UIImageView*)sender;
        NSLog(@"%@",imageView);
        if(imageView){
//            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
//            [NSData dataWithContentsOfFile:filePath]
//            dataWithContentsOfFile
            NSData *image = [NSData dataWithContentsOfFile:path];
            if(image){
                [UIImage imageWithData:image];
            }
        }
    }
}

@end