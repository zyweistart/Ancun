//
//  MyViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MyViewController.h"

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
        
        //设置
        UIButton *btnSetting = [[UIButton alloc]initWithFrame:CGRectMake1(270, 20, 40, 40)];
        [btnSetting setImage:[UIImage imageNamed:@"setting"]forState:UIControlStateNormal];
        [self.expandZoomImageView addSubview:btnSetting];
        
        personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        //头像
        bHead=[[UIView alloc]initWithFrame:CGRectMake1(120, 0, 80, 80)];
        [personalFrame addSubview:bHead];
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 60, 60)];
        iUserNameImage.layer.cornerRadius=30;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setUserInteractionEnabled:YES];
        [bHead addSubview:iUserNameImage];
        lblUserName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 60,80,20)];
        [lblUserName setFont:[UIFont systemFontOfSize:14]];
        [lblUserName setTextColor:[UIColor whiteColor]];
        [lblUserName setTextAlignment:NSTextAlignmentCenter];
        [lblUserName setUserInteractionEnabled:YES];
        [bHead addSubview:lblUserName];
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(40, 140, 240, 20)];
        [personalFrame addSubview:bottomFrame];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(0, 0, 79, 20) Text:@"5关注"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomFrame addSubview:lbl];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 20)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line1];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(80, 0, 79, 20) Text:@"25粉丝"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomFrame addSubview:lbl];
        //竖线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 20)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line2];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(160, 0, 80, 20) Text:@"63心动"];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomFrame addSubview:lbl];
        
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

- (void)showUser
{
    [bHead setHidden:NO];
    [iUserNameImage setImage:[UIImage imageNamed:@"camera_button_take"]];
    [lblUserName setText:@"辰羽"];
}

@end
