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
#import "NSTimer+DKTimer.h"
#define sectionNum (100000)
NSString *const LoopViewCellIdentifier = @"LoopViewCellIdentifier";

@interface DKLoopCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, copy) void (^selectedCallBack)(NSInteger index);
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,assign) BOOL isManuallyScroll;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,assign) NSUInteger currentSection;
@end

@implementation DKLoopCollectionView {
    
    NSArray <NSURL *> *_urls;
    NSTimeInterval _animationDuration;
    UIView *view;
}

#pragma mark - 设置动画  添加定时器
- (void)setAnimationDuration:(NSTimeInterval)newDuration {
    _animationDuration = newDuration;
    self.isManuallyScroll = NO;

    //定时器
    [self addTimer];
}

#pragma mark - 添加定时器
-(void)addTimer{
    
    if (([_urls count]>1)){
        if ([_timer isValid])[_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
                                                  target:self
                                                selector:@selector(nextPageView)
                                                userInfo:nil
                                                 repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

/// 移除定时器
-(void)removeTimer{
    
    self.isManuallyScroll = YES;
    [self.timer invalidate];
}


-(void)nextPageView{
    
    NSIndexPath *currentIndexPath = [self indexPathsForVisibleItems].lastObject;
    
    NSUInteger item = currentIndexPath.row + 1;
    self.currentSection = currentIndexPath.section;
    
    if (item == _urls.count) {
        item = 0;
        self.currentSection ++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:item inSection:self.currentSection];
    [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.pageControl.currentPage = item;
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
    
    self.pageControl.numberOfPages = _urls.count;
    // 如果只有一张图片，不滚动，否则显示 2 倍 的图像
    return _urls.count * (_urls.count == 1 ? 1 : sectionNum);
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
    
    NSUInteger page = (int)((scrollView.contentOffset.x) / self.frame.size.width) % _urls.count;
    self.pageControl.currentPage = page;
    // 判断是否是第0页和最后一页
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
        NSLog(@"%zd", offset);
        
        // 第 0 页，切换到 count 位置，最后一页，切换到 count - 1 的位置
        offset = _urls.count - (offset == 0 ? 0 : 1);
        
        // 调整 offset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.isManuallyScroll && _urls.count!= 0) {
        NSUInteger page = (int)((scrollView.contentOffset.x) / self.frame.size.width) % _urls.count;
        self.pageControl.currentPage = page;
    }
}

#pragma mark - 手动画的时候移除定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark - 减速的时候就添加定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedCallBack != nil) {
        _selectedCallBack(indexPath.item % _urls.count);
    }
}

-(UIPageControl *)pageControl{
    
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame: CGRectMake(0, 0, self.frame.size.width / 2, 30)];
        _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20);
    }
    return _pageControl;
}

@end
