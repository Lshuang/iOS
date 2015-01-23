//
//  LSAreaCell.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSAreaCell.h"

//导入异步加载图片头文件
#import "UIImageView+AFNetworking.h"

@implementation LSAreaCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setAreaModel:(AreaModel *)area
{
    self.areaIntroduceLabel.text = area.introduce;
    
    //改文字frame大小
    CGRect frame = self.areaIntroduceLabel.frame;
    frame.size.height = area.contentHeight;
    self.areaIntroduceLabel.frame = frame;
    
//    //有图片
//    if (area.thumb) {
//        //显示图片
//        self.areaMapView.hidden = NO;
//        //异步加载图片
//        [self.areaMapView setImageWithURL:[NSURL URLWithString:area.thumb]];
//    }
//    else //没有图片
//    {
//        self.areaMapView.hidden = YES;
//        self.areaMapView.image = nil;
//    }
//    
//    //改图片frame
//    if (area.thumb)
//    {
//        frame = self.areaMapView.frame;
//        frame.origin.y = CGRectGetMaxY(self.areaIntroduceLabel.frame);
//        self.areaMapView.frame = frame;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
