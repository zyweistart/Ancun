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
    UIButton *mButton1,*mButton2,*mButton3,*mButton4;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"懂你"];
        self.isFirstRefresh=NO;
        //筛选
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setTitle:@"筛选" forState:UIControlStateNormal];
        [bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bScreening setTitleColor:COLOR2552160 forState:UIControlStateNormal];
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
        
        mButton1=[self createButton:CGRectMake1(0, 0, 100, 30) Title:@"最新" Tag:1];
        [downRefresh addSubview:mButton1];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(5, 30, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton2=[self createButton:CGRectMake1(0, 30, 100, 30) Title:@"最热" Tag:2];
        [downRefresh addSubview:mButton2];
        line=[[UIView alloc]initWithFrame:CGRectMake1(5, 60, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton3=[self createButton:CGRectMake1(0, 60, 100, 30) Title:@"离我最近" Tag:3];
        [downRefresh addSubview:mButton3];
        line=[[UIView alloc]initWithFrame:CGRectMake1(5, 90, 90, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(200)];
        [downRefresh addSubview:line];
        mButton4=[self createButton:CGRectMake1(0, 90, 100, 30)Title:@"只看异性" Tag:4];
        [downRefresh addSubview:mButton4];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"type"];//筛选1最新 2最热 3离我最近 4只看美女
    [params setObject:@"getPublish" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:nil requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response responseString]);
    
    
    
    if([response successFlag]){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"Data"];
        if(rData){
            //当前页
            self.currentPage=[[NSString stringWithFormat:@"%@",[rData objectForKey:@"PageIndex"]] intValue];
            //获取数据列表
            NSDictionary *tabData=[rData objectForKey:@"Tab"];
            if(tabData){
                NSMutableArray *nsArr=[[NSMutableArray alloc]init];
                for(id data in tabData){
                    [nsArr addObject:data];
                }
                if([self currentPage]==1){
                    [[self dataItemArray] removeAllObjects];
                }
                [[self dataItemArray] addObjectsFromArray:nsArr];
            }
        }
    }
    [self loadDone];
}

- (void)goScreening
{
    [bgView setHidden:![bgView isHidden]];
}

- (void)hScreening:(UIButton*)sender
{
    [mButton1 setSelected:NO];
    [mButton2 setSelected:NO];
    [mButton3 setSelected:NO];
    [mButton4 setSelected:NO];
    [self goScreening];
    [sender setSelected:YES];
    NSLog(@"筛选条件%ld",sender.tag);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(205);
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

- (UIButton*)createButton:(CGRect)rect Title:(NSString *)title Tag:(NSInteger)tag
{
    UIButton *button1=[[UIButton alloc]initWithFrame:rect];
    [button1 setTitle:title forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button1 setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
    button1.tag=4;
    [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"icon-select"] forState:UIControlStateSelected];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -button1.imageView.bounds.size.width, 0, button1.imageView.bounds.size.width)];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(0, button1.titleLabel.bounds.size.width, 0, -button1.titleLabel.bounds.size.width-CGWidth(15))];
    return button1;
}

@end