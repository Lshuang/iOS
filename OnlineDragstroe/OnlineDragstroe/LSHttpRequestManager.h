//
//  LSHttpRequestManager.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <Foundation/Foundation.h>

//声明一个类：LSHttpRequestManager
@class LSHttpRequestManager;

//定义网络请求成功回调block变量
typedef void(^HttpRequestSuccess)(LSHttpRequestManager *manager, id model);

//定义网络请求失败回调block变量
typedef void(^HttpRequestFailed)(LSHttpRequestManager *manager, NSError *error);

@interface LSHttpRequestManager : NSObject

//单例
+ (LSHttpRequestManager *)shareManager;

#pragma mark - 请求首页分类
- (void)requestHomeCategoryFromNetWorkSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求药品的服务区域
- (void)requestServiceAreaInformationSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求一级分类详情数据
- (void)requestDetailDataWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求二级分类详情数据
- (void)requestSecondDetailDataWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求产品简介
- (void)requestProductBriefDescriptionWithCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求搜索产品
- (void)searchProductByCid:(NSString *)cid success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求所有分类
- (void)requestAllCategoryFromNetWorkSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

#pragma mark - 请求药品的特价药
- (void)requestSpecialPriceProductInformationSuccess:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;

@end
