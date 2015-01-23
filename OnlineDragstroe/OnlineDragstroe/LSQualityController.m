//
//  LSQualityController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSQualityController.h"

@interface LSQualityController ()

@end

@implementation LSQualityController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"品质保障";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载品质保障服务页面
    [self loadHtml];
}

#pragma mark - 加载品质保障网页
- (void)loadHtml
{
    //访问url界面的字符串
    NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:kQualityAssureUrl] encoding:NSUTF8StringEncoding error:nil];
    
    //访问网页
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [web loadHTMLString:str baseURL:[NSURL URLWithString:kQualityAssureUrl]];
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
