//
//  MessageViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageZDWDViewController.h"
#import "MessageAWViewController.h"
#import "MessageZGViewController.h"
#import "MessagePLViewController.h"
#import "MessageDWXDViewController.h"
#import "MessageSXViewController.h"
#import "MessageListViewController.h"
#import "LoginViewController.h"
#import "MessageCell.h"

#define DISNAME @"DISNAME"
#define DISVALUE @"DISVALUE"

@interface MessageViewController ()

@end

@implementation MessageViewController{
    ImageViewHeader *mMessageHead;
    CLabel *lblMessageName,*lblMessageContent,*lblMessageTime;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"消息"];
        [self buildTableViewWithView:self.view];
        //
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 80, 30)];
        [bScreening setTitle:@"我关注的" forState:UIControlStateNormal];
        [bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bScreening setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [bScreening addTarget:self action:@selector(goScreening) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
        
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"最懂我的",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"对我心动的",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"@我的",DISNAME,@"2",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"赞过",DISNAME,@"13",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"评论",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"私信",DISNAME,@"0",DISVALUE, nil]];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [self.tableView setTableFooterView:bottomView];
        UIView *topLine=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 1)];
        [topLine setBackgroundColor:DEFAUL3COLOR];
        [bottomView addSubview:topLine];
        //头像
        mMessageHead=[[ImageViewHeader alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [mMessageHead setImage:[UIImage imageNamed:@"img_boy"]];
        [bottomView addSubview:mMessageHead];
        //姓名
        lblMessageName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 5, 80, 25) Text:@"小秘书"];
        [lblMessageName setFont:[UIFont systemFontOfSize:18]];
        [lblMessageName setTextColor:DEFAULTITLECOLORRGB(244,142,107)];
        [bottomView addSubview:lblMessageName];
        //内容
        lblMessageContent=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 230, 25) Text:@"感谢您使用懂我啡因jkd顺顺在在在在在在"];
        [lblMessageContent setTextColor:[UIColor blackColor]];
        [bottomView addSubview:lblMessageContent];
        //时间
        lblMessageTime=[[CLabel alloc]initWithFrame:CGRectMake1(220, 5, 80, 25) Text:@"今天:09:14"];
        [lblMessageTime setTextAlignment:NSTextAlignmentRight];
        [bottomView addSubview:lblMessageTime];
        UIView *bottomLine=[[UIView alloc]initWithFrame:CGRectMake1(0, 59, 320, 1)];
        [bottomLine setBackgroundColor:DEFAUL3COLOR];
        [bottomView addSubview:bottomLine];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    NSString *name=[data objectForKey:DISNAME];
    [cell.image setImage:[UIImage imageNamed:name]];
    [cell.lblTitle setText:name];
    NSString *value=[data objectForKey:DISVALUE];
    if(value!=nil&&![@""isEqualToString:value]&&![@"0"isEqualToString:value]){
        [cell.lblCount setHidden:NO];
        [cell.lblCount setText:value];
    }else{
        [cell.lblCount setHidden:YES];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    if(row==0){
        //最懂我的
        [self.navigationController pushViewController:[[MessageZDWDViewController alloc]init] animated:YES];
    }else if(row==1){
        //对我心动的
        [self.navigationController pushViewController:[[MessageDWXDViewController alloc]init] animated:YES];
    }else if(row==2){
        //@我的
        [self.navigationController pushViewController:[[MessageAWViewController alloc]init] animated:YES];
    }else if(row==3){
        //赞过
        [self.navigationController pushViewController:[[MessageZGViewController alloc]init] animated:YES];
    }else if(row==4){
        //评论
        [self.navigationController pushViewController:[[MessagePLViewController alloc]init] animated:YES];
    }else if(row==5){
        //私信
        [self.navigationController pushViewController:[[MessageSXViewController alloc]init] animated:YES];
    }else if(row==6){
        //官方消息
        [self.navigationController pushViewController:[[MessageListViewController alloc]init] animated:YES];
    }
}

@end