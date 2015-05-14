//
//  TabBarFrameViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "TabBarFrameViewController.h"
#import "TabBarView.h"
#import "MainViewController.h"
#import "MessageViewController.h"
#import "PublishedSpeechSoundViewController.h"
#import "DiscoverViewController.h"
#import "MyViewController.h"


#define SELECTED_VIEW_CONTROLLER_TAG 98456345

@interface TabBarFrameViewController ()

@end

@implementation TabBarFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat orginHeight = self.view.frame.size.height- CGHeight(60);
    _tabbar = [[TabBarView alloc]initWithFrame:CGRectMake(0,  orginHeight, CGWidth(320), CGHeight(60))];
    _tabbar.delegate = self;
    [self.view addSubview:_tabbar];
    _arrayViewcontrollers = [self getViewcontrollers];
    NSLog(@"%lf",self.view.bounds.size.height);
    [self touchBtnAtIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%lf",self.view.bounds.size.height);
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    UIViewController *viewController = [_arrayViewcontrollers objectAtIndex:index];
    if(index==2){
        [self presentViewController:viewController animated:YES completion:nil];
        return;
    }
    if(index==0){
        self.title=@"懂你";
    }else if(index==1){
        self.title=@"消息";
    }else if(index==3){
        self.title=@"发现";
    }
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = self.view.bounds;
    [viewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view insertSubview:viewController.view belowSubview:_tabbar];
}

- (NSArray *)getViewcontrollers
{
    //懂你
    UINavigationController *mainViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
    [[mainViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[mainViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    //消息
    UINavigationController *messageViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[MessageViewController alloc]init]];
    [[messageViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[messageViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    //发布
    UINavigationController *publishedSpeechSoundViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[PublishedSpeechSoundViewController alloc]init]];
    [[publishedSpeechSoundViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[publishedSpeechSoundViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    //发现
    UINavigationController *discoverViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[DiscoverViewController alloc]init]];
    [[discoverViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[discoverViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    //我的
    UINavigationController *myViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[MyViewController alloc]init]];
    [[myViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[myViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    
    NSArray *tabBarItems = [NSArray arrayWithObjects:[[MainViewController alloc]init],[[MessageViewController alloc]init],publishedSpeechSoundViewControllerNav,discoverViewControllerNav,myViewControllerNav,nil];
    return tabBarItems;
}

@end
