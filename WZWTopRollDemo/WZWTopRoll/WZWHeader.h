//
//  WZWHeader.h
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#ifndef WZWHeader_h
#define WZWHeader_h

//屏幕宽高
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//导航栏高度
#define NavBarH 64

/** 标题滚动视图的高度 */
#define WZWTitleScrollH 44

//标题字体设置
/** 默认标题字体大小 */
#define WZWTitleFont [UIFont systemFontOfSize:15]

/** 默认标题间距 */
static CGFloat const WZWMargin = 20;

/** 默认标题字体缩放比例 */
static CGFloat const WZWTitleTransformScale = 1.3;


//下划线设置
/** 下划线默认高度 */
static CGFloat const WZWUnderLineH = 2;

//系统cell
static NSString * CellId = @"CellID";

#endif /* WZWHeader_h */
