//
//  WZWTopRollController.h
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZWTopRollController : UIViewController

//标题的属性设置
/** 标题滚动视图的背景颜色 */
@property (nonatomic,strong) UIColor * titleScrollViewColor;

/** 正常标题的颜色 */
@property (nonatomic,strong) UIColor * norColor;

/** 选中标题的颜色 */
@property (nonatomic,strong) UIColor * selColor;

/** 标题字体大小 */
@property (nonatomic,strong) UIFont * titleFont;

//标题下标的属性设置
/** 是否需要下标 */
@property (nonatomic,assign) BOOL isShowUnderLine;

/** 下标的颜色 */
@property (nonatomic,strong) UIColor * underLineColor;

/** 下标的高度 */
@property (nonatomic,assign) CGFloat underLineH;

@end
