//
//  JZLCycleView.m
//  JZLCycleView
//
//  Created by allenjzl on 2016/12/18.
//  Copyright © 2016年 allenjzl. All rights reserved.
//

#import "JZLCycleView.h"
#import "JZLCollectionViewCell.h"
#import "UIImageView+WebCache.h"
//#import "SDImageCache.h"

#define reuseID @"collectionViewCellID"
//定时器时间
#define automaticTime 3

@interface JZLCycleView ()




@end
@implementation JZLCycleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self setupCollcetionView];
    return  self;
    
}




+ (instancetype)cycleCollectionViewWithFrame: (CGRect)frame imageArray: (NSArray *)imageArray PlaceholderImage: (UIImage *)placeholderImage {
    JZLCycleView *cycleView = [[self alloc] initWithFrame:frame];
    cycleView.placeholderImage = placeholderImage;
    cycleView.imageArray = [NSMutableArray arrayWithArray:imageArray];
    return cycleView;
    
}



//设置collectionView
- (void)setupCollcetionView {
    //collcetionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[JZLCollectionViewCell class] forCellWithReuseIdentifier: reuseID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    //pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 50, self.bounds.size.height - 20, 100, 20)];
    //默认一张,加载图片后自动更新
    self.pageControl.numberOfPages = 1;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
}

#pragma maek - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count == 0) {
        return 1;
    }else {
       return self.imageArray.count * 3;
    }
    
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JZLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    if (self.imageArray.count == 0) {
        cell.imageView.image = self.placeholderImage;
        }else {
            if ([self.imageArray[indexPath.row % self.imageArray.count] isKindOfClass:[UIImage class]]) {
                cell.imageView.image = self.imageArray[indexPath.row % self.imageArray.count];
            }else if([self.imageArray[indexPath.row % self.imageArray.count] isKindOfClass:[NSString class]]) {
                if ([self.imageArray[indexPath.row % self.imageArray.count] hasPrefix:@"http"]) {
                    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.row % self.imageArray.count]] placeholderImage:self.placeholderImage];
                }

            }
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.imageArray.count == 0) {
        return;
    }else {
        //block
        if (self.clickItemBlock) {
            self.clickItemBlock(indexPath.item % self.imageArray.count);
        }
        
        //代理
        if ([self.delegate respondsToSelector:@selector(selectItemAtIndex:)]) {
            [self.delegate selectItemAtIndex:(indexPath.item % self.imageArray.count)];
        }
    }
    
}


//设置页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width)%self.imageArray.count;
}

//添加定时器
- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:automaticTime target:self selector:@selector(automaticScrollCollectionCell) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//删除定时器
- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)automaticScrollCollectionCell {
    self.index++;
    if (self.imageArray.count == 0) {
        return;
    }else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
        
        if (indexPath.row == self.imageArray.count * 2) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.imageArray.count inSection:0];
                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
            });
            
        }
        
        self.pageControl.currentPage = self.index % self.imageArray.count ;
//        NSLog(@"hahahaha");
    }

}
//手动滚动时删除定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self deleteTimer];
    if (self.imageArray.count == 0) {
        return;
    }else {
        //到第一组的最后一个,无动画滚动到中间一组的最后一个
        if (self.index == self.imageArray.count - 1) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count * 2 - 1 inSection:0] atScrollPosition:0 animated:NO];
        }
        //到最后一组的第一个,无动画滚动到中间一组的第一个
        if (self.index == self.imageArray.count * 2) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count inSection:0] atScrollPosition:0 animated:NO];
        }
    }

    
    
}
//停止滚动时打开定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.index = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    
}





- (void)setImageArray:(NSMutableArray *)imageArray {
    [_imageArray removeAllObjects];
    _imageArray = imageArray;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.imageArray.count inSection:0];
    //初始化滚动到第二组的第一个
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self addTimer];
    }else {
        [self addTimer];
    }
    
    
}



//view要销毁时,释放timer
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
}

















@end
