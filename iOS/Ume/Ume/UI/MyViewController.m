//
//  MyViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MyViewController.h"
#import "MyPublishListViewController.h"
#import "MyHeartbeatViewController.h"
#import "MyFollowViewController.h"
#import "MyFansViewcontroller.h"
#import "MyImageViewController.h"
#import "SettingViewController.h"
#import "MoodTrackViewcontroller.h"
#import "MyFlowersViewController.h"
#import "UIButton+TitleImage.h"
#import "CLabel.h"

#define LOGINREGISTERBGCOLOR [UIColor colorWithRed:(58/255.0) green:(117/255.0) blue:(207/255.0) alpha:0.5]
#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

static CGFloat kImageOriginHight = 220.f;

@interface MyViewController ()

@end

@implementation MyViewController{
    UIView *topFrame;
    UIView *personalFrame;
    UIView *bHead;
    UILabel *lblUserName;
    UIImageView *iUserNameImage;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"心情轨迹",@"我发布的",@"设置", nil]];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        
        self.expandZoomImageView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, kImageOriginHight)];
        self.expandZoomImageView.userInteractionEnabled=YES;
        [self.expandZoomImageView setImage:[UIImage imageNamed:@"personalbg"]];
        self.tableView.contentInset = UIEdgeInsetsMake(CGHeight(kImageOriginHight), 0, 0, 0);
        [self.tableView addSubview:self.expandZoomImageView];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 10, 60, 30) Text:@"当前心情"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [self.expandZoomImageView addSubview:lbl];
        
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(210, 10, 100, 30)Text:@"杭州市 摩羯座"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.expandZoomImageView addSubview:lbl];
        
        personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        //头像
        bHead=[[UIView alloc]initWithFrame:CGRectMake1(120, 0, 80, 90)];
        [personalFrame addSubview:bHead];
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 60, 60)];
        iUserNameImage.layer.cornerRadius=30;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setUserInteractionEnabled:YES];
        [bHead addSubview:iUserNameImage];
        lblUserName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 70,80,20)];
        [lblUserName setFont:[UIFont systemFontOfSize:14]];
        [lblUserName setTextColor:[UIColor whiteColor]];
        [lblUserName setTextAlignment:NSTextAlignmentCenter];
        [lblUserName setUserInteractionEnabled:YES];
        [bHead addSubview:lblUserName];
        //鲜花
        UIButton *bFlowers=[[UIButton alloc]initWithFrame:CGRectMake1(240, 15, 80, 30)];
        [bFlowers setTitle:@"135朵鲜花" forState:UIControlStateNormal];
        [bFlowers setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bFlowers setBackgroundColor:[UIColor whiteColor]];
        [bFlowers.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bFlowers addTarget:self action:@selector(goFlowers:) forControlEvents:UIControlEventTouchUpInside];
        [personalFrame addSubview:bFlowers];
        
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(40, 140, 240, 20)];
        [personalFrame addSubview:bottomFrame];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 20)];
        [button setTitle:@"5关注" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goFollow:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 20)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line1];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 20)];
        [button setTitle:@"25粉丝" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goFans:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
        //竖线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 20)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line2];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 20)];
        [button setTitle:@"63心动" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goMood:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:button];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.expandZoomImageView.frame = CGRectMake(0, -CGHeight(kImageOriginHight), self.tableView.frame.size.width, CGHeight(kImageOriginHight));
    [self showUser];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -CGHeight(kImageOriginHight)) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
        [personalFrame setFrame:CGRectMake(0, f.size.height-CGHeight(170), CGWidth(320), CGHeight(160))];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    cell.textLabel.text = content;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    if(row==0){
        //心情轨迹
        [self.navigationController pushViewController:[[MoodTrackViewController alloc]init] animated:YES];
    }else if(row==1){
        //我发布的
        [self.navigationController pushViewController:[[MyPublishListViewController alloc]init] animated:YES];
    }else if(row==2){
        //设置
        [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
    }
}
//关注
- (void)goFollow:(id)sender
{
    [self.navigationController pushViewController:[[MyFollowViewController alloc]init] animated:YES];
}
//粉丝
- (void)goFans:(id)sender
{
    [self.navigationController pushViewController:[[MyFansViewController alloc]init] animated:YES];
}
//心动
- (void)goMood:(id)sender
{
    [self.navigationController pushViewController:[[MoodTrackViewController alloc]init] animated:YES];
}
//鲜花
- (void)goFlowers:(id)sender
{
    [self.navigationController pushViewController:[[MyFlowersViewController alloc]init] animated:YES];
}

- (void)showUser
{
    [bHead setHidden:NO];
    [iUserNameImage setImage:[UIImage imageNamed:@"camera_button_take"]];
    [lblUserName setText:@"辰羽"];
}

@end