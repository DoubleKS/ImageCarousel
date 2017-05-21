//
//  DKLoopCollectionView.m
//  图片轮播
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "DKLoopCollectionView.h"
#import "DKLoopCollectionViewCell.h"
#import "DKLoopViewLayout.h"

NSString *const LoopViewCellIdentifier = @"LoopViewCellIdentifier";

@interface DKLoopCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, copy) void (^selectedCallBack)(NSInteger index);
@end

@implementation DKLoopCollectionView {
    
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithUrls:(NSArray <NSURL *> *)urls didSelectedIndex:(void (^)(NSInteger))selectedIndex {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[DKLoopViewLayout new]];
    if (self) {
        _urls = urls;
        _selectedCallBack = selectedIndex;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[DKLoopCollectionViewCell class] forCellWithReuseIdentifier:LoopViewCellIdentifier];
        
        // 滚动到第 count 的位置
        if (_urls.count > 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
                
                [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            });
        }
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 如果只有一张图片，不滚动，否则显示 2 倍 的图像
    return _urls.count * (_urls.count == 1 ? 1 : 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DKLoopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LoopViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    cell.url = _urls[indexPath.item % _urls.count];
    
    return cell;
}

/// 滚动视图停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 判断是否是第0页和最后一页
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
        NSLog(@"%zd", offset);
        
        // 第 0 页，切换到 count 位置，最后一页，切换到 count - 1 的位置
        offset = _urls.count - (offset == 0 ? 0 : 1);
        
        // 调整 offset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedCallBack != nil) {
        _selectedCallBack(indexPath.item % _urls.count);
    }
}


@end
