//
//  LSSearchProductController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-22.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSSearchProductController.h"

//导入网络请求管理类
#import "LSHttpRequestManager.h"

//导入搜索结果(药品模型)数据模型
#import "LSDragModel.h"

//导入药品的Cell
#import "LSDragDesCell.h"

//导入药品详情界面头文件
#import "LSDetailController.h"

@interface LSSearchProductController ()
{
    //保存搜索出得内容
    NSMutableArray *_dragSearchData;
}
@end

@implementation LSSearchProductController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化数组
    _dragSearchData = [NSMutableArray array];
    
    //初始化tableview
    [self initSearchResultTableView];
    
    //获取数据
    [self getDatas];
}

#pragma mark - 初始化tableview
- (void)initSearchResultTableView
{
    //初始化tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 120;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LSDragDesCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - 获取搜索结果
- (void)getDatas
{
    [[LSHttpRequestManager shareManager] searchProductByCid:self.searchWord success:^(LSHttpRequestManager *manager, id model) {
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
            
            //添加到数组
            [_dragSearchData addObject:dragModel];
        }
        
        //刷新tableview
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
    return _dragSearchData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSDragDesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LSDragModel *searchModel = [_dragSearchData objectAtIndex:indexPath.row];
    
    //赋值
    [cell setModel:searchModel];

    return cell;
}

#pragma mark -UITableViewDelegate
/**
 选中单元格
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDetailController *dragDetailVC = [[LSDetailController alloc] init];
    
    //设置导航栏标题
    LSDragModel *searchModel = _dragSearchData[indexPath.row];
    dragDetailVC.navigationItem.title = searchModel.title;
    
    //传药品数据模型
    dragDetailVC.dragModel = searchModel;
    
    [self.navigationController pushViewController:dragDetailVC animated:YES];
}


@end
