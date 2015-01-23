//
//  LSBriefDesController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//  产品简介

#import "LSBriefDesController.h"

//网络请求管理类
#import "LSHttpRequestManager.h"

//导入产品简介数据模型
#import "LSBriefModel.h"

@interface LSBriefDesController ()
{
    //保存药品信息
    NSMutableArray *briefArray;
}

@end

@implementation LSBriefDesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"产品简介";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    briefArray = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //请求网络数据
    [self requestData];
    
}

#pragma mark - 请求产品介绍数据
- (void)requestData
{
    [[LSHttpRequestManager shareManager] requestProductBriefDescriptionWithCid:_itemId success:^(LSHttpRequestManager *manager, id model) {
        NSArray *array = model;
        
        for (NSDictionary *dic in array) {
            LSBriefModel *briefModel = [[LSBriefModel alloc] init];
            briefModel.cid = dic[@"cid"];
            briefModel.itemid = dic[@"itemid"];
            briefModel.content = dic[@"content"];
            
            //添加到数组
            [briefArray addObject:briefModel];
        }
        //显示产品简介
        [self showProductInfo];
    } failure:^(LSHttpRequestManager *manager, NSError *error) {
         NSLog(@"错误信息:%@",error);
    }];
}

#pragma mark - 显示产品介绍数据 
- (void)showProductInfo
{
    //NSLog(@"数组：%@",briefArray);
    UIWebView *briefWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    LSBriefModel *briefModel = briefArray[0];
    [briefWebView loadHTMLString:briefModel.content baseURL:nil];
    [self.view addSubview:briefWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
