//
//  TYSDWebImageViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/18.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYSDWebImageViewController.h"
//#import "UIImageView+WebCache.h"
@interface TYSDWebImageViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TYSDWebImageViewController

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, 300)];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
    [self addRequestLoad];
}

- (void)addRequestLoad{
    NSString *urlStr = @"http://10.10.60.114:8080/name/8.png";
    NSURL * url = [NSURL URLWithString:urlStr];
    [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"加载完成");
    }];
    
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    NSLog(@"这个缓存有多大:%f MB",MBCache);
    //异步清除图片缓存 （磁盘中的）
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[SDImageCache sharedImageCache] clearDisk];
//    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
