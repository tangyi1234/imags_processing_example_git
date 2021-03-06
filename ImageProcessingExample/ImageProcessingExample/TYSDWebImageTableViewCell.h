//
//  TYSDWebImageTableViewCell.h
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/21.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^storage)(NSString *urlStr);
@interface TYSDWebImageTableViewCell : UITableViewCell
@property (nonatomic, copy) storage storageBlock;
+ (TYSDWebImageTableViewCell *)addSDWebImageTableViewCell:(UITableView *)tableView;
- (void)addImageUrl:(NSString *)urlStr;
@end
