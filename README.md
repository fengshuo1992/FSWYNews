# FSWYNews
一个仿网易新闻的可以滚动的多控制器的demo

FSWYNewsVController： 各位看官如果使用的话可以直接继承自这个VC 然后在当前的VC中添加视图控制器即可[self addChildController];#pragma  mark - 设置父子视图
- (void)addChildController
{
TopViewController * topVC = [[TopViewController alloc] init];
topVC.title = @"首页";
[self addChildViewController:topVC];

HotViewController * hotVC = [[HotViewController alloc] init];
hotVC.title = @"热点";
[self addChildViewController:hotVC];


TestViewController * testVC = [[TestViewController alloc] init];
testVC.title = @"测试";
[self addChildViewController:testVC];

FinancialViewController * financialVC = [[FinancialViewController alloc] init];
financialVC.title = @"理财";
[self addChildViewController:financialVC];

VideoViewController * videoVC = [[VideoViewController alloc] init];
videoVC.title = @"视频";
[self addChildViewController:videoVC];

ColorViewController * colorVC = [[ColorViewController alloc] init];
colorVC.title = @"颜色";
[self addChildViewController:colorVC];


//    DiscoverViewController* discoverVC = [[DiscoverViewController alloc] init];
//    discoverVC.title = @"发现";
//    [self addChildViewController:discoverVC];


}
代码简单可复用强 欢迎mark 点一点小星星  如果有什么不行的地方 可以及时的和我说呦
