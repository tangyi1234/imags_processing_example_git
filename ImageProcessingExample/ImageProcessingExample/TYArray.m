//
//  TYArray.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/17.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYArray.h"

@implementation TYArray
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

@end
