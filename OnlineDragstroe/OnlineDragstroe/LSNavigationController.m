//
//  LSNavigationController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSNavigationController.h"

#define kNavigationBarbgImage @"topbar@2x"
@interface LSNavigationController ()

@end

@implementation LSNavigationController

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
    
    //设置导航条背景图片 appearance设置全部
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:kNavigationBarbgImage] forBarMetrics:UIBarMetricsDefault];
    
    //修改返回键颜色
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置导航条(所有)返回键颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置导航条标题字体大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:15.0f]}];
    //设置导航条背景颜色
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:20.0/255.0f green:190/255.0f blue:200/255.0f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
