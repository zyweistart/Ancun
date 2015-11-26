//
//  BeinDangerTwoCarConfirmViewController.m
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerTwoCarConfirmViewController.h"

@implementation BeinDangerTwoCarConfirmViewController{
    CButtonAgreement *bAgreement;
    NSInteger value;
    CameraView *mCameraView;
}

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"责任认定"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    value=[[self.cData objectForKey:@"responsibility"]intValue]-1;
    [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    UIView *viewHead=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    XLLabel *lblHead=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Text:@"自己"];
    [lblHead setTextColor:BGCOLOR];
    [lblHead setFont:GLOBAL_FONTSIZE(15)];
    [viewHead addSubview:lblHead];
    [self.tableView setTableHeaderView:viewHead];
    UIView *viewFoot=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 410)];
    [self.tableView setTableFooterView:viewFoot];
    
    mCameraView=[[CameraView alloc]initWithFrame:CGRectMake1(45, 0, 225, 321)];
    [mCameraView.lblInfo setText:@"道路交通认定书"];
    [mCameraView.currentImageView setImage:[UIImage imageNamed:@"认定书"]];
    [mCameraView setControler:self];
    NSString *reportPic=[self.cData objectForKey:@"reportPic"];
    if(![reportPic isEmpty]){
        [mCameraView loadHttpImage:reportPic];
        [mCameraView setStatus:NO];
    }
    [viewFoot addSubview:mCameraView];
    
    bAgreement=[[CButtonAgreement alloc]initWithFrame:CGRectMake1(10, 321, 280, 40) Name:@"我已阅读并同意《车安存车辆线上定损协议》"];
    [viewFoot addSubview:bAgreement];
    
    XLButton *bButton=[[XLButton alloc]initWithFrame:CGRectMake1(10, 361, 300, 40) Name:@"提交" Type:3];
    [bButton addTarget:self action:@selector(goSubmit) forControlEvents:UIControlEventTouchUpInside];
    [viewFoot addSubview:bButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [cell.textLabel setText:@"责任认定"];
    if(value==0){
        [cell.detailTextLabel setText:@"全部责任"];
    }else if(value==1){
        [cell.detailTextLabel setText:@"无责"];
    }else if(value==2){
        [cell.detailTextLabel setText:@"同等责任"];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部责任",@"无责",@"同等责任",nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    value=buttonIndex;
    [self.tableView reloadData];
}

- (void)goSubmit
{
    if(bAgreement.isSelected){
        if([mCameraView.imageNetAddressUrl isEmpty]){
            [Common alert:@"请上传道路交通认定书"];
            return;
        }
        NSString *cid=[self.cData objectForKey:@"id"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"twoCarConfirm" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:cid forKey:@"id"];
        [params setObject:mCameraView.imageNetAddressUrl forKey:@"reportPic"];
        [params setObject:[NSString stringWithFormat:@"%ld",value+1] forKey:@"responsibility"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:self.view];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }else{
        [Common alert:@"请勾选定损协议"];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end