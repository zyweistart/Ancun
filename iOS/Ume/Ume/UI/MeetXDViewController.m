//
//  MeetXDViewController.m
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MeetXDViewController.h"
#import "SJAvatarBrowser.h"
#import "UIImage+Utils.h"

#define kImageWidth  CGWidth(106) //UITableViewCell里面图片的宽度
#define kImageHeight  CGHeight(106) //UITableViewCell里面图片的高度

@interface MeetXDViewController ()

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MeetXDViewController

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"遇见心动"];
        //
        [self cNavigationRightItemType:3 Title:nil action:@selector(goBack:)];
        //
        [self cNavigationRightItemType:2 Title:@"发布形象" action:@selector(goPublished:)];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:_tableView];
        self.tableView.dataSource = self;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 140)];
        [self.tableView setTableFooterView:bottomView];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 20) Text:@"她会是你心动的那位吗？"];
        [lbl setTextColor: DEFAULTITLECOLORRGB(209, 65, 173)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 30, 300, 20) Text:@"点头像，唱首歌或说句话，去表达你遇见她的心情吧!"];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:lbl];
        UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake1(135, 70, 50, 50)];
        [icon setImage:[UIImage imageNamed:@"icon-yyy"]];
        [bottomView addSubview:icon];
        //底部
        CGFloat height=40;
        //摇一摇，换一批
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(height+54), CGWidth(320), CGHeight(height))];
        [button setTitle:@"摇一摇，换一批" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:DEFAULTITLECOLOR(50) forState:UIControlStateNormal];
        [button setBackgroundColor:COLOR2552160];
        [button addTarget:self action:@selector(changeHorse:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        
        [self getBannerImages];
    }
    return self;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kImageHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(kImageWidth*i+1*i, 0, kImageWidth, kImageHeight)];
        [image setUserInteractionEnabled:YES];
        NSString *url=[data objectForKey:@"url"];
        [self.hDownload AsynchronousDownloadWithUrl:url RequestCode:500 Object:image];
        [cell addSubview:image];
    }
    return cell;
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
            NSArray *array=[[response resultJSON]objectForKey:@"data"];
            self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
            
            [self.dataItemArray addObjectsFromArray:array];
            [self.dataItemArray addObjectsFromArray:array];
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