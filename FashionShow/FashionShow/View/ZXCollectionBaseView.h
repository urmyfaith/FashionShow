//
//  ZXCollectionBaseView.h
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXRecordModel;

@protocol ZXCollectionBaseViewDelegate <NSObject>

//选中cell后需要跳转到页面,向外传值(数据模型)
@optional
-(void)pushToViewControllerWithRecoredModel:(ZXRecordModel *)model;

@end


@interface ZXCollectionBaseView : UIView

@property (nonatomic,strong) NSArray    *modelsArray;

@property(nonatomic,weak)__weak id<ZXCollectionBaseViewDelegate>delegate;

-(void)drawView;

@end
