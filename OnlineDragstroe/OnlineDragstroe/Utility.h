//
//  Utility.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/**
 /根据图片名返回图片原图
 */
+ (UIImage *)getTabBarItemImageWithImageName:(NSString *)imageName;

/**
 根据所给字符串返回文字所占高度
 */
+ (CGFloat)getTextHeightWithText:(NSString *)text;

/**
 修改图片尺寸
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 初始化导航栏返回键
 */
+ (UIButton *)initNavigationBarItemWithText:(NSString *)text imageName:(NSString *)imageName;

@end
