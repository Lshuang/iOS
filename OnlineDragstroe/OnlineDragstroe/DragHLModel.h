//
//  DragHLModel.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//  drag homelist model

#import <Foundation/Foundation.h>

@interface DragHLModel : NSObject

/**
 catid
 */
@property (nonatomic, copy) NSString *catid;

/**
  药品分类
 */
@property (nonatomic, copy) NSString *catname;

/**
 cid
 */
@property (nonatomic, copy) NSString *cid;

/**
 链接
 */
@property (nonatomic, copy) NSString *linkurl;

/**
 分类药品描述
 */
@property (nonatomic, copy) NSString *seo_description;

@end
