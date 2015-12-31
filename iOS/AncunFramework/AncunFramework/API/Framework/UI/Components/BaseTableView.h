//
//  BaseTableView.h
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "HttpRequest.h"
#import "HttpDownload.h"

@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,HttpViewDelegate,HttpDownloadDelegate>

- (BaseTableViewCell*)getInstanceClass:(Class)classes Cell:(NSIndexPath*)indexPath;

@property (strong,nonatomic) Class classes;
@property (strong,nonatomic) HttpRequest *hRequest;
@property (strong,nonatomic) HttpDownload *hDownload;
@property (strong,nonatomic) NSMutableArray *cellDataArray;

@end
