#import "BaseCollectionViewController.h"

@implementation BaseCollectionViewController

- (id)init
{
    self=[super init];
    if(self){
        if(self.collectionView==nil){
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
            [self.collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            self.collectionView.dataSource=self;
            self.collectionView.delegate=self;
            //始终允许滚动否则数据如果不够一行则无法进行下拉刷新
            self.collectionView.alwaysBounceVertical = YES;
            [self.collectionView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:self.collectionView];
            self.dataItemArray=[[NSMutableArray alloc]init];
            //子类中必须加入该代码行
//        [self.collectionView registerClass:[ACShelfCell class] forCellWithReuseIdentifier:CELLIDENTIFIER];
        }
    }
    return self;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataItemArray count];
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"子类必须覆盖该方法，该语句不得出现在控制台上");
    return nil;
}

//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

@end
