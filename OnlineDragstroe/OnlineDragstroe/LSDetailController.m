//
//  LSDetailController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSDetailController.h"

//导入异步加载图片类
#import "UIImageView+AFNetworking.h"

//产品简介页
#import "LSBriefDesController.h"

//描述view
#import "LSProductDesView.h"

#define kDragImageViewHeight 216
#define kControlSpace 5
#define kDragNameLabelHeight 30
#define kDragPriceLabelHeight 30
#define kDragProductButtonHeight 30
#define kDragProductDesViewHeight 70
@interface LSDetailController ()

@end

@implementation LSDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //布局界面
    [self loadDragDetailView];
}

- (void)loadDragDetailView
{
    //初始化滚动视图
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scroll];
    
    //赋值药品图片
    self.dragImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kDragImageViewHeight)];
    [self.dragImageView setImageWithURL:[NSURL URLWithString:_dragModel.thumb]];
    [scroll addSubview:self.dragImageView];
    
    //赋值药品名
    self.dragNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kDragImageViewHeight + kControlSpace, 280, kDragNameLabelHeight)];
    self.dragNameLabel.text = [NSString stringWithFormat:@"名称：%@",_dragModel.title];
    [scroll addSubview:self.dragNameLabel];
    
    //赋值药品价格
    self.dragPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kDragImageViewHeight +kDragNameLabelHeight + kControlSpace * 2, 280, kDragPriceLabelHeight)];
    self.dragPriceLabel.text = [NSString stringWithFormat:@"价格：￥%@",_dragModel.price];
    [scroll addSubview:self.dragPriceLabel];
    
    //药品功能
    //根据计算来得高度确定功效文本高度
    CGRect frame = self.dragFunctionLabel.frame;
    frame.size.height = _dragModel.contentHeight;
    //NSLog(@"高度：%f",_dragModel.contentHeight);

    self.dragFunctionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kDragImageViewHeight +kDragNameLabelHeight + kDragPriceLabelHeight + kControlSpace * 3, 280, frame.size.height)];
    self.dragFunctionLabel.text = [NSString stringWithFormat:@"功效：%@",_dragModel.gongxiao1];
    self.dragFunctionLabel.numberOfLines = 0;
    [scroll addSubview:self.dragFunctionLabel];
    
    //产品简介frame
    frame = self.productDesButton.frame;
    frame.origin.y = CGRectGetMaxX(self.dragFunctionLabel.frame);
    self.productDesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.productDesButton.frame = CGRectMake(20, kDragImageViewHeight +kDragNameLabelHeight + kDragPriceLabelHeight +_dragModel.contentHeight + kControlSpace * 4, 280, kDragProductButtonHeight);
    self.productDesButton.backgroundColor = [UIColor grayColor];
    [self.productDesButton setTitle:@"查看产品简介" forState:UIControlStateNormal];
    self.productDesButton.tintColor = [UIColor redColor];
    self.productDesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.productDesButton addTarget:self action:@selector(productDesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:self.productDesButton];

    //描述View的frame
    self.desView = [[LSProductDesView alloc] initWithFrame:CGRectMake(10, kDragImageViewHeight +kDragNameLabelHeight + kDragPriceLabelHeight +_dragModel.contentHeight +kDragProductButtonHeight + kControlSpace * 5, 300, kDragProductDesViewHeight)];
    //self.desView.backgroundColor = [UIColor redColor];
    [scroll addSubview:self.desView];
    
    //购买产品的按钮
    self.phoneCallBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneCallBuyButton.frame = CGRectMake(10, kDragImageViewHeight +kDragNameLabelHeight + kDragPriceLabelHeight +_dragModel.contentHeight +kDragProductButtonHeight +kDragProductDesViewHeight + kControlSpace * 6, 120, 30);
    //self.phoneCallBuyButton.backgroundColor = [UIColor greenColor];
    //设置按钮背景图片
    [self.phoneCallBuyButton setBackgroundImage:[UIImage imageNamed:@"call_ico"] forState:UIControlStateNormal];
    [self.phoneCallBuyButton setTitle:@"电话下单" forState:UIControlStateNormal];
    //设置按钮的字体颜色
    [self.phoneCallBuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置按钮字体和大小
    self.phoneCallBuyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    //设置按钮偏移
    self.phoneCallBuyButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    //点击事件
    [self.phoneCallBuyButton addTarget:self action:@selector(phoneCallBuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:self.phoneCallBuyButton];
    
    self.onlineBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.onlineBuyButton.frame = CGRectMake(190, self.phoneCallBuyButton.frame.origin.y, 120, 30);
    //背景颜色
    //self.onlineBuyButton.backgroundColor = [UIColor grayColor];
    //设置按钮背景图片
    [self.onlineBuyButton setBackgroundImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    
    [self.onlineBuyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    //设置按钮的字体颜色
    [self.onlineBuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //设置按钮字体和大小
    self.onlineBuyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    self.onlineBuyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //点击事件
    [self.onlineBuyButton addTarget:self action:@selector(onlineBuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:self.onlineBuyButton];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.onlineBuyButton.frame.origin.y + 40);
}

#pragma mark - 产品简介按钮
- (void)productDesButtonClick:(UIButton *)button
{
    LSBriefDesController *briefDesVC = [[LSBriefDesController alloc] init];
    
    //传药品itemid
    briefDesVC.itemId = _dragModel.itemid;
    briefDesVC.bactBtntext = self.navigationItem.title;
    //NSLog(@"itemid:%@",_dragModel.itemid);
    
    //跳转
    [self.navigationController pushViewController:briefDesVC animated:YES];
}

#pragma mark - 电话下单按钮
- (void)phoneCallBuyButtonClick:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:kTelphoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫客服", nil];
    [alertView show];
}

#pragma mark - 立即购买按钮
- (void)onlineBuyButtonClick:(UIButton *)button
{

}

#pragma mark -UIAlertViewDelegate
#pragma mark - 点击电话购买按钮
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSLog(@"%d",buttonIndex);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kTelphoneNumber]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
