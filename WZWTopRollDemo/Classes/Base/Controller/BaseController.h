//
//  BaseController.h
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import "NewsCell.h"
#import "NewsModel.h"

@interface BaseController : UIViewController

@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic,strong) UITableView * tableView;

@end
