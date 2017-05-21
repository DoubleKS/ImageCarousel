//
//  ViewController.m
//  ImageCarousel
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "ViewController.h"
#import "DKLoopCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 加载数据
    [self loadData];
    
    // 2. 图片轮播器视图
    DKLoopCollectionView *loopView = [[DKLoopCollectionView alloc] initWithUrls:_urls didSelectedIndex:^(NSInteger index) {
        NSLog(@"%zd", index);
    }];
    
    loopView.frame = CGRectMake(0,0, 300, 300);
    loopView.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    [self.view addSubview:loopView];
}

- (void)loadData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%02zd.jpg", (i + 1)];
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        [array addObject:url];
    }
    _urls = array.copy;
}

@end
