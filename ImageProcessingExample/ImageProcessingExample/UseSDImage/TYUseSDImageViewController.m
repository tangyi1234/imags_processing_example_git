//
//  TYUseSDImageViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2019/1/2.
//  Copyright © 2019年 汤义. All rights reserved.
//

#import "TYUseSDImageViewController.h"

@interface TYUseSDImageViewController (){
    UIButton *but;
    UIImageView *imageViews;
}

@end

@implementation TYUseSDImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView{
    but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 100, 100, 30);
    but.backgroundColor = [UIColor greenColor];
    [but setTitle:@"分析图片" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
//    imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, W, 300)];
//    imageViews.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:imageViews];
}

- (void)selectorBut{
//    UIImage *inputImage = [UIImage imageNamed:@"k"];//使用黑白素描滤镜
//    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];//设置要渲染的区域
//    [disFilter forceProcessingAtSize:inputImage.size]
//    [disFilter useNextFrameForImageCapture];//获取数据源
//    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];//添加上滤镜
//    [stillImageSource addTarget:disFilter];//开始渲染
//    [stillImageSource processImage];//获取渲染后的图片
//    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    
    // 获取一张图片
    UIImage *inputImage = [UIImage imageNamed:@"hhhh.jpg"];
    // 创建图片输入组件
    GPUImagePicture *sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    // 创建素描滤镜
    GPUImageSketchFilter *customFilter = [[GPUImageSketchFilter alloc] init];
    // 把素描滤镜串联在图片输入组件之后
    [sourcePicture addTarget:customFilter];
    // 创建ImageView输出组件
    GPUImageView *imageView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 140, W, 300)];
    [self.view addSubview:imageView];
    // 把ImageView输出组件串在滤镜链末尾
    [customFilter addTarget:imageView];
    // 调用图片输入组件的process方法，渲染结果就会绘制到imageView上
    [sourcePicture processImage];

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
