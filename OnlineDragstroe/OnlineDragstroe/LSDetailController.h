//
//  LSDetailController.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDragModel.h"
#import "LSProductDesView.h"

@interface LSDetailController : UIViewController

//药品图片
@property (nonatomic, strong) UIImageView *dragImageView;

//药品名
@property (nonatomic, strong) UILabel *dragNameLabel;

//药品价格
@property (nonatomic, strong) UILabel *dragPriceLabel;

//药品功能
@property (nonatomic, strong) UILabel *dragFunctionLabel;

//产品简介
@property (nonatomic, strong) UIButton *productDesButton;

//商品描述
//@property (nonatomic, strong) UIView *desView;
@property (nonatomic, strong) LSProductDesView *desView;

//电话下单
@property (nonatomic, strong) UIButton *phoneCallBuyButton;

//立即购买
@property (nonatomic, strong) UIButton *onlineBuyButton;

//药品数据模型
@property (nonatomic, strong) LSDragModel *dragModel;

/**
 产品简介
 */
- (void)productDesButtonClick:(UIButton *)button;

/**
 电话下单
 */
- (void)phoneCallBuyButtonClick:(UIButton *)button;

/**
 立即购买
 */
- (void)onlineBuyButtonClick:(UIButton *)button;
@end
