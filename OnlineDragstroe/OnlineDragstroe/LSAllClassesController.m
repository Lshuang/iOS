//
//  LSAllClassesController.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-22.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSAllClassesController.h"

//网络请求管理类
#import "LSHttpRequestManager.h"

//导入异步加载图片类
#import "UIImageView+AFNetworking.h"

//导入药品数据模型
#import "DragHLModel.h"

//导入LSCollectionViewCell的头文件
#import "LSCollectionViewCell.h"

//导入LSFirstDetailController
#import "LSFirstDetailController.h"

@interface LSAllClassesController ()
{
    //保存所有分类的信息
    NSMutableArray *allClassesData;
}
@end

@implementation LSAllClassesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //设置tabBarItem  collectionView 不能在这里初始化
//        self.title = @"分类";
//        self.tabBarItem.image = [Utility getTabBarItemImageWithImageName:kCategoryItemImage];
//        self.tabBarItem.selectedImage = [Utility getTabBarItemImageWithImageName:kCategoryItemSelectedImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化保存所有分类
    allClassesData = [NSMutableArray array];
    
    //设置标题字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold"  size:15.0f]};
    
    //初始化collectionView
    [self initCollectionView];
    
    //请求获取数据
    [self getDatas];

}

#pragma mark - 初始化collectionView
- (void)initCollectionView
{
    
    //设置collectionView背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"LSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - 请求获取数据
- (void)getDatas
{
    [[LSHttpRequestManager shareManager] requestAllCategoryFromNetWorkSuccess:^(LSHttpRequestManager *manager, id model) {
        NSArray *array = model;
        
        for (NSDictionary *dic in array) {
            DragHLModel *dragModel = [[DragHLModel alloc] init];
            dragModel.catid = dic[@"catid"];
            dragModel.catname = dic[@"catname"];
            dragModel.cid = dic[@"cid"];
            dragModel.linkurl = dic[@"linkurl"];
            
            //添加到数据源
            [allClassesData addObject:dragModel];
        }
        //NSLog(@"%@",detailData);
        //刷新collectionView
        [self.collectionView reloadData];

    } failure:^(LSHttpRequestManager *manager, NSError *error) {
         NSLog(@"错误信息:%@",error);
    }];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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

    LSFirstDetailController *firstDetailVC = [[LSFirstDetailController alloc] initWithCollectionViewLayout:layout];
    
    //传值
    DragHLModel *dragModel = allClassesData[indexPath.row];
    
    //传药品cid
    firstDetailVC.cid = dragModel.catid;
    //传返回键标题
    firstDetailVC.catname = self.navigationItem.title;
    //导航栏标题
    firstDetailVC.navigationItem.title = dragModel.catname;
    
    //跳转
    [self.navigationController pushViewController:firstDetailVC animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return allClassesData.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //设置显示内容窗口颜色
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    DragHLModel *dragModel = allClassesData[indexPath.row];
    //获得图片地址
    NSString *imageUrlString = [NSString stringWithFormat:kListImageUrl,dragModel.catid];
    [cell.CategoryImageView setImageWithURL:[NSURL URLWithString:imageUrlString]];
    cell.categoryNameLabel.text = dragModel.catname;
    
    return cell;
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
