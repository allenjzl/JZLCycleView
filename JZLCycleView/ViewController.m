//
//  ViewController.m
//  JZLCycleView
//
//  Created by allenjzl on 2016/12/18.
//  Copyright © 2016年 allenjzl. All rights reserved.
//

#import "ViewController.h"
#import "JZLCycleView.h"

#define JZLScreenWidth [UIScreen mainScreen].bounds.size.width
#define JZLCycleViewHeight 200

@interface ViewController ()

@end

@interface ViewController ()<JZLCycleViewDelegate>
@property (nonatomic, strong) JZLCycleView *cycleView;
@property (nonatomic, strong) JZLCycleView *cycleView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, JZLScreenWidth, JZLCycleViewHeight) PlaceholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _cycleView.pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    _cycleView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _cycleView.delegate = self;
    _cycleView.clickItemBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
    };
    [self.view addSubview:_cycleView];
    //延迟模拟网络加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *arrTemp = [NSMutableArray array];
        [arrTemp addObject:@"http://pic2.cxtuku.com/00/01/30/b5898506ee44.jpg"];
        [arrTemp addObject:@"http://img4.duitang.com/uploads/blog/201306/08/20130608100514_HfKmk.thumb.600_0.jpeg"];
        [arrTemp addObject:@"http://my.isself.com/upimg/user/30/20131117/13846939809150.jpg"];
        [arrTemp addObject:@"http://img2.duitang.com/uploads/item/201208/07/20120807210311_ztEEM.thumb.600_0.jpeg"];
        
            _cycleView.imageUrlArray = arrTemp;
    });
//
    NSMutableArray *arrTemp = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%ld",@"car",(long)i]];
        [arrTemp addObject:image];
    }
    _cycleView2 = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 300, JZLScreenWidth, JZLCycleViewHeight) imageArray:arrTemp PlaceholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.view addSubview:_cycleView2];
    
}

//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}






@end
