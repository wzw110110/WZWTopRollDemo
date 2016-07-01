//
//  NewsController.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/6/29.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "NewsController.h"
//#import "HeadlineController.h"
//#import "AmusementController.h"
//#import "HotpotController.h"
//#import "SportController.h"
//#import "LocalController.h"
//#import "NetEaseController.h"
//#import "FinanceController.h"
//#import "TechController.h"

@interface NewsController ()

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildControllers];
    
}

#pragma mark - 添加所有的子视图控制器
-(void)addAllChildControllers{
//    HeadlineController * headlineVC = [[HeadlineController alloc]init];
//    headlineVC.view.backgroundColor = [UIColor cyanColor];
//    headlineVC.title = @"头条";
//    [self addChildViewController:headlineVC];
//    
//    AmusementController * amuseVC = [[AmusementController alloc]init];
//    amuseVC.title = @"娱乐";
//    amuseVC.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:amuseVC];
//    
//    HotpotController * hotpotVC = [[HotpotController alloc]init];
//    hotpotVC.title = @"热点";
//    hotpotVC.view.backgroundColor = [UIColor blueColor];
//    [self addChildViewController:hotpotVC];
//    
//    SportController * sportVC = [[SportController alloc]init];
//    sportVC.title = @"体育";
//    sportVC.view.backgroundColor = [UIColor lightGrayColor];
//    [self addChildViewController:sportVC];
//    
//    LocalController * localVC = [[LocalController alloc]init];
//    localVC.title = @"本地";
//    localVC.view.backgroundColor = [UIColor orangeColor];
//    [self addChildViewController:localVC];
//    
//    NetEaseController * netEaseVC = [[NetEaseController alloc]init];
//    netEaseVC.title = @"网易号";
//    netEaseVC.view.backgroundColor = [UIColor magentaColor];
//    [self addChildViewController:netEaseVC];
//    
//    FinanceController  * financeVC = [[FinanceController alloc]init];
//    financeVC.title = @"财经";
//    financeVC.view.backgroundColor = [UIColor yellowColor];
//    [self addChildViewController:financeVC];
//    
//    TechController * techVC = [[TechController alloc]init];
//    techVC.title = @"科技";
//    techVC.view.backgroundColor = [UIColor greenColor];
//    [self addChildViewController:techVC];
}


@end
