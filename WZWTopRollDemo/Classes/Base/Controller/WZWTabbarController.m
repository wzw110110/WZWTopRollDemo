//
//  WZWTabbarController.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/6/29.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "WZWTabbarController.h"
#import "NewsController.h"
#import "ReadController.h"
#import "VideoController.h"
#import "TopicController.h"
#import "ProfileController.h"

@interface WZWTabbarController ()

@end

@implementation WZWTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupAllControllers];
}

-(void)setupAllControllers{
    
    NewsController * newsVC = [[NewsController alloc]init];
    newsVC.view.backgroundColor = [UIColor whiteColor];
   UINavigationController * newsUNC = [self setViewController:newsVC image:[UIImage imageNamed:@"night_tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"night_tabbar_icon_news_highlight"] title:@"新闻"];
    
    ReadController * readVC = [[ReadController alloc]init];
    readVC.view.backgroundColor = [UIColor magentaColor];
    UINavigationController * readUNC = [self setViewController:readVC image:[UIImage imageNamed:@"night_tabbar_icon_reader_normal"] selectedImage:[UIImage imageNamed:@"night_tabbar_icon_reader_highlight"] title:@"阅读"];
    
    VideoController * videoVC = [[VideoController alloc]init];
    videoVC.view.backgroundColor = [UIColor blueColor];
    UINavigationController * videoUNC = [self setViewController:videoVC image:[UIImage imageNamed:@"night_tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"night_tabbar_icon_media_highlight"] title:@"视频"];
    
    TopicController * topicVC = [[TopicController alloc]init];
    topicVC.view.backgroundColor = [UIColor greenColor];
    UINavigationController * topicUNC = [self setViewController:topicVC image:[UIImage imageNamed:@"night_tabbar_icon_bar_normal"] selectedImage:[UIImage imageNamed:@"night_tabbar_icon_bar_highlight"] title:@"话题"];
    
    ProfileController * profileVC = [[ProfileController alloc]init];
    profileVC.view.backgroundColor = [UIColor grayColor];
    UINavigationController * profileUNC = [self setViewController:profileVC image:[UIImage imageNamed:@"night_tabbar_icon_me_normal"] selectedImage:[UIImage imageNamed:@"night_tabbar_icon_me_highlight"] title:@"我"];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.647 green:0.110 blue:0.129 alpha:1.000]} forState:UIControlStateSelected];
    self.viewControllers = @[newsUNC,readUNC,videoUNC,topicUNC,profileUNC];
}

-(UINavigationController *)setViewController:(UIViewController *) vc
                                       image:(UIImage *)image
                               selectedImage:(UIImage *)selectedImage
                                       title:(NSString *)title{
    vc.title = title;
    
    UINavigationController * unc = [[UINavigationController alloc]initWithRootViewController:vc];
    [unc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [unc.navigationBar setBarTintColor:[UIColor colorWithRed:0.647 green:0.110 blue:0.129 alpha:1.000]];
    unc.tabBarItem.title = title;
    unc.tabBarItem.image = image;
    unc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return unc;
}

@end
