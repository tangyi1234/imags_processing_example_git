//
//  TYSDWebImageTableViewCell.m
//  ImageProcessingExample
//
//  Created by 汤义 on 2018/12/21.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYSDWebImageTableViewCell.h"
@interface TYSDWebImageTableViewCell()
@property (nonatomic, weak) UIImageView *imageViews;
@end
@implementation TYSDWebImageTableViewCell
+ (TYSDWebImageTableViewCell *)addSDWebImageTableViewCell:(UITableView *)tableView{
    static NSString *Id = @"TYSDWebImageTableViewCell";
    TYSDWebImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[TYSDWebImageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Id];
        [cell initView];
    }
    return cell;
}

- (void)initView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, 200)];
    imageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_imageViews = imageView];
}

- (void)addImageUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [_imageViews sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
