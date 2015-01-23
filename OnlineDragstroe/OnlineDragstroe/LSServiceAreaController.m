//
//  LSServiceAreaController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-18.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSServiceAreaController.h"

//导入网络请求管理类LSHttpRequestManager
#import "LSHttpRequestManager.h"

//导入区域数据模型
#import "AreaModel.h"

//导入Cell头文件
#import "LSAreaCell.h"

//导入公共类（计算文字高度）

@interface LSServiceAreaController ()
{
    NSMutableArray *AreaData;           //保存区域信息
}
@end

@implementation LSServiceAreaController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"服务区域";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //保存区域信息数组初始化
    AreaData = [NSMutableArray array];
    
    //请求配送区域信息
    [self requestAreaFromNetWork];
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"LSAreaCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - 请求配送区域信息
- (void)requestAreaFromNetWork
{
    [[LSHttpRequestManager shareManager] requestServiceAreaInformationSuccess:^(LSHttpRequestManager *manager, id model) {
        //回传数据为数组
        NSArray *array = model;
        
        for (NSDictionary *dic in array) {
            AreaModel *area = [[AreaModel alloc] init];
            area.catid     = [dic objectForKey:@"catid"];
            area.cid       = [dic objectForKey:@"cid"];
            area.linkurl   = [dic objectForKey:@"linkurl"];
            area.introduce = [dic objectForKey:@"introduce"];
            area.contentHeight = [Utility getTextHeightWithText:area.introduce];
            area.thumb     = [dic objectForKey:@"thumb"];
            area.title     = [dic objectForKey:@"title"];
            
            //添加区域数据到数组
            [AreaData addObject:area];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaModel *area = [AreaData objectAtIndex:indexPath.row];
    return area.contentHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return AreaData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    AreaModel *area = [AreaData objectAtIndex:indexPath.row];
    [cell setAreaModel:area];
    
    return cell;
}

@end
