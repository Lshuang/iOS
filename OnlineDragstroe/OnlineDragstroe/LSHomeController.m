//
//  LSHomeController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSHomeController.h"

//药品详情页面
#import "LSFirstDetailController.h"
//药品列表数据模型
#import "DragHLModel.h"
//列表单元格
#import "HomeListCell.h"
//异步加载图片头文件
#import "UIImageView+AFNetworking.h"
//服务区域页面
#import "LSServiceAreaController.h"
//品质保障页面
#import "LSQualityController.h"
//网络请求管理类
#import "LSHttpRequestManager.h"

#define kHomeItemImage @"home1"
#define kHomeItemSelectedImage @"home"
#define kLogoImage @"home_logo"
#define kDockHeight  49
#define kTopDockHeight  64
#define kSectionViewHeight 80
#define kButtonSpaceWidth 40   //按钮的间隔
#define kButtonSidesWidth 30   //按钮两边的间隔

@interface LSHomeController ()
{
    NSMutableArray *homeListArray;
    
    UIView *sectionView;                  //sectionView
}
@end

@implementation LSHomeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //设置tabBarItem
        
        self.title = @"首页";
        self.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kHomeItemImage];
        self.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kHomeItemSelectedImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数据源
    homeListArray = [NSMutableArray array];
    
    //初始化导航条
    [self initNavigatonBar];
    
    //初始化tableview
    [self initTableView];
    
    //请求网络数据
    [self requestData];
}

#pragma mark - 初始化导航条
- (void)initNavigatonBar
{
    //设置导航条背景颜色(appearance设置所有背景颜色)
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:20.0/255.0f green:190/255.0f blue:200/255.0f alpha:1.0f];
    
    //设置导航条titleView
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    logoImageView.image = [Utility resizedImage:kLogoImage];
    self.navigationItem.titleView = logoImageView;
}

#pragma mark - 初始化tableview
- (void)initTableView
{
    //初始化tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopDockHeight, self.view.frame.size.width, self.view.frame.size.height - kTopDockHeight - kDockHeight - kSectionViewHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeListCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}


#pragma mark - 请求数据
- (void)requestData
{
    [[LSHttpRequestManager shareManager] requestHomeCategoryFromNetWorkSuccess:^(LSHttpRequestManager *manager, id model) {
        NSArray *array = model;
        
        for (NSDictionary *dic in array) {
            DragHLModel *oneModel = [[DragHLModel alloc] init];
            oneModel.catid = dic[@"catid"];
            oneModel.catname = dic[@"catname"];
            oneModel.cid = dic[@"cid"];
            oneModel.linkurl = dic[@"linkurl"];
            oneModel.seo_description = dic[@"seo_description"];
            
            //添加数据模型到数组里
            [homeListArray addObject:oneModel];
        }
        
        //刷新tableView
        [self.tableView reloadData];
        
    } failure:^(LSHttpRequestManager *manager, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return homeListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //赋值
    if (homeListArray.count > 0) {
        DragHLModel *dragModel = homeListArray[indexPath.row];
        cell.classNameLabel.text = dragModel.catname;
        cell.descriptionLabel.text = dragModel.seo_description;
        
        //获得图片地址
        NSString *imageUrlString = [NSString stringWithFormat:kListImageUrl,dragModel.catid];
        [cell.listImageView setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil];
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
#pragma mark - 自定义section header(可以自定义view)
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *imgArray = @[@"tel",@"area",@"help"];
    NSArray *array = @[@"电话购买",@"服务区域",@"品质保障"];
    //自定义view
    sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kSectionViewHeight)];
    sectionView.backgroundColor = [UIColor whiteColor];
    //按钮宽度
    NSInteger buttonWidth = (sectionView.frame.size.width - kButtonSpaceWidth * (array.count - 1) - kButtonSidesWidth * (array.count - 1))/array.count;
    //按钮高度
    NSInteger buttonHeight = 40;
    
    for (int i = 0; i < array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i + 1;
        button.frame = CGRectMake(kButtonSidesWidth + (buttonWidth + kButtonSpaceWidth) * i, 15, buttonWidth, buttonHeight);
        //设置按钮背景图片
        [button setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        //设置按钮文字描述
        [button setTitle:array[i] forState:UIControlStateNormal];
        //设置按钮的字体颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置文字字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        //设置文字偏移
        button.titleEdgeInsets = UIEdgeInsetsMake(60, 0, 0, 0);
        //设置点击事件
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:button];
    }
    return sectionView;
}

#pragma mark - 返回heightForHeaderInSection
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionViewHeight;
}

#pragma mark - 选中单元格调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    //item大小
    layout.itemSize = CGSizeMake(90, 100);
    //最小item上下间距
    layout.minimumLineSpacing = 10;
    //item左右最少间距
    layout.minimumInteritemSpacing = 10;
    //上下左右间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //跳转到详情界面
    LSFirstDetailController *firstDetailVC = [[LSFirstDetailController alloc] initWithCollectionViewLayout:layout];
    DragHLModel *model = homeListArray[indexPath.row];
    //NSLog(@"%@",model.catid);
    firstDetailVC.cid = model.catid;
    firstDetailVC.title = model.catname;
    [self.navigationController pushViewController:firstDetailVC animated:YES];
}

//触发点击事件
- (void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case 1:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:kTelphoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
            [alertView show];
        }
            break;
        case 2:
        {
            LSServiceAreaController *area = [[LSServiceAreaController alloc] init];
            [self.navigationController pushViewController:area animated:YES];
        }
            break;
        case 3:
        {
            LSQualityController *qualityVC = [[LSQualityController alloc] init];
            [self.navigationController pushViewController:qualityVC animated:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UIAlertViewDelegate
#pragma mark - 点击电话购买按钮
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSLog(@"%d",buttonIndex);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kTelphoneNumber]]];
}

@end
