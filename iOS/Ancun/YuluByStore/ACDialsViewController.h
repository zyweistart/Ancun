//
//  ACDialsViewController.h
//  Ancun
//
//  Created by Start on 3/31/14.
//
//

#import <UIKit/UIKit.h>

@interface ACDialsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate, UISearchBarDelegate,ABNewPersonViewControllerDelegate,UIActionSheetDelegate,HttpViewDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@property (strong,nonatomic) NSMutableArray *dataKeys;
@property (strong,nonatomic) NSMutableDictionary *dataResults;

@property (strong,nonatomic) NSMutableArray *searchKeys;
@property (strong,nonatomic) NSMutableDictionary *searchResults;

@property (strong,nonatomic) UIView *message;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UITableView *tableViewData;

- (void)loadContact;

@end

