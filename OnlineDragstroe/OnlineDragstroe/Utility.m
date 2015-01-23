//
//  Utility.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "Utility.h"

@implementation Utility

//渲染图片
+ (UIImage *)getTabBarItemImageWithImageName:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

//根据所给字符串返回文字所占高度
+ (CGFloat)getTextHeightWithText:(NSString *)text
{
    //判断，如果大于7.0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(250, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
        //NSLog(@"%f",rect.size.height);
        return ceilf(rect.size.height);
    }
    else
    {
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(250, 10000)];
        return ceilf(size.height);
    }
}

+ (UIButton *)initNavigationBarItemWithText:(NSString *)text imageName:(NSString *)imageName
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 30);
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    leftImageView.image = [Utility resizedImage:imageName];
    [backBtn addSubview:leftImageView];
    //[backBtn setBackgroundImage:[UIImage imageNamed:imageName]forState:UIControlStateNormal];
    [backBtn setTitle:@"在线药店" forState:UIControlStateNormal];
     backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 10);
    return backBtn;
}

@end
