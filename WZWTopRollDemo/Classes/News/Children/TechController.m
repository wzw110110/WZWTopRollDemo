//
//  TechController.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "TechController.h"

@interface TechController ()

@end

@implementation TechController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadData];
}

#pragma mark - 加载数据
-(void)loadData{
    
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    
    NSString * url = @"http://c.m.163.com/nc/article/list/T1348649580692/0-20.html";
    self.manager = [AFHTTPRequestOperationManager manager];
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * arr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"T1348649580692"]];
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
