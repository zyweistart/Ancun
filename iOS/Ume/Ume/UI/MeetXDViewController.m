//
//  MeetXDViewController.m
//  Ume
//
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MeetXDViewController.h"

@interface MeetXDViewController ()

@end

@implementation MeetXDViewController{
    NSMutableArray *mArray;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加5条数据" style:UIBarButtonItemStyleDone target:self action:@selector(reload)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mArray = [[NSMutableArray alloc]init];
    for(int i=0;i<5;i++){
        [mArray addObject:@"1.jpg"];
    }
    gridTableView = [[JHGridTableView alloc]initWithFrame:self.view.bounds];
    gridTableView.delegate = self;
    gridTableView.datasource = self;
    [self.view addSubview:gridTableView];
}

- (void)reload{
    for(int i=0;i<5;i++){
        [mArray addObject:@"1.jpg"];
    }
    [gridTableView reloadData];
}

#pragma mark - JHGridTableViewControllerDatasource

- (NSInteger)numberOfGrids{
    return mArray.count;
}

- (UIImage *)imageAtIndex:(NSInteger)index{
    if(index >= mArray.count){
        return nil;
    }else{
        return [UIImage imageNamed:[mArray objectAtIndex:index]];
    }
}

#pragma mark - JHGridTableViewControllerDelegate
- (void)gridTableView:(JHGridTableView *)gridTableView didSelectGridView:(JHGridView *)gridView{
    NSLog(@"点击的GridView:%@",gridView);
    NSLog(@"点击的Index:%ld",gridView.index);
}

@end
