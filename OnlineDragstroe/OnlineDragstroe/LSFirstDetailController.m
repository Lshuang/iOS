//
//  LSFirstDetailController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSFirstDetailController.h"

//导入LSTwoDetailController
#import "LSTwoDetailController.h"

//导入LSCollectionViewCell的头文件
#import "LSCollectionViewCell.h"

//网络请求管理类
#import "LSHttpRequestManager.h"

//导入药品数据模型
#import "DragHLModel.h"

//导入异步加载图片类
#import "UIImageView+AFNetworking.h"

@interface LSFirstDetailController ()
{
    NSMutableArray *detailData; //保存小分类下的数据
}

@end

@implementation LSFirstDetailController

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
    
    //初始化数据源
    detailData = [NSMutableArray array];
    
    //初始化布局UICollectionView
    [self initCollectionView];
    
    //请求数据
    [self requestData];
}

#pragma mark - 请求首页分类数据
- (void)requestData
{
    //请求数据
    [[LSHttpRequestManager shareManager] requestDetailDataWithCid:_cid success:^(LSHttpRequestManager *manager, id model) {
        NSArray *array = model;

        for (NSDictionary *dic in array) {
            DragHLModel *dragModel = [[DragHLModel alloc] init];
            dragModel.catid = dic[@"catid"];
            dragModel.catname = dic[@"catname"];
            dragModel.cid = dic[@"cid"];
            dragModel.linkurl = dic[@"linkurl"];
            
            //添加到数据源
            [detailData addObject:dragModel];
        }
        //NSLog(@"%@",detailData);
        //刷新collectionView
        [self.collectionView reloadData];
        
    } failure:^(LSHttpRequestManager *manager, NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];

}

#pragma mark - 布局UICollectionView
- (void)initCollectionView
{
    //设置collectionView背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"LSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
#pragma mark - 选中某个item调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSTwoDetailController *secondDetailVC = [[LSTwoDetailController alloc] init];
    
    //传值
    DragHLModel *dragModel = detailData[indexPath.row];
    
    //传药品cid
    secondDetailVC.cid = dragModel.catid;
    //传返回键标题
    secondDetailVC.catname = self.navigationItem.title;
    //导航栏标题
    secondDetailVC.title = dragModel.catname;
    
    //跳转
    [self.navigationController pushViewController:secondDetailVC animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return detailData.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //设置显示内容窗口颜色
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    DragHLModel *dragModel = detailData[indexPath.row];
    //获得图片地址
    NSString *imageUrlString = [NSString stringWithFormat:kListImageUrl,dragModel.catid];
    [cell.CategoryImageView setImageWithURL:[NSURL URLWithString:imageUrlString]];
    cell.categoryNameLabel.text = dragModel.catname;
    
    return cell;
}

@end
