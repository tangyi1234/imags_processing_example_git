//
//  TYLearningViewController.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/13.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYLearningViewController.h"

@interface TYLearningViewController ()

@end

@implementation TYLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addInit];
//    [self addInit1];
    [self addInit2];
}

- (void)addInit{
    NSArray *arr1 = [[NSArray alloc] init];
    NSArray *arr2 = [[NSArray alloc] init];
    NSArray *arr3 = [NSArray arrayWithObjects:@"1", nil];
    NSArray *arr4 = [NSArray arrayWithObjects:@"5", nil];
    [arr1 arrayByAddingObject:@"2"];
    NSLog(@"第一个地址:%p",arr1);
    NSLog(@"第二个地址:%p",arr2);
    NSLog(@"第三个地址:%p",arr3);
    NSLog(@"第四个地址:%p",arr4);
}

- (void)addInit1{
    NSArray*placeholder = [NSArray alloc];
    
    NSArray*arr1 = [[NSArray alloc] init];
    
    NSArray*arr2 = [[NSArray alloc] initWithObjects:@0, nil];
    
    NSArray*arr3 = [[NSArray alloc] initWithObjects:@0, @1, nil];
    
    NSArray*arr4 = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", nil];
    
    NSLog( @"placeholder: %s", object_getClassName(placeholder));
    
    NSLog( @"arr1: %s", object_getClassName(arr1));
    
    NSLog( @"arr2: %s", object_getClassName(arr2));
    
    NSLog( @"arr3: %s", object_getClassName(arr3));
    
    NSLog( @"arr4: %s", object_getClassName(arr4));
}

- (void)addInit2{
    NSMutableArray *mPlaceholder = [NSMutableArray alloc];
    
    NSMutableArray *mArr1 = [[NSMutableArray alloc] init];
    
    NSMutableArray *mArr2 = [[NSMutableArray alloc] initWithObjects:@ 0, nil];
    
    NSMutableArray *mArr3 = [[NSMutableArray alloc] initWithObjects:@ 0, @ 1, nil];
    
    NSLog( @"mPlaceholder: %s", object_getClassName(mPlaceholder));
    
    NSLog( @"mArr1: %s", object_getClassName(mArr1));
    
    NSLog( @"mArr2: %s", object_getClassName(mArr2));
    
    NSLog( @"mArr3: %s", object_getClassName(mArr3));
}

- (void)addInit3{
//    NSFastEnumerationState state = {0};
//    NSArray *array = @[@1,@2,@3];
//    id buffer[2];
//    //buffer 实际上内部没有用上，但还是得传， 2表示我期望得到2个对象，实际上返回的是全部对象数3
//    NSUInteger n = [array countByEnumeratingWithState:&state objects:buffer count:2];
//    for (NSUInteger i=0; i<n; ++i) {
//        NSLog(@"%@", (__bridge NSNumber *)state.itemsPtr[i]);
//    }
}

//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer count:(NSUInteger)len {
//    if (!buffer && len > 0) {
//        CFStringRef errorString = CFStringCreateWithFormat(kCFAllocatorSystemDefault, NULL, CFSTR("*** %s: pointer to objects array is NULL but length is %lu"), "-[__NSArrayI countByEnumeratingWithState:objects:count:]",(unsigned long)len);
//        CFAutorelease(errorString);
//        [[NSException exceptionWithName:NSInvalidArgumentException reason:(__bridge NSString *)errorString userInfo:nil] raise];
//    }
//    
//    if (len >= 0x40000000) {
//        CFStringRef errorString = CFStringCreateWithFormat(kCFAllocatorSystemDefault, NULL, CFSTR("*** %s: count (%lu) of objects array is ridiculous"), "-[__NSArrayI countByEnumeratingWithState:objects:count:]",(unsigned long)len);
//        CFAutorelease(errorString);
//        [[NSException exceptionWithName:NSInvalidArgumentException reason:(__bridge NSString *)errorString userInfo:nil] raise];
//    }
//    
//    static const unsigned long mu = 0x01000000;
//    
//    if (state->state == 0) {
//        state->mutationsPtr = μ
//        state->state = ~0;
//        state->itemsPtr = _list;
//        return _used;
//    }
//    return 0;
//}

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
