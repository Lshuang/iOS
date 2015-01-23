//
//  LSDragStoreController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSDragStoreController.h"

#define kUserItemImage @"user1"
#define kUserItemSelectedImage @"user"

@interface LSDragStoreController ()

@end

@implementation LSDragStoreController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置tabBarItem
        self.title = @"我的药店";
        self.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kUserItemImage];
        self.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kUserItemSelectedImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold"  size:15.0f]};
    
    //获取登录界面
    [self loginMyDragStore];
}

#pragma mark - login
- (void)loginMyDragStore
{
    UIWebView *loginWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    //NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:kLoginUrl] encoding:NSUTF8StringEncoding error:nil];
    //[briefWebView loadHTMLString:str baseURL:[NSURL URLWithString:kLoginUrl]];
    [loginWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kLoginUrl]]];
    [self.view addSubview:loginWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
