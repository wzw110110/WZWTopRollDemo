//
//  NewsCell.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/4.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *stitleLabel;

@end

@implementation NewsCell

-(void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]];
    _stitleLabel.text = _newsModel.title;
}

@end
