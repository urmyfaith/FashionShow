//
//  ZXVersionView.m
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXVersionView.h"

@interface ZXVersionView ()<ZXWaterflowViewDelegate,ZXWaterflowViewDataSource>

@end

@implementation ZXVersionView
{
    ZXWaterflowView *_waterflowView;
}

-(void)drawView{
    [self removeAllSubViewInView:self];
    if(self.modelsArray.count > 0){
        [self createWaterfallFlow];
    }else{
        [self createTipsViewInView:self];
    }
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
    return self.modelsArray.count;
}

-(ZXWaterflowViewCell *)waterflowView:(ZXWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index{
    static NSString *identifier = @"collection_Version";
    
    ZXRecordModel *rm = (ZXRecordModel *)[self.modelsArray objectAtIndex:index];
    
    CGFloat imageHeight = rm.favouriteImageHeight;
    NSString *imageURL = rm.article_image_link;
    
    ZXWaterflowViewCell *cell = [waterflowView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZXWaterflowViewCell alloc]initWithFrame:CGRectMake(0, 0, 155.0f, imageHeight)];
        UIImageView *imageVeiw = [[UIImageView alloc]initWithFrame:cell.bounds];
        imageVeiw.tag = 10001;
        [cell addSubview:imageVeiw];
    }
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:10001];
    
    ZKDataCache *dataCache = [ZKDataCache sharedInstance];
    [dataCache setImageOfImageView:imageView withImageCacheOrDownloadFromURL:imageURL];
    return cell;
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

-(NSUInteger)numberOfColumnsInWaterflowView:(ZXWaterflowView *)waterflowView{
    
    return 2;
}

-(CGFloat)waterflowView:(ZXWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index{
    ZXRecordModel *rm = (ZXRecordModel *)[self.modelsArray objectAtIndex:index];
    return rm.favouriteImageHeight;
}

-(void)waterflowView:(ZXWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index{
   [self.delegate pushToViewControllerWithRecoredModel:[self.modelsArray  objectAtIndex:index]];
}
@end
