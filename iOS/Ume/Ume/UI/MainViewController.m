//
//  MainViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MainViewController.h"
#import "UYourDetailViewController.h"
#import "ContentCell.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIView *bgView;
}

- (id)init{
    self=[super init];
    if(self){
        self.title=@"懂你";
        self.isFirstRefresh=NO;
        //筛选
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setTitle:@"筛选" forState:UIControlStateNormal];
        [bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bScreening setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [bScreening addTarget:self action:@selector(goScreening) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
        
        bgView=[[UIView alloc]initWithFrame:self.view.bounds];
        [bgView setBackgroundColor:DEFAULTITLECOLORA(100,0.5)];
        [bgView setUserInteractionEnabled:YES];
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goScreening)]];
        [self.view addSubview:bgView];
        [bgView setHidden:YES];
        //筛选
        UIView *downRefresh=[[UIView alloc]initWithFrame:CGRectMake1(219, 1, 100, 120)];
        downRefresh.layer.borderWidth=1;
        downRefresh.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [downRefresh setBackgroundColor:[UIColor whiteColor]];
        [bgView addSubview:downRefresh];
        UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 100, 30)];
        [button1 setTitle:@"最新" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=1;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 30, 100, 30)];
        [button1 setTitle:@"最热" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=2;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 60, 100, 30)];
        [button1 setTitle:@"离我最近" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=3;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 90, 100, 30)];
        [button1 setTitle:@"只看异性" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=4;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        
    }
    return self;
}

- (void)loadHttp
{
    [super loadHttp];
}

- (void)goScreening
{
    [bgView setHidden:![bgView isHidden]];
}

- (void)hScreening:(UIButton*)sender
{
    [self goScreening];
    NSLog(@"筛选条件%ld",sender.tag);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(200);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:[[UYourDetailViewController alloc]initWithData:data] animated:YES];
}

@end