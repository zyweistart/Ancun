//
//  InputAddressViewController.m
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "InputAddressViewController.h"

@interface InputAddressViewController ()

@end

@implementation InputAddressViewController{
    UITextField *inputAddress;
    UIButton *bCancel;
}

- (id)init
{
    self=[super init];
    if(self){
        UIView *inputView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CGWidth(320), 40)];
        inputAddress=[[UITextField alloc]initWithFrame:CGRectMake(CGWidth(0), 0, CGWidth(260), 40)];
        [inputAddress setPlaceholder:@"您所在的地址名称是..."];
        [inputAddress setTextColor:[UIColor whiteColor]];
        [inputAddress setBackgroundColor:[UIColor clearColor]];
        [inputAddress setDelegate:self];
        [inputAddress becomeFirstResponder];
        [inputAddress setKeyboardType:UIKeyboardTypeDefault];
        [inputAddress setClearButtonMode:UITextFieldViewModeWhileEditing];
        [inputView addSubview:inputAddress];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification
                                                   object:inputAddress];
        
        
        bCancel=[[UIButton alloc]initWithFrame:CGRectMake(CGWidth(260), 0, CGWidth(40), 40)];
        [bCancel setTitle:@"取消" forState:UIControlStateNormal];
        [bCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bCancel addTarget:self action:@selector(goCancel) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:bCancel];
        
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.titleView=inputView;
        
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    BMKPoiInfo *info=[self.dataItemArray objectAtIndex:[indexPath row]];
    [cell.textLabel setText:info.address];
    [cell.detailTextLabel setText:info.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo *info=[self.dataItemArray objectAtIndex:[indexPath row]];
    NSString *address=[BaiduMapUtils getAddress:info];
    NSLog(@"%@",address);
    [inputAddress resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldChanged
{
    if([@"" isEqualToString:[inputAddress text]]){
        [bCancel setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [bCancel setTitle:@"确认" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (void)goCancel
{
    NSLog(@"%@",[inputAddress text]);
    [inputAddress resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

@end