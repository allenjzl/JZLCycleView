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
@property (nonatomic, weak) JZLCycleView *cycleView;
@property (nonatomic, weak) JZLCycleView *cycleView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    
    
    //网络图片
    NSMutableArray *arrTemp = [NSMutableArray array];
    [arrTemp addObject:@"http://pic2.cxtuku.com/00/01/30/b5898506ee44.jpg"];
    [arrTemp addObject:@"http://img4.duitang.com/uploads/blog/201306/08/20130608100514_HfKmk.thumb.600_0.jpeg"];
    [arrTemp addObject:@"http://my.isself.com/upimg/user/30/20131117/13846939809150.jpg"];
    [arrTemp addObject:@"http://img2.duitang.com/uploads/item/201208/07/20120807210311_ztEEM.thumb.600_0.jpeg"];
    _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, JZLScreenWidth, JZLCycleViewHeight) imageArray:arrTemp PlaceholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.view addSubview:_cycleView];
    _cycleView.delegate = self;
    
    
    //本地图片
    NSMutableArray *arrTemp2 = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%ld",@"car",(long)i]];
        [arrTemp2 addObject:image];
    }
    
    _cycleView2 = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 300, JZLScreenWidth, JZLCycleViewHeight) imageArray:arrTemp2 PlaceholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.view addSubview:_cycleView2];
    _cycleView2.delegate = self;
    
}

//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}








@end
