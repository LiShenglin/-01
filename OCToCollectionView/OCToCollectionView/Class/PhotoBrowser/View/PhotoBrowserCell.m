//
//  PhotoBrowserCell.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserCell.h"
#import "UIImageView+WebCache.h"
#import "homeModel.h"
@interface PhotoBrowserCell ()





@end

@implementation PhotoBrowserCell

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat imageW = self.PhotoBrowsermodel.pic_width.doubleValue;
    CGFloat imageH = self.PhotoBrowsermodel.pic_height.doubleValue;
    CGFloat H = W /imageW *imageH;
    CGFloat Y = ([UIScreen mainScreen].bounds.size.height - H) * 0.5;
    self.iconImageView.frame = CGRectMake(0, Y, W, H);
    
}

- (void)setPhotoBrowsermodel:(homeModel *)PhotoBrowsermodel
{
    _PhotoBrowsermodel = PhotoBrowsermodel;
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PhotoBrowsermodel.m_pic_url] placeholderImage:[UIImage imageNamed:@"empty_picture"]];

}

@end
