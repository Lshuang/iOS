//
//  AreaModel.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject

/**
 catid
 */
@property (nonatomic, copy) NSString *catid;

/**
 cid
 */
@property (nonatomic, copy) NSString *cid;

/**
 链接
 */
@property (nonatomic, copy) NSString *linkurl;

/**
 区域信息介绍
 */
@property (nonatomic, copy) NSString *introduce;

/**
 区域信息介绍内容文字高度
 */
@property (nonatomic,assign) CGFloat contentHeight;

/**
 地图路线
 */
@property (nonatomic, copy) NSString *thumb;

/**
 区域名称
 */
@property (nonatomic, copy) NSString *title;

@end
