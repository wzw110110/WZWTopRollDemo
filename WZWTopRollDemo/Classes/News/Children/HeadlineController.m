//
//  HeadlineController.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "HeadlineController.h"

@interface HeadlineController ()

@end

@implementation HeadlineController

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
    
    NSString * url = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=2&prog=LTitleA&passport=&devId=ozwK0YU9Ajv0mgWsk1EWnfAAcJQVwWCFMH4RsmrJzQCpWo9mvmqOVqZIAVhTQGiU&size=20&version=11.0&spever=false&net=wifi&lat=&lon=&ts=1467279452&sign=6MBzKbMbPhzrdhD97CQQe91YzQoGrtZOdA0zGIJZL8548ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore";
    self.manager = [AFHTTPRequestOperationManager manager];
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * arr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"T1348647853363"]];
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}




@end
