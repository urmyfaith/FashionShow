//
//  FashionCell.m
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "FashionCell.h"

/*==========瀑布流===========*/
#import "ZXWaterflowViewCell.h"
#import "ZXWaterflowView.h"

/*==========自定义cell的模型===========*/
#import "FashionModel.h"

/*==========图片下载===========*/
#import "UIImageView+WebCache.h"


@implementation FashionCell


/**
 *  自定义控件的[创建]
 *
 *  @param frame frame
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

/**
 *  工具方法
 *
 *  @param waterflowView 瀑布流
 *
 *  @return id
 */
+(instancetype)cellWithWaterflowView:(ZXWaterflowView *)waterflowView{
    static NSString *identifier = @"cell_identifier";
    
    FashionCell *cell = [waterflowView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[FashionCell alloc]init];
        cell.identifier = identifier;
    }
    return cell;
}


/**
 *  通过传入模型,给cell赋值
 *
 *  @param fashionModel 模型
 */
-(void)setFashionModel:(FashionModel *)fashionModel{
    _fashionModel = fashionModel;
    [self.imageView setImageWithURL:[NSURL URLWithString:fashionModel.icon]
                   placeholderImage:[UIImage imageNamed:@"缺省图1"]];
}

//调整控件的frame
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}


@end
