//
//  TYImageViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/10.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYImageViewController.h"

@interface TYImageViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation TYImageViewController
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, 400)];
        _imgView.backgroundColor = [UIColor redColor];
    }
    return _imgView;
}

- (CALayer *)imageLayer{
    if (!_imageLayer) {
        _imageLayer = [[CALayer alloc] init];
        _imageLayer.frame = CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, 400);
    }
    return _imageLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addButView];
//    [self.view addSubview:self.imgView];
    [self.view.layer addSublayer:self.imageLayer];
}

- (void)addButView{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 100, 100, 30);
    but.backgroundColor = [UIColor greenColor];
    [but setTitle:@"显示图片" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)selectorBut{
    UIImage *image = [UIImage imageNamed:@"8"];
    NSString *resource = [[NSBundle mainBundle] pathForResource:@"hhhh"ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:resource options:0 error:nil];
    CFDataRef dataRef = (__bridge CFDataRef)data;
    
    CGImageSourceRef source = CGImageSourceCreateWithData(dataRef, nil);
    
    CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil);
//    CGImageRef ImageRef = (__bridge id _Nullable )image.CGImage;
    self.imageLayer.contents = (__bridge id _Nullable)(YYCGImageCreateDecodedCopy(cgImage, NO));
//    NSData *data = UIImagePNGRepresentation(image);
//    NSLog(@"图片大小:%lu",(unsigned long)data.bytes);
//    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
//    NSLog(@"打印大小:%@",rawData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

CGImageRef YYCGImageCreateDecodedCopy(CGImageRef imageRef, BOOL decodeForDisplay) {
    if (!imageRef) return NULL;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    if (width == 0 || height == 0) return NULL;
    
    if (decodeForDisplay) { //decode with redraw (may lose some precision)
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        // BGRA8888 (premultiplied) or BGRX8888
        // same as UIGraphicsBeginImageContext() and -[UIView drawRect:]
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, YYCGColorSpaceGetDeviceRGB(), bitmapInfo);
        if (!context) return NULL;
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef); // decode
        CGImageRef newImage = CGBitmapContextCreateImage(context);
        CFRelease(context);
        return newImage;
        
    } else {
        CGColorSpaceRef space = CGImageGetColorSpace(imageRef);
        size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
        size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
        size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
        CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
        if (bytesPerRow == 0 || width == 0 || height == 0) return NULL;
        
        CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
        if (!dataProvider) return NULL;
        CFDataRef data = CGDataProviderCopyData(dataProvider); // decode
        if (!data) return NULL;
        
        CGDataProviderRef newProvider = CGDataProviderCreateWithCFData(data);
        CFRelease(data);
        if (!newProvider) return NULL;
        
        CGImageRef newImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, space, bitmapInfo, newProvider, NULL, false, kCGRenderingIntentDefault);
        CFRelease(newProvider);
        return newImage;
    }
}

CGColorSpaceRef YYCGColorSpaceGetDeviceRGB() {
    static CGColorSpaceRef space;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        space = CGColorSpaceCreateDeviceRGB();
    });
    return space;
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
