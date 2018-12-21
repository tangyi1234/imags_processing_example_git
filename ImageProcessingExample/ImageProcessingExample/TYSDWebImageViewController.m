//
//  TYSDWebImageViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/18.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYSDWebImageViewController.h"
#import "TYSDWebImageTableViewCell.h"
//#import "UIImageView+WebCache.h"
@interface TYSDWebImageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *mutableArr;
@end

@implementation TYSDWebImageViewController

- (NSMutableArray *)mutableArr{
    if (!_mutableArr) {
        _mutableArr = [NSMutableArray array];
        [self addArrValue:_mutableArr];
    }
    return _mutableArr;
}

- (void)addArrValue:(NSMutableArray *)arr{
    for (int i = 0; i < 103; i++) {
        [arr addObject:[self andPickStr:i]];
    }
}

- (NSString *)andPickStr:(int)i{
    return [NSString stringWithFormat:@"http://10.10.60.114:8080/name/%d.png",i];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, 300)];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.imageView];
//    [self addRequestLoad];
    [self initTableView];
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

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TYSDWebImageTableViewCell *cell = [TYSDWebImageTableViewCell addSDWebImageTableViewCell:tableView];
    [cell addImageUrl:self.mutableArr[[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
