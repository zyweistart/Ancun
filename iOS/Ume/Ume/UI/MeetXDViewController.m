//
//  MeetXDViewController.m
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MeetXDViewController.h"
#import "UITableGridViewCell.h"
#import "SJAvatarBrowser.h"
#import "UIImage+Utils.h"

#define kImageWidth  CGWidth(100) //UITableViewCell里面图片的宽度
#define kImageHeight  CGHeight(150) //UITableViewCell里面图片的高度
@interface MeetXDViewController ()

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MeetXDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self cTitle:@"遇见心动"];
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
    
    self.image = [[UIImage imageNamed:@"personalbg"] cutCenterImageSize:CGSizeMake(kImageWidth, kImageHeight)];
    
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
    [button addTarget:self action:@selector(changeHorse:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    
    [self getBannerImages];
}

//计算总的行数
- (NSInteger)getTotalRow
{
    NSInteger count=[self.dataItemArray count];
    return count/3+(count%3>0?1:0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getTotalRow];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableGridViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableGridViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSInteger row=indexPath.row;
    cell.selectedBackgroundView = [[UIView alloc] init];
    int c=3;
    //判断是否是最后一行
    if((row+1)==[self getTotalRow]){
        int tmp=[self.dataItemArray count]%3;
        if(tmp>0){
            c=tmp;
        }
    }
    for (int i=0; i<c; i++) {
        NSInteger index=row*3+i;
        NSDictionary *data=[self.dataItemArray objectAtIndex:index];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kImageWidth, kImageHeight)];
        [image setCenter:CGPointMake((1 + i) * 5 + kImageWidth *( 0.5 + i) , 5 + kImageHeight * 0.5)];
        [image setBackgroundColor:[UIColor redColor]];
        [image setUserInteractionEnabled:YES];
        NSString *url=[data objectForKey:@"url"];
        [self.hDownload AsynchronousDownloadWithUrl:url RequestCode:500 Object:image];
        [cell addSubview:image];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kImageHeight + 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //不让tableviewcell有选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)goPublished:(id)sender
{
    NSLog(@"发布形象");
}

- (void)changeHorse:(id)sender
{
    [self getBannerImages];
}

- (void)getBannerImages
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getMetBeckoning" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:nil requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            self.dataItemArray=[[NSMutableArray alloc]initWithArray:[[response resultJSON]objectForKey:@"data"]];
            [self.tableView reloadData];
        }
    }
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(reqCode==500){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            UIImage *image=[[UIImage alloc] initWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
                //添加放大事件
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomImage:)]];
            }
        }
    }
}

//放大
- (void)zoomImage:(UITapGestureRecognizer*)sender
{
    UIImageView *imageV=(UIImageView*)[sender view];
    if(imageV.image){
        [SJAvatarBrowser showImage:imageV];
    }
}

@end