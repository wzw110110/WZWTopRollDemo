//
//  BaseController.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "BaseController.h"
#import "WZWHeader.h"

@interface BaseController () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

#pragma mark - 初始化界面
-(void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavBarH + WZWTitleScrollH, ScreenW, ScreenH-NavBarH-WZWTitleScrollH-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"wzw"];
    [self.view addSubview:_tableView];
}

#pragma mark - 表格视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"wzw"];
    cell.newsModel = self.dataArray[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark - 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
