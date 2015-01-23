//
//  LSHttpRequestManager.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSHttpRequestManager.h"

//导入接口头文件
#import "NetInterface.h"

//导入网络请求管理器AFHTTPRequestOperationManager
#import "AFHTTPRequestOperationManager.h"


@implementation LSHttpRequestManager

//单例
+ (LSHttpRequestManager *)shareManager
{
    static LSHttpRequestManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LSHttpRequestManager alloc] init];
    });
    return shareInstance;
}

#pragma mark - 请求首页分类
- (void)requestHomeCategoryFromNetWorkSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置解析数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:kHomeListUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *array = [dic objectForKey:@"catlist"];
        
        //请求成功后回传数据
        success (self, array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"%@",error);
        //请求失败回传
        failure (self, error);
    }];

}

#pragma mark - 请求药品的服务区域
- (void)requestServiceAreaInformationSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:kServiceAreaUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // NSLog(@"responseObject:%@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *array = [dic objectForKey:@"catlist"];
        
        //请求成功后回传数据
        success (self, array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回传
        failure (self, error);
    }];
}

#pragma mark - 请求一级分类详情数据
- (void)requestDetailDataWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:kDetailDataUrl,cid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"goodslist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];
    
}

#pragma mark - 请求二级分类详情数据
- (void)requestSecondDetailDataWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:kSecDetailDataUrl,cid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"goodslist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];
}

#pragma mark - 请求产品简介
- (void)requestProductBriefDescriptionWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:kBriefIntroductionUrl,cid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"goodslist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];
}

#pragma mark - 请求搜索产品
- (void)searchProductByCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:kSearchProductUrl,cid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"goodslist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];
}

#pragma mark - 请求所有分类
- (void)requestAllCategoryFromNetWorkSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:kAllCategorysUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"catlist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];

}

#pragma mark - 请求药品的特价药
- (void)requestSpecialPriceProductInformationSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:kSpecialPriceUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject:%@",responseObject);
        
        NSDictionary *dic   = responseObject;
        NSArray      *array = [dic objectForKey:@"goodslist"];
        
        //请求成功回调
        success(self,array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        failure(self,error);
    }];

}

@end
