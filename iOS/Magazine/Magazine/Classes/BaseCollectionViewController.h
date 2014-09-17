//
//  BaseCollectionViewController.h
//  Magazine
//
//  Created by Start on 5/26/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

@end
