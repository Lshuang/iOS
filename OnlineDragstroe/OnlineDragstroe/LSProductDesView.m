//
//  LSProductDesView.m
//  OnlineDragstroe
//
//  Created by mac on 15-1-22.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#import "LSProductDesView.h"

@implementation LSProductDesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadMyView];
    }
    return self;
}

- (void)loadMyView
{
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
    self.imageView1.image = [UIImage imageNamed:@"zhengpin_ico"];
    [self addSubview:self.imageView1];
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 120, 20)];
    self.label1.text = @"正品产品 品质保障";
    self.label1.font = [UIFont fontWithName:@"Arial" size:13];
    [self addSubview:self.label1];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 10, 20, 20)];
    self.imageView2.image = [UIImage imageNamed:@"fukuan_ico"];
    [self addSubview:self.imageView2];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(195, 10, 120, 20)];
    self.label2.text = @"货到付款 放心安全";
    self.label2.font = [UIFont fontWithName:@"Arial" size:13];
    [self addSubview:self.label2];
    
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 20, 20)];
    self.imageView3.image = [UIImage imageNamed:@"baoyou_ico"];
    [self addSubview:self.imageView3];
    
    self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 40, 120, 20)];
    self.label3.text = @"一个小时 送药上门";
    self.label3.font = [UIFont fontWithName:@"Arial" size:13];
    [self addSubview:self.label3];

    self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 40, 20, 20)];
    self.imageView4.image = [UIImage imageNamed:@"baozhi_ico"];
    [self addSubview:self.imageView4];
    
    self.label4 = [[UILabel alloc] initWithFrame:CGRectMake(195, 40, 120, 20)];
    self.label4.text = @"实名药店 用心推荐";
    self.label4.font = [UIFont fontWithName:@"Arial" size:13];
    [self addSubview:self.label4];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
