//
//  LSPrivilegeController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSPrivilegeController.h"

//网络请求管理类
#import "LSHttpRequestManager.h"

//导入药品数据模型
#import "LSDragModel.h"

//导入Cell
#import "LSDragDesCell.h"

//导入药品详情
#import "LSDetailController.h"

#define kPriceItemImage @"price"
#define kPriceItemSelectedImage @"price1"

@interface LSPrivilegeController ()
{

    //保存优惠药 特价药信息
    NSMutableArray *onSaleDatas;
    
}
@end

@implementation LSPrivilegeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //设置tabBarItem
        self.title = @"优惠";
        self.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kPriceItemImage];
        self.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kPriceItemSelectedImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数组
    onSaleDatas = [NSMutableArray array];
    
    //设置标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold"  size:15.0f]};
    
    //初始化tableview
    [self initTableView];
    
    //请求网络数据
    [self requestData];
 
}

#pragma mark - 初始化tableview
- (void)initTableView
{
    //初始化tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49) style:UITableViewStylePlain];
    self.tableView.rowHeight = 120;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LSDragDesCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - 请求数据
- (void)requestData
{
    [[LSHttpRequestManager shareManager] requestSpecialPriceProductInformationSuccess:^(LSHttpRequestManager *manager, id model) {
        NSArray *array = model;
        
        for (NSDictionary *dic in array) {
            LSDragModel *dragModel = [[LSDragModel alloc] init];
            
            dragModel.cid = dic[@"cid"];
            dragModel.gongxiao1 = dic[@"gongxiao1"];
            dragModel.contentHeight = [Utility getTextHeightWithText:dragModel.gongxiao1];
            dragModel.itemid = dic[@"itemid"];
            dragModel.linkurl = dic[@"linkurl"];
            dragModel.price = dic[@"price"];
            dragModel.thumb = dic[@"thumb"];
            dragModel.title = dic[@"title"];
            dragModel.username = dic[@"username"];
            
            //添加到数据源
            [onSaleDatas addObject:dragModel];
        }
        //NSLog(@"%@",onSaleData);
        //刷新tableView
        [self.tableView reloadData];

    } failure:^(LSHttpRequestManager *manager, NSError *error) {
        NSLog(@"错误信息:%@",error);

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
    return onSaleDatas.count;
}

#pragma mark - cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSDragDesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LSDragModel *dragModel = [onSaleDatas objectAtIndex:indexPath.row];
    
    //赋值
    [cell setModel:dragModel];
    return cell;
}

#pragma mark -UITableViewDelegate

#pragma mark - 选中单元格师调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDetailController *dragDetailVC = [[LSDetailController alloc] init];
    
    //设置导航栏标题
    LSDragModel *dragModel = onSaleDatas[indexPath.row];
    dragDetailVC.navigationItem.title = dragModel.title;
    
    //传药品数据模型
    dragDetailVC.dragModel = dragModel;
    
    [self.navigationController pushViewController:dragDetailVC animated:YES];
}

@end
