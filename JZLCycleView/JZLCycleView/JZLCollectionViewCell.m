//
//  JZLCollectionViewCell.m
//  JZLCycleView
//
//  Created by allenjzl on 2016/12/18.
//  Copyright © 2016年 allenjzl. All rights reserved.
//

#import "JZLCollectionViewCell.h"

@implementation JZLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
