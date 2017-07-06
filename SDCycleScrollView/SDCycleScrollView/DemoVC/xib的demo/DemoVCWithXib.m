

#import "DemoVCWithXib.h"
#import "SDCycleScrollView.h"

@interface DemoVCWithXib () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@end

@implementation DemoVCWithXib

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    

    self.bannerView.imageURLStringsGroup = imagesURLStrings;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.bannerView.delegate = self;
    self.bannerView.titlesGroup = titles;
    self.bannerView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    
    
    SDCycleScrollView *banner2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 140) delegate:nil placeholderImage:nil];
    banner2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    banner2.imageURLStringsGroup = imagesURLStrings;
    banner2.titlesGroup = titles;
    [self.view addSubview:banner2];

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end
