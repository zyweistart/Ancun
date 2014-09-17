#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@class ACRechargeNav;
@interface ACRechargeViewController :BaseRefreshTableViewController<UIScrollViewDelegate,UIActionSheetDelegate>{
    
    HttpRequest *_loadHttp;
    
    int currentTab;
    
    ACRechargeNav *_rechargeNav;
    
    UIButton *_leftTopTab;
    NSInteger _leftCurrentPage;
	BOOL _leftReloading;
    BOOL _leftLoadOver;
    NSMutableArray *_leftDataItemArray;
    
    UIButton *_centerTopTab;
    NSInteger _centerCurrentPage;
	BOOL _centerReloading;
    BOOL _centerLoadOver;
    NSMutableArray *_centerDataItemArray;
    
    UIButton *_rightTopTab;
    NSInteger _rightCurrentPage;
	BOOL _rightReloading;
    BOOL _rightLoadOver;
    NSMutableArray *_rightDataItemArray;
    
    UILabel *_lblSlid;
    
}

@end

