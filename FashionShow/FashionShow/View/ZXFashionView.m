//
//  ZXFashionView.m
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXFashionView.h"

#import "ZXWaterflowView.h"
#import "ZXWaterflowViewCell.h"


@interface ZXFashionView ()<ZXWaterflowViewDelegate,ZXWaterflowViewDataSource>

@end

#todo 2015-03-07

@implementation ZXFashionView
{
    ZXWaterflowView *_waterflowView;

}


/**
 *  模型数组===>图片数组===>下载图片====>得到图片的高度===>绘制.
 */
-(void)drawView{
    self.backgroundColor = [UIColor yellowColor];
    [self createWaterfallFlow];
}

#pragma mark 绘制瀑布流
-(void)createWaterfallFlow{
    _waterflowView = [[ZXWaterflowView alloc]init];
    _waterflowView.frame = self.bounds;
    _waterflowView.delegate = self;
    _waterflowView.dataSource = self;
    [self addSubview:_waterflowView];
}

#pragma mark ZXWaterflowView Delegate & DataSoucre

-(NSUInteger)numberOfCellsInWaterflowView:(ZXWaterflowView *)waterflowView{
    return 10;
}

-(ZXWaterflowViewCell *)waterflowView:(ZXWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index{

    return nil;
}

-(CGFloat)waterflowView:(ZXWaterflowView *)waterflowView marginForType:(ZXWaterFlowViewMarginType)type{
    switch (type) {
        case ZXWaterFlowViewMarginTypeTop:
            return 0.0f;
        case ZXWaterFlowViewMarginTypeBottom:
            return 0.0f;
        case ZXWaterFlowViewMarginTypeLeft:
            return 0.0f;
        case ZXWaterFlowViewMarginTypeRight:
            return 0.0f;
        case ZXWaterFlowViewMarginTypeColumn:
            return 0.0f;
        case ZXWaterFlowViewMarginTypeRow:
            return 1.0f;
    }
    return 0.0f;
}


-(CGFloat)waterflowView:(ZXWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index{
    return 0.0f;
}

-(void)waterflowView:(ZXWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index{

    
}


@end
