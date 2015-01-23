//
//  LSDockController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSDockController.h"
#import "LSHomeController.h"
#import "LSSearchController.h"
#import "LSAllClassesController.h"
#import "LSPrivilegeController.h"
#import "LSDragStoreController.h"
#import "LSNavigationController.h"

#define kCategoryItemImage @"category1"
#define kCategoryItemSelectedImage @"category"
@interface LSDockController ()

@end

@implementation LSDockController

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
    
    //初始化选项卡控制器
    [self initTabBarController];
}

/**
 初始化选项卡控制器
 */
- (void)initTabBarController
{
    //1.初始化控制器
    LSHomeController      *homeVC = [[LSHomeController alloc] init];
    LSSearchController    *searchVC = [[LSSearchController alloc] init];
    
    //设置collectionView的layout
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    //item大小
    layout.itemSize = CGSizeMake(90, 100);
    //最小item上下间距
    layout.minimumLineSpacing = 10;
    //item左右最少间距
    layout.minimumInteritemSpacing = 10;
    //上下左右间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    LSAllClassesController  *categoryVC = [[LSAllClassesController alloc] initWithCollectionViewLayout:layout];
    //设置tabBarItem
    categoryVC.title = @"分类";
    categoryVC.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kCategoryItemImage];
    categoryVC.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kCategoryItemSelectedImage];

    
    LSPrivilegeController *privilegeVC = [[LSPrivilegeController alloc] init];
    LSDragStoreController *dragstoreVC = [[LSDragStoreController alloc] init];
    
    //2.初始化导航控制器
    
    LSNavigationController *homeNav = [[LSNavigationController alloc] initWithRootViewController:homeVC];
    LSNavigationController *searchNav = [[LSNavigationController alloc] initWithRootViewController:searchVC];
    LSNavigationController *categoryNav = [[LSNavigationController alloc] initWithRootViewController:categoryVC];
    LSNavigationController *privilegeNav = [[LSNavigationController alloc] initWithRootViewController:privilegeVC];
    LSNavigationController *dragstoreNav = [[LSNavigationController alloc] initWithRootViewController:dragstoreVC];
    
    //3.添加控制器到选项卡控制器
    self.viewControllers = @[homeNav,searchNav,categoryNav,privilegeNav,dragstoreNav];
    
    //设置tabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    
    //设置tabbarItem选中时字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:252/255.0f green:119/255.0f blue:104/255.0f alpha:1.0f]} forState:UIControlStateSelected];
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
