//
//  MeetXDViewController.m
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MeetXDViewController.h"
#import "UITableGridViewCell.h"
#import "UIImageButton.h"
#import "SJAvatarBrowser.h"
#import "CButton.h"
#import "CLabel.h"
#define kImageWidth  CGWidth(100) //UITableViewCell里面图片的宽度
#define kImageHeight  CGHeight(150) //UITableViewCell里面图片的高度
@interface MeetXDViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *image;
@end

@implementation MeetXDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"遇见心动";
    
    //筛选
    UIButton *bPublished = [[UIButton alloc]init];
    [bPublished setFrame:CGRectMake1(0, 0, 80, 30)];
    [bPublished setTitle:@"发布形象" forState:UIControlStateNormal];
    [bPublished.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [bPublished setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bPublished addTarget:self action:@selector(goPublished:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    negativeSpacerRight.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bPublished], nil];
    
    self.image = [self cutCenterImage:[UIImage imageNamed:@"personalbg"]  size:CGSizeMake(kImageWidth, kImageHeight)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 115)];
    [self.tableView setTableFooterView:bottomView];
    CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 60) Text:@"摇一摇寻觅心动，点图像，唱一首歌或说一句话表达此时此刻心情吧！她会是你初见心动的那位吗？"];
    [lbl setNumberOfLines:0];
    [bottomView addSubview:lbl];
    CButton *button=[[CButton alloc]initWithFrame:CGRectMake1(10, 70, 300, 40) Name:@"摇一摇，换一批" Type:1];
    [bottomView addSubview:button];
}

#pragma mark UITable datasource and delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    //自定义UITableGridViewCell，里面加了个NSArray用于放置里面的3个图片按钮
    UITableGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIView alloc] init];
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            //自定义继续UIButton的UIImageButton 里面只是加了2个row和column属性
            UIImageButton *button = [UIImageButton buttonWithType:UIButtonTypeCustom];
            button.bounds = CGRectMake(0, 0, kImageWidth, kImageHeight);
            button.center = CGPointMake((1 + i) * 5 + kImageWidth *( 0.5 + i) , 5 + kImageHeight * 0.5);
            //button.column = i;
            [button setValue:[NSNumber numberWithInt:i] forKey:@"column"];
            [button addTarget:self action:@selector(imageItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:self.image forState:UIControlStateNormal];
            [cell addSubview:button];
            [array addObject:button];
        }
        [cell setValue:array forKey:@"buttons"];
    }
    
    //获取到里面的cell里面的3个图片按钮引用
    NSArray *imageButtons =cell.buttons;
    //设置UIImageButton里面的row属性
    [imageButtons setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"row"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kImageHeight + 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)imageItemClick:(UIImageButton *)button{
//    NSString *msg = [NSString stringWithFormat:@"第%i行 第%i列",button.row + 1, button.column + 1];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                    message:msg
//                                                   delegate:nil
//                                          cancelButtonTitle:@"好的，知道了"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
    UIImageView *image=[[UIImageView alloc]init];
    [image setImage:self.image];
    [SJAvatarBrowser showImage:image];
}

- (void)goPublished:(id)sender
{
    NSLog(@"发布形象");
}

#pragma mark 根据size截取图片中间矩形区域的图片 这里的size是正方形
- (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGSize imageSize = image.size;
    CGRect rect;
    //根据图片的大小计算出图片中间矩形区域的位置与大小
    if (imageSize.width > imageSize.height) {
        float leftMargin = (imageSize.width - imageSize.height) * 0.5;
        rect = CGRectMake(leftMargin, 0, imageSize.height, imageSize.height);
    }else{
        float topMargin = (imageSize.height - imageSize.width) * 0.5;
        rect = CGRectMake(0, topMargin, imageSize.width, imageSize.width);
    }
    
    CGImageRef imageRef = image.CGImage;
    //截取中间区域矩形图片
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(size);
    CGRect rectDraw = CGRectMake(0, 0, size.width, size.height);
    [tmp drawInRect:rectDraw];
    // 从当前context中创建一个改变大小后的图片
    tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return tmp;
}

@end