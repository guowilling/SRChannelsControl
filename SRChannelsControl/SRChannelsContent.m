//
//  SRChannelsContent.m
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SRChannelsContent.h"

static NSString * const kContentCellID = @"contentCellID";

@interface SRChannelsContent () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *childVCs;

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, assign) CGFloat startOffsetX;

@property (nonatomic, assign) BOOL disableScroll;

@property (nonatomic, weak) UICollectionView *contentCollectionView;

@end

@implementation SRChannelsContent

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC {
    
    if (self = [super initWithFrame:frame]) {
        _childVCs = childVCs;
        _parentVC = parentVC;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    for (UIViewController *vc in self.childVCs) {
        [self.parentVC addChildViewController:vc];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.scrollsToTop = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    [self addSubview:collectionView];
    _contentCollectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIViewController *vc = self.childVCs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.disableScroll = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int floorIndex = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (floorIndex < 0 || floorIndex > self.childVCs.count - 1) {
        return;
    }
    CGFloat progress = scrollView.contentOffset.x / scrollView.frame.size.width - floorIndex;
    int fromIndex = 0;
    int toIndex = 0;
    if (scrollView.contentOffset.x > self.startOffsetX) {
        fromIndex = floorIndex;
        toIndex = (int)MIN(self.childVCs.count - 1, fromIndex + 1);
        if (fromIndex == toIndex && toIndex == self.childVCs.count - 1) {
            fromIndex = (int)self.childVCs.count - 2;
            progress = 1.0;
        }
    } else {
        toIndex = floorIndex;
        fromIndex = (int)MIN(self.childVCs.count - 1, toIndex + 1);
        progress = 1.0 - progress;
    }
    
    if ([self.delegate respondsToSelector:@selector(channelsContent:scrollFromIndex:toIndex:progress:)]) {
        [self.delegate channelsContent:self scrollFromIndex:fromIndex toIndex:toIndex progress:progress];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (decelerate) {
        return;
    }
    [self collectionViewDidEndScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self collectionViewDidEndScroll];
}

- (void)collectionViewDidEndScroll {
    
    NSInteger endAtIndex = (_contentCollectionView.contentOffset.x / _contentCollectionView.bounds.size.width);
    if ([self.delegate respondsToSelector:@selector(channelsContent:didEndScrollAtIndex:)]) {
        [self.delegate channelsContent:self didEndScrollAtIndex:endAtIndex];
    }
}

#pragma mark - Public Methods

- (void)didSelectIndex:(NSInteger)index {
    
    self.disableScroll = true;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

@end
