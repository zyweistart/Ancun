//
//  ACNavGesturePasswordViewController.m
//  Ancun
//
//  Created by Start on 4/14/14.
//
//

#import "ACNavGesturePasswordViewController.h"
#import "ACSetGesturePasswordViewController.h"
#import "ACGestureStatusCell.h"
#import "ACGestureStatus2Cell.h"

@interface ACNavGesturePasswordViewController ()

@end

@implementation ACNavGesturePasswordViewController{
    int cellCount;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"手势密码";
        NSString *gesturePwd=[Common getCache:DEFAULTDATA_GESTUREPWD];
        if([gesturePwd isNotEmpty]){
            cellCount=2;
        }else{
            cellCount=1;
        }
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    if([indexPath row]==0){
        static NSString *cellReuseIdentifier=@"ACGestureStatusCellIdentifier";
        ACGestureStatusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(!cell){
            cell = [[ACGestureStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        [cell setController:self];
        return cell;
    }else{
        static NSString *cellReuseIdentifier=@"ACGestureStatus2CellIdentifier";
        ACGestureStatus2Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(!cell){
            cell = [[ACGestureStatus2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row]==1){
        ACSetGesturePasswordViewController *setGesturePasswordViewController=[[ACSetGesturePasswordViewController alloc]init];
        [self.navigationController pushViewController:setGesturePasswordViewController animated:YES];
    }
}

- (void)onChange:(BOOL)value
{
    if(!value){
        [Common setCache:DEFAULTDATA_GESTUREPWD data:@""];
        cellCount=1;
    }else{
        cellCount=2;
    }
    [self.tableView reloadData];
}

@end
