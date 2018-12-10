//
//  ViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/10.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "ViewController.h"
#import "TYImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addButView];
}

- (void)addButView{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 100, 200, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"跳转" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)selectorBut{
    TYImageViewController *vc = [[TYImageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
