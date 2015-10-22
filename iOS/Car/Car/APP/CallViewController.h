//
//  CallViewController.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface CallViewController : BaseTableViewController

@property (strong,nonatomic) NSMutableArray *dataKeys;
@property (strong,nonatomic) NSMutableDictionary *dataResults;

@property (strong,nonatomic) NSMutableArray *searchKeys;
@property (strong,nonatomic) NSMutableDictionary *searchResults;

@property (strong,nonatomic) UIView *message;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UITableView *tableViewData;

- (void)loadContact;

@end
