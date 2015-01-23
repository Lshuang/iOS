//
//  HomeListCell.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-16.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeListCell : UITableViewCell
/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
/**
 分类
 */
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
/**
 分类描叙
 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
