//
//  LSSearchController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSSearchController.h"

//导入搜索结果显示界面
#import "LSSearchProductController.h"

#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define kSearchItemImage @"search1"
#define kSearchItemSelectedImage @"search"

@interface LSSearchController () <UISearchBarDelegate>
{
    //系统searchbar
    UISearchBar *_searchBar;
    
}
@end

@implementation LSSearchController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置tabBarItem
        self.title = @"搜索";
        self.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kSearchItemImage];
        self.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kSearchItemSelectedImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化视图
    [self drawUI];
    
    //初始化searchBar
    [self initSearchBar];
}

//初始化视图
- (void)drawUI
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 200, 60, 60)];
    imgView.image = [UIImage imageNamed:@"yao_ico"];
    [self.view addSubview:imgView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 260, 30)];
    textLabel.text = @"输入自己需要查找的药品！";
    [self.view addSubview:textLabel];
}

//初始化搜索框
- (void)initSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    //设置代理
    _searchBar.delegate = self;
    
    _searchBar.barTintColor = [UIColor whiteColor];
    
    if (iOS7) {
        _searchBar.tintColor = [UIColor whiteColor];
        _searchBar.barTintColor = [UIColor clearColor];
    }
    else
    {
        _searchBar.tintColor = [UIColor whiteColor];
    }
    
    //设置默认文字
    _searchBar.placeholder = @"搜索药品，1小时送药上门";
    
    UIView *rightBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300,30)];
    rightBarView.backgroundColor = [UIColor clearColor];
    [rightBarView addSubview:_searchBar];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarView];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //光标进入输入框调用
    
    //显示cancel按钮
    //[searchBar showsCancelButton];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = YES;
	NSArray *subViews;
    if (iOS7) {
        subViews = [(searchBar.subviews[0]) subviews];
        
    } else {
        subViews = searchBar.subviews;
    }
    
    for(id cancelBtn in subViews)
    {
        
        if([cancelBtn isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cancelBtn;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
	return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //点击取消按钮时调用
    
    //1.隐藏键盘
    [searchBar resignFirstResponder];
    //2.隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    //3.清空所搜文字
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //点击键盘上的搜索按钮回调用
    
    NSString *searchString = searchBar.text;
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    LSSearchProductController *searchVC = [[LSSearchProductController alloc] init];
    searchVC.title = searchString;
    searchVC.searchWord = searchString;
    [self.navigationController pushViewController:searchVC animated:YES];
    
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
