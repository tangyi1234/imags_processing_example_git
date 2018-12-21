/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"

typedef NS_ENUM(NSUInteger, SDImageCacheConfigExpireType) {
    /**
     * When the image is accessed it will update this value
     */
    SDImageCacheConfigExpireTypeAccessDate,
    /**
     * The image was obtained from the disk cache (Default)
     */
    SDImageCacheConfigExpireTypeModificationDate
};

@interface SDImageCacheConfig : NSObject

/**
 * Decompressing images that are downloaded and cached can improve performance but can consume lot of memory.
 * Defaults to YES. Set this to NO if you are experiencing a crash due to excessive memory consumption.
 解压图像被下载和缓存可以提高性能,但可以消耗很多内存。默认值为YES。将这个参数设置为不如果你正在经历一个崩溃由于过度消耗内存。
 减小消耗内存
 */
@property (assign, nonatomic) BOOL shouldDecompressImages;

/**
 * Whether or not to disable iCloud backup
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldDisableiCloud;

/**
 * Whether or not to use memory cache
 * @note When the memory cache is disabled, the weak memory cache will also be disabled.
 * Defaults to YES.
 是否使用内存缓存@note当内存缓存是禁用的,软弱的内存缓存也将被禁用。默认值为YES。
 */
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

/**
 * The option to control weak memory cache for images. When enable, `SDImageCache`'s memory cache will use a weak maptable to store the image at the same time when it stored to memory, and get removed at the same time.
 * However when memory warning is triggered, since the weak maptable does not hold a strong reference to image instacnce, even when the memory cache itself is purged, some images which are held strongly by UIImageViews or other live instances can be recovered again, to avoid later re-query from disk cache or network. This may be helpful for the case, for example, when app enter background and memory is purged, cause cell flashing after re-enter foreground.
 * Defautls to YES. You can change this option dynamically.
 */
@property (assign, nonatomic) BOOL shouldUseWeakMemoryCache;

/**
 * The reading options while reading cache from disk.
 * Defaults to 0. You can set this to `NSDataReadingMappedIfSafe` to improve performance.
 */
@property (assign, nonatomic) NSDataReadingOptions diskCacheReadingOptions;

/**
 * The writing options while writing cache to disk.
 * Defaults to `NSDataWritingAtomic`. You can set this to `NSDataWritingWithoutOverwriting` to prevent overwriting an existing file.
 */
@property (assign, nonatomic) NSDataWritingOptions diskCacheWritingOptions;

/**
 * The maximum length of time to keep an image in the cache, in seconds.
 */
@property (assign, nonatomic) NSInteger maxCacheAge;

/**
 * The maximum size of the cache, in bytes.
 */
@property (assign, nonatomic) NSUInteger maxCacheSize;

/**
 * The attribute which the clear cache will be checked against when clearing the disk cache
 * Default is Modified Date
 */
@property (assign, nonatomic) SDImageCacheConfigExpireType diskCacheExpireType;

@end
