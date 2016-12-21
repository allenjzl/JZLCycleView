//
//  JZLCycleView.h
//  JZLCycleView
//
//  Created by allenjzl on 2016/12/18.
//  Copyright © 2016年 allenjzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZLCycleViewDelegate <NSObject>

/**
 跳转的代理方法

 @param index index
 */
- (void)selectItemAtIndex: (NSInteger)index;

@end
//点击跳转block
typedef void(^clickItemBlock)(NSInteger currentIndex);
@interface JZLCycleView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) id<JZLCycleViewDelegate> delegate;
//定时器
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;
//页码小圆点
@property (nonatomic, strong) UIPageControl *pageControl;
//图片数组
@property (nonatomic, strong) NSMutableArray *imageArray;
//图片url数组
@property (nonatomic, strong) NSMutableArray *imageUrlArray;
//占位图片
@property (nonatomic, strong) UIImage *placeholderImage;
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) clickItemBlock clickItemBlock;

/**
 加载后台获取的url图片

 @param frame 图片轮播器的frame
 @param placeholderImage 占位图
 @return 图片轮播图
 */
+ (instancetype)cycleCollectionViewWithFrame: (CGRect)frame PlaceholderImage: (UIImage *)placeholderImage;



/**
 加载本地图片

 @param frame 图片轮播器frame
 @param imageArray 本地图片数组(数组里元素为imageView)
 @param placeholderImage 占位图
 @return 图片轮播器
 */
+ (instancetype)cycleCollectionViewWithFrame: (CGRect)frame imageArray: (NSArray *)imageArray PlaceholderImage: (UIImage *)placeholderImage;
@end
