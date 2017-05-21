//
//  DKLoopCollectionView.h
//  图片轮播
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKLoopCollectionView : UICollectionView

- (instancetype)initWithUrls:(NSArray <NSURL *> *)urls didSelectedIndex:(void (^)(NSInteger index))selectedIndex;

@end
