//
//  LSDragDesCell.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-21.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDragModel.h"

@interface LSDragDesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dragDesImageView;
@property (weak, nonatomic) IBOutlet UILabel *dragNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dragFunctionLabel;

//赋值
- (void)setModel:(LSDragModel *)dragModel;

@end
