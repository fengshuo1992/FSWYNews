//
//  FSWYNewsVController.m
//  FSWYNews
//
//  Created by 杭州米发 on 2017/12/19.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "FSWYNewsVController.h"


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface FSWYNewsVController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * titleScrollView;
@property (nonatomic, strong) UIScrollView * contentScrollView;
@property (nonatomic, strong) UIButton * seltelButton;
@property (nonatomic, strong) NSMutableArray * tittleArray;
@property (nonatomic, assign) BOOL isInit;
@end

@implementation FSWYNewsVController

- (void)viewWillAppear:(BOOL)animated
{
    if (_isInit == NO) {
        //设置标题（你就要知道你有多少标题 怎么知道有多少标题呢 可以看看当前控制器的子控制器）
        [self setTitleView];
        //设置内容的区域
        [self setContentView];
        _isInit = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //需要两个scrollView 一个显示标题一个小时内容的
    //标题的
    [self setTitiScrollView];
    //内容的
    [self setcontentScrollView];
}

#pragma mark - 显示标题的scrollView
- (void)setTitiScrollView
{
    //判断导航栏是不是存在
    CGFloat x ;
    if (ScreenHeight == 812.0) {
       x = self.navigationController.navigationBarHidden ? 44 : 88;
    }else{
      x  = self.navigationController.navigationBarHidden ? 22 : 64;
    }
    
    UIScrollView * titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, x, ScreenWidth, 50)];
    titleScrollView.backgroundColor = [UIColor lightGrayColor];
    titleScrollView.bounces = NO;
    titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
    
}

#pragma mark - 显示内容的scrollView
- (void)setcontentScrollView
{
    
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.titleScrollView.frame))];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.delegate = self;
    contentScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
}


#pragma mark - 设置标题
- (void)setTitleView
{
    NSInteger count = self.childViewControllers.count;
    CGFloat widht = 100;
    self.tittleArray = [NSMutableArray array];
    for ( int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * widht, 0, widht, self.titleScrollView.frame.size.height);
        UIViewController * controller = self.childViewControllers[i];
        button.tag = 1000 + i;
        [button setTitle:controller.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个被选中
        if (i ==  0) {
            [self selectButton:button];
        }
        [self.tittleArray addObject:button];
        [self.titleScrollView addSubview:button];
    }
    self.titleScrollView.contentSize= CGSizeMake(count * widht, 0);
    
}

#pragma mark - 设置内容的区域
- (void)setContentView
{
    NSInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i ++) {
        UIViewController * controller = self.childViewControllers[i];
        controller.view.frame = CGRectMake(i * ScreenWidth, 0, ScreenWidth, self.contentScrollView.frame.size.height);
        [self.contentScrollView addSubview:controller.view];
    }
    self.contentScrollView.contentSize = CGSizeMake(ScreenWidth * count, 0);
}

#pragma  mark - 处理按钮的点击事件
- (void)buttonAction:(UIButton *)button
{
    
    [self selectButton:button];
    NSInteger page = button.tag - 1000;
    CGFloat x = page *ScreenWidth;
    
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    //还有一个需求 就是按钮点击的时候如果在屏幕之外的话 自动滚动到屏幕中间
}

#pragma  mark - 设置button 的样式
- (void)selectButton:(UIButton *)button
{
    
    self.title = button.titleLabel.text;
    _seltelButton.transform = CGAffineTransformIdentity;
    [_seltelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGFloat offsetX = button.center.x -ScreenWidth/ 2;
    
    if (offsetX < 0) {
        offsetX =0;
    }
    //设置最大的偏移量
    CGFloat maxOffset = self.titleScrollView.contentSize.width - ScreenWidth;
    if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal]; //按钮点击的时候颜色 变化 但是上一个的颜色变回原来原来的颜色（这个就需要一个button 来记录上一个点击的button）
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    _seltelButton = button;
    
}


#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSInteger page = scrollView.contentOffset.x / ScreenWidth;
    //这个时候可以给改变button的颜色
    UIButton * button = self.tittleArray[page];
    [self selectButton:button];
}
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    NSInteger i = scrollView.contentOffset.x /ScreenWidth;
    NSInteger leftI = scrollView.contentOffset.x / ScreenWidth;
    NSInteger rightI = leftI + 1;
    
    UIButton * leftButton = self.tittleArray[leftI];
    UIButton * rightButton;
    if (rightI < self.tittleArray.count) {
        rightButton = self.tittleArray[rightI];
    }
    CGFloat scaleR = scrollView.contentOffset.x / ScreenWidth;
    scaleR -= i ;
    
    CGFloat scaleL = 1- scaleR;
    
    leftButton.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * 0.3 +1, scaleR * 0.3 + 1);
    
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    UIColor * right = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:right forState:UIControlStateNormal];
 
    NSLog(@"左边%ld  右边 %ld", leftI, rightI);


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
