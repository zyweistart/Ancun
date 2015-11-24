//
//  MyInformationViewController.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "MyInformationViewController.h"
#import "ModifySingleDataViewController.h"
#import "HeadCell.h"

@interface MyInformationViewController ()

@end

@implementation MyInformationViewController{
    XLCamera *camera;
    UIImageView *ivHead;
    NSArray *nameLists;
    UIImage *currentEditedImage;
    CameraView *cameraView4;
}

- (id)init
{
    self=[super init];
    if(self){
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        [self setTitle:@"我的资料"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self reloadTableData];
        nameLists=@[@"",@"真实姓名",@"身份证号",@"手机号"];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 265)];
        [self.tableView setTableFooterView:contentView];
        [contentView setBackgroundColor:[UIColor whiteColor]];
        UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [headTitle setBackgroundColor:BCOLOR(244)];
        XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
        [lblTitle setText:@"驾驶证信息"];
        [lblTitle setTextColor:BGCOLOR];
        [lblTitle setFont:GLOBAL_FONTSIZE(15)];
        [headTitle addSubview:lblTitle];
        [contentView addSubview:headTitle];
        cameraView4=[[CameraView alloc]initWithFrame:CGRectMake1(0, 40, 320, 200)];
        [cameraView4.currentImageView setImage:[UIImage imageNamed:@"驾照底"]];
        [cameraView4 setDelegate:self];
        [cameraView4 setControler:self];
        [contentView addSubview:cameraView4];
        [self.hDownload AsynchronousDownloadWithUrl:[[User getInstance]driverLicense] RequestCode:500 Object:cameraView4.currentImageView];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==0){
        static NSString *cellIdentifier = @"HEADCELL";
        HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[HeadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        [self.hDownload AsynchronousDownloadWithUrl:[[User getInstance]headPic] RequestCode:500 Object:cell.ivHeader];
        [[cell textLabel]setText:[self.dataItemArray objectAtIndex:row]];
        ivHead=cell.ivHeader;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *disName=[nameLists objectAtIndex:row];
        [[cell textLabel]setText:disName];
        NSString *value=[data objectForKey:[NSString stringWithFormat:@"%ld",row]];
        if([value isEmpty]){
            value=@"未填写";
        }
        [[cell detailTextLabel]setText:value];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==0){
        camera=[[XLCamera alloc]initWithController:self];
        [camera setCropperDelegate:self];
        [camera open];
    }else if(row==1||row==2){
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        NSString *value=[data objectForKey:[NSString stringWithFormat:@"%ld",row]];
        ModifySingleDataViewController *mModifySingleDataViewController=[[ModifySingleDataViewController alloc]initWithType:row WithValue:value];
        [mModifySingleDataViewController setRDelegate:self];
        [self.navigationController pushViewController:mModifySingleDataViewController animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)reloadTableData
{
    [self.dataItemArray removeAllObjects];
    NSString *name=[[User getInstance]name];
    if([Common isNull:name]||[name isEmpty]){
        name=@"";
    }
    NSString *identityNum=[[User getInstance]identityNum];
    if([Common isNull:identityNum]||[identityNum isEmpty]){
        identityNum=@"";
    }
    NSString *phone=[[User getInstance]phone];
    if([Common isNull:phone]||[phone isEmpty]){
        phone=@"";
    }
    [self.dataItemArray addObjectsFromArray:@[@"头像",@{@"1":name},@{@"2":identityNum},@{@"3":phone}]];
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSDictionary *)result
{
    NSString *value=[result objectForKey:@"value"];
    if(requestCode==1){
        [[User getInstance]setName:value];
    }else if(requestCode==2){
        [[User getInstance]setIdentityNum:value];
    }else if(requestCode==3){
        [[User getInstance]setPhone:value];
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"upUserInfo" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setJsonParams:@{@"uid":[User getInstance].uid,@"name":[User getInstance].name,@"identityNum":[User getInstance].identityNum}];
    [self.hRequest setView:self.view];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    currentEditedImage=editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"upLoadPic" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:@"1" forKey:@"type"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
        [self.hRequest setPostParams:@{@"uploadfile":UIImagePNGRepresentation(cameraView4.currentImage)}];
        [self.hRequest setView:self.view];
        [self.hRequest setDelegate:self];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender
{
    if(![path isEmpty]){
        UIImageView *imageView=(UIImageView*)sender;
        if(imageView){
            path=[NSString stringWithFormat:@"%@thum",path];
            UIImage *image=[UIImage imageWithContentsOfFile:path];
            if(image){
                [imageView setImage:image];
                [cameraView4 setCurrentImage:image];
            }
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [self reloadTableData];
            [self.tableView reloadData];
        }else if(reqCode==501){
            [[User getInstance]setHeadPic:[[response resultJSON] objectForKey:@"img"]];
            [ivHead setImage:currentEditedImage];
        }else if(reqCode==502){
            [[User getInstance]setDriverLicense:[[response resultJSON]objectForKey:@"img"]];
            [self.hDownload AsynchronousDownloadWithUrl:[[User getInstance]driverLicense] RequestCode:500 Object:cameraView4.currentImageView];
        }
    }
}

- (void)CameraSuccess:(CameraView *)camera1
{
    [[User getInstance]setDriverLicense:camera1.imageNetAddressUrl];
    [self.hDownload AsynchronousDownloadWithUrl:[[User getInstance]driverLicense] RequestCode:500 Object:cameraView4.currentImageView];
}

@end