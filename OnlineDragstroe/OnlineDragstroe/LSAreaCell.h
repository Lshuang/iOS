//
//  LSAreaCell.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"

@interface LSAreaCell : UITableViewCell

//区域信息介绍
@property (weak, nonatomic) IBOutlet UILabel *areaIntroduceLabel;

//刷新cell数据
- (void)setAreaModel:(AreaModel *)area;
@end
