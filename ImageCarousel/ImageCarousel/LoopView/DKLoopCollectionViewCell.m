//
//  DKLoopCollectionViewCell.m
//  图片轮播
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "DKLoopCollectionViewCell.h"

@implementation DKLoopCollectionViewCell {
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    _imageView.image = [UIImage imageWithData:data];
}


@end
