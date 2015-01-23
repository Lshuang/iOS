//
//  LSDragModel.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDragModel : NSObject

/**
 cid
 */
@property (nonatomic, copy) NSString *cid;

/**
 discount
 */
@property (nonatomic, copy) NSString *discount;

/**
 药品功效
 */
@property (nonatomic, copy) NSString *gongxiao1;

/**
 药品功效高度
 */
@property (nonatomic,assign) CGFloat contentHeight;

/**
 图片itemid
 */
@property (nonatomic, copy) NSString *itemid;

/**
 链接
 */
@property (nonatomic, copy) NSString *linkurl;

/**
 price
 */
@property (nonatomic, copy) NSString *price;

/**
 药品包装盒图片
 */
@property (nonatomic, copy) NSString *thumb;

/**
 药品名
 */
@property (nonatomic, copy) NSString *title;

/**
 用户名
 */
@property (nonatomic, copy) NSString *username;

@end
