//
//  LSDragDesCell.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSDragDesCell.h"

//导入异步加载图片类
#import "UIImageView+AFNetworking.h"

@implementation LSDragDesCell

- (void)awakeFromNib
{
    // Initialization code
}

//赋值
- (void)setModel:(LSDragModel *)dragModel
{
    //药品图片
    [self.dragDesImageView setImageWithURL:[NSURL URLWithString:dragModel.thumb]];
    
    //药品名
    self.dragNameLabel.text = dragModel.title;
    
    //价格
    self.dragPriceLabel.text = [NSString stringWithFormat:@"价格：%@元",dragModel.price];
    
    //功效
    self.dragFunctionLabel.text = dragModel.gongxiao1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
