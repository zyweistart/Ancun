//
//  DiscoverViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MeetXDViewController.h"
#import "NearbyViewController.h"
#import "DiscoverCell.h"

#define IMAGED @"IMAGED"
#define TITLED @"TITLED"
#define DESCRIPTIOND @"DESCRIPTIOND"
#define IMAGEURL @"img_url"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"发现"];
        [self buildTableViewWithView:self.view];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"img_boy",IMAGED,@"遇见心动",TITLED,@"我的心声你懂吗", DESCRIPTIOND,nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"img_boy",IMAGED,@"心情诊断室",TITLED,@"我的心声说给你听", DESCRIPTIOND,nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"img_boy",IMAGED,@"附近心情",TITLED,@"周围他/她们心情如何", DESCRIPTIOND,nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"img_boy",IMAGED,@"本周热门",TITLED,@"我关注的最新动态", DESCRIPTIOND,nil]];
        
        NSMutableArray *dataArray1 = [[NSMutableArray alloc]init];
        NSDictionary *bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic05.babytreeimg.com/foto3/photos/2014/0124/88/2/4170109a13aca59db86761_b.png", IMAGEURL, nil];
        [dataArray1 addObject:bannerDic1];
        bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic01.babytreeimg.com/foto3/photos/2014/0124/18/3/4170109a253ca5b0d88192_b.png", IMAGEURL, nil];
        [dataArray1 addObject:bannerDic1];
        bannerDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"http://pic05.babytreeimg.com/foto3/photos/2014/0124/88/2/4170109a13aca59db86761_b.png", IMAGEURL, nil];
        [dataArray1 addObject:bannerDic1];
        
        HMBannerView *bannerView = [[HMBannerView alloc] initWithFrame:CGRectMake1(0, 200, 320, 100) scrollDirection:ScrollDirectionLandscape images:dataArray1];
        [bannerView setRollingDelayTime:2.0];
        [bannerView setDelegate:self];
        [bannerView setSquare:0];
        [bannerView setPageControlStyle:PageStyle_Left];
//        [bannerView showClose:YES];
        [bannerView startDownloadImage];
        [self.tableView setTableHeaderView:bannerView];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[DiscoverCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    NSString *image=[data objectForKey:IMAGED];
    [cell.image setImage:[UIImage imageNamed:image]];
    NSString *title=[data objectForKey:TITLED];
    [cell.cTitle setText:title];
    [cell.cTitle setFont:[UIFont systemFontOfSize:18]];
    [cell.cTitle setTextColor:[UIColor blackColor]];
    NSString *description=[data objectForKey:DESCRIPTIOND];
    [cell.cDescription setText:description];
    [cell.cDescription setFont:[UIFont systemFontOfSize:14]];
    [cell.cDescription setTextColor:DEFAUL1COLOR];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==0){
        [self.navigationController pushViewController:[[MeetXDViewController alloc]init] animated:YES];
    }else if(row==2){
        [self.navigationController pushViewController:[[NearbyViewController alloc]init] animated:YES];
    }
}

#pragma mark HMBannerViewDelegate

- (void)imageCachedDidFinish:(HMBannerView *)bannerView
{
    if (bannerView == self.bannerView){
        if (self.bannerView.superview == nil){
            [self.view addSubview:self.bannerView];
        }
        [self.bannerView startRolling];
    } else {
        [self.view addSubview:bannerView];
        [bannerView startRolling];
    }
}

- (void)bannerView:(HMBannerView *)bannerView didSelectImageView:(NSInteger)index withData:(NSDictionary *)bannerData
{
    NSLog(@"%@",bannerData);
}

@end