//
//  DJMenueBarShowDetailCVC.m
//  DJFMPlayer
//
//  Created by dingjianjaja on 2019/1/22.
//  Copyright © 2019 dingjianjaja. All rights reserved.
//

#import "DJMenueBarShowDetailCVC.h"
#import "DJMenueCell.h"
#import "UIView+DJLayout.h"

#define kRowCount 3
#define kMargin 6
#define kCellH 30

@interface DJMenueBarShowDetailCVC ()

@end

@implementation DJMenueBarShowDetailCVC

static NSString * const reuseIdentifier = @"menue";

- (instancetype)init{
    return [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenWidth - kMargin * (kRowCount + 1)) / kRowCount;
    CGFloat height = kCellH;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = kMargin;
    flowLayout.minimumInteritemSpacing = kMargin;
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"DJMenueCell" bundle:currentBundle];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - setter
- (void)setItems:(NSArray<id<DJSegmentModelProtocol>> *)items{
    _items = items;
    NSInteger rows = (_items.count + (kRowCount - 1)) / kRowCount;
    CGFloat height = rows * (kCellH + kMargin);
    self.collectionView.height = height;
    self.expectedHeight = height;
    [self.collectionView reloadData];
}



#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DJMenueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.menueLabel.text = (NSString *)self.items[indexPath.row];
    
    return cell;
}


@end
