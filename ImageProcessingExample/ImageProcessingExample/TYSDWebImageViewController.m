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
@property (nonatomic, strong) NSMutableDictionary *muDic;     //旧数据
@property (nonatomic, strong) NSMutableDictionary *newMuDic;  //新数据
@property (nonatomic, strong) NSMutableDictionary *muUrl;     //用于储存url(用于判断是否有这url)
@property (nonatomic, strong) NSMutableArray *cacheMuArr;     //储存储存在cache中的图片的key
@property (nonatomic, assign) int imgCount;
@property (nonatomic, strong, readonly, nullable) SDImageCache *cacge;
@property (nonatomic, strong) NSMutableArray *muArr;
@end

@implementation TYSDWebImageViewController

- (NSMutableArray *)cacheMuArr{
    if (!_cacheMuArr) {
        _cacheMuArr = [NSMutableArray array];
    }
    return _cacheMuArr;
}

- (NSMutableDictionary *)muDic{
    if (!_muDic) {
        _muDic = [[NSMutableDictionary alloc] init];
    }
    return _muDic;
}

- (NSMutableDictionary *)newMuDic{
    if (!_newMuDic) {
        _newMuDic = [[NSMutableDictionary alloc] init];
    }
    return _newMuDic;
}

- (NSMutableDictionary *)muUrl{
    if (!_muUrl) {
        _muUrl = [[NSMutableDictionary alloc] init];
    }
    return _muUrl;
}

- (NSMutableArray *)mutableArr{
    if (!_mutableArr) {
        _mutableArr = [NSMutableArray array];
        [self addArrValue:_mutableArr];
    }
    return _mutableArr;
}

- (NSMutableArray *)muArr{
    if (!_muArr) {
        _muArr = [NSMutableArray array];
        [self addArrValue:_mutableArr];
    }
    return _muArr;
}

- (void)addArrValue:(NSMutableArray *)arr{
    for (int i = 0; i < 152; i++) {
        if (i == 151) {
            [arr addObject:[self imageJpg]];
        }else{
            [arr addObject:[self andPickStr:i]];
        }
    }
}

- (NSString *)andPickStr:(int)i{
    return [NSString stringWithFormat:@"http://10.10.60.114:8080/name/%d.png",i];
}

- (NSString *)imageJpg{
    return [NSString stringWithFormat:@"http://10.10.60.114:8080/name/hhhh.jpg"];
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
    __weak typeof(self) weakSelf = self;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _cacge = [SDImageCache sharedImageCache];
//    [_cacge setMaxMemoryCost:10000000];
    [_cacge setAgent];
    _cacge.imageCleanDataBlock = ^{//内存
        [weakSelf deleteImageArr];
    };
}

- (void)deleteImageArr{
    int i = 0;
    while (i < 20 && i < self.cacheMuArr.count) {
        NSString *imgKey = [NSString stringWithFormat:@"%@",self.cacheMuArr[i]];
        if (imgKey) {
            NSLog(@"是否有数据:%@",imgKey);

            [_cacge removeCacheObjectForKey:imgKey];
            [self.cacheMuArr removeObjectAtIndex:i];
            i++;
        }
    }
    [_cacge operationalImageData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    TYSDWebImageTableViewCell *cell = [TYSDWebImageTableViewCell addSDWebImageTableViewCell:tableView];
    [cell addImageUrl:self.mutableArr[[indexPath row]]];
    cell.storageBlock = ^(NSString *urlStr) {
//        [weakSelf storeAddress:urlStr];
//        [weakSelf addArr];
        [weakSelf addCacheImage:urlStr];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 80) {
//        [self deleteImageArr];
    }
    return 200;
}

- (void)addCacheImage:(NSString *)str{
    if (![self.cacheMuArr containsObject:str] && str) {
        [self.cacheMuArr addObject:str];
    }
}

- (void)addArr{
    [self.muArr removeObjectAtIndex:1];
    NSLog(@"后的数据是什么:%@",_muArr);
    NSString *str = [NSString stringWithFormat:@"%lu",(self.muArr.count + 1)];
    [self.muArr addObject:str];
    NSLog(@"添加数据:%@",_muArr);
}

- (void)storeAddress:(NSString *)str{
    NSLog(@"当前的图片:%@ cache的数据是多少:%lu",str,(unsigned long)[_cacge maxMemoryCost]);
    return;
//    NSLog(@"请求成功的图片名称:%@",str);
//    NSLog(@"这个key值是什么:%@",[self.muDic valueForKey:str]);
    NSLog(@"能储存最多多少数据:%lu",(unsigned long)_cacge.maxMemoryCost);
    if (![self.muUrl valueForKey:str]) {
        _imgCount = _imgCount + 1;
        NSString *packedStr = [NSString stringWithFormat:@"%d",_imgCount];
//        NSLog(@"这里的value值是什么:%@",packedStr);
        [self.muUrl setObject:packedStr forKey:str];
        [self.muDic setObject:str forKey:packedStr];
        NSLog(@"字典中有多少数据:%@",self.muDic[str]);
        if (self.muDic.count > 5) {
            [self deleteData:1];
        }
        
    }
}

/**
 a:为删除前面第几位
 */
- (void)deleteData:(int)a{
    int i = 1;
    while (i < a + 1) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        NSString *valueStr = self.muDic[str];
        NSLog(@"删除的是那个参数:%@",str);
        [self.muDic removeObjectForKey:str];
        [self.muUrl removeObjectForKey:valueStr];
        i ++;
    }
    [self reorderData:a];
}

- (void)reorderData:(int)a{
    int i = a + 1;//从第几位数开始查询数据
    int s = 0;//重新排序的数据
    while (i < self.muDic.count) {//从第几位开始(将所有的数据从新进行编排)
        s++;
        NSString *nameStr = [NSString stringWithFormat:@"%d",i];
        NSString *valueStr =[NSString stringWithFormat:@"%@",[self.muDic valueForKey:nameStr]];
        NSString *key = [NSString stringWithFormat:@"%d",s];
        [self.newMuDic setObject:valueStr forKey:key];//存入新值(将剩余的旧值取出存在新的容器中)
        [self.muDic removeObjectForKey:nameStr];//删除旧值
        i++;
        _imgCount = s;//后来的数据从那个数据开始储存
    }
    //
    [self.muDic addEntriesFromDictionary:self.newMuDic];
    NSLog(@"新是字典数据是什么muDic:%@  newMuDic:%@",self.muDic,self.newMuDic);
    [self.newMuDic removeAllObjects];
    

}
/**
 NSLog(@"请求成功的图片名称:%@",imageURL);
 NSString *urlStr = [NSString stringWithFormat:@"%@",imageURL];
 NSLog(@"这个key值是什么:%@",[self.muDic valueForKey:urlStr]);
 if (![self.muDic valueForKey:urlStr]) {
 _imgCount = _imgCount + 1;
 NSString *packedStr = [NSString stringWithFormat:@"%d",_imgCount];
 NSLog(@"这里的value值是什么:%@",packedStr);
 [self.muDic setObject:packedStr forKey:imageURL];
 NSLog(@"字典中有多少数据:%@",self.muDic[urlStr]);
 }
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存警告");
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
