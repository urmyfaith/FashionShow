//
//  FashionCell.h
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXWaterflowViewCell.h"

@class FashionModel,ZXWaterflowView;

@interface FashionCell : ZXWaterflowViewCell

@property (nonatomic,strong) UIImageView    *imageView;

@property (nonatomic,strong) FashionModel    *fashionModel;

+(instancetype)cellWithWaterflowView:(ZXWaterflowView *)waterflowView;

@end
