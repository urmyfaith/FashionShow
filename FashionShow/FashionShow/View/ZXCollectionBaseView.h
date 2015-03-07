//
//  ZXCollectionBaseView.h
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXRecordModel.h"
#import "ZKDataCache.h"

/*==========绘制瀑布流===========*/
#import "ZXWaterflowView.h"
#import "ZXWaterflowViewCell.h"

@protocol ZXCollectionBaseViewDelegate <NSObject>

//选中cell后需要跳转到页面,向外传值(数据模型)
@optional
-(void)pushToViewControllerWithRecoredModel:(ZXRecordModel *)model;

@end


@interface ZXCollectionBaseView : UIView

@property (nonatomic,strong) NSArray    *modelsArray;

@property(nonatomic,weak)__weak id<ZXCollectionBaseViewDelegate>delegate;

-(void)drawView;
-(void)removeAllSubViewInView:(UIView *)view;
-(void)createTipsViewInView:(UIView *)view;

@end
