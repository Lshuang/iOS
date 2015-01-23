//
//  LSTwoDetailController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSTwoDetailController.h"

//网络请求管理类
#import "LSHttpRequestManager.h"

//导入药品数据模型
#import "LSDragModel.h"

//导入Cell
#import "LSDragDesCell.h"

//导入药品详情
#import "LSDetailController.h"

@interface LSTwoDetailController ()
{
    //保存分类药品数据
    NSMutableArray *dragDatas;
    
}
@end

@implementation LSTwoDetailController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // 初始化数据源数组
        dragDatas = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化tableview
    [self initTableView];
    
    //请求网络数据
    [self requestData];
    
}

#pragma mark - 初始化二级分类tableview
- (void)initTableView
{
    //初始化tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 120;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LSDragDesCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - 请求数据二级分类
- (void)requestData
{
    [[LSHttpRequestManager shareManager] requestSecondDetailDataWithCid:_cid success:^(LSHttpRequestManager *manager, id model) {
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
            [dragDatas addObject:dragModel];
        }
        //NSLog(@"%@",detailData);
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
    return dragDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSDragDesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LSDragModel *dragModel = [dragDatas objectAtIndex:indexPath.row];
    
    //赋值
    [cell setModel:dragModel];
    
    return cell;
}

#pragma mark -UITableViewDelegate
#pragma mark -选中二级分类某个单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDetailController *dragDetailVC = [[LSDetailController alloc] init];
    
    //设置导航栏标题
    LSDragModel *dragModel = dragDatas[indexPath.row];
    dragDetailVC.title = dragModel.title;
    
    //传药品数据模型
    dragDetailVC.dragModel = dragModel;
    
    [self.navigationController pushViewController:dragDetailVC animated:YES];
}

@end
