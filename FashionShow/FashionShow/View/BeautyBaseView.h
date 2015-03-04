//
//  BeautyBaseView.h
//  FashionShow
//
//  Created by zx on 15/2/28.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

/*==========数据模型===========*/
#import "BeautyModel.h"

/*==========图片下载===========*/
#import "UIImageView+WebCache.h"


@protocol BeautyOneRowViewDelegate <NSObject>

@required
-(void)clickedOneRowViewAtIndex:(NSNumber *)index;
@end


/**
 * 绘制一行View的基类
 *
 *  三张小图==>一行View
 *  左侧图===> 一行View
 *  右侧图===>一行View
 *
 *  共有的属性:行高,行宽,模型数组,索引数组
 *  共有的方法:绘制一行View
 *
 *  [注意]代理,单击一个视图,需要返回单击的索引号,使用代理方法来返回.
 */
@interface BeautyBaseView : UIView

@property (nonatomic,assign) CGFloat  OneRowViewHeight;
@property (nonatomic,assign) CGFloat  OneRowViewWidth;

@property (nonatomic,strong) NSArray  *models_array;
@property (nonatomic,strong) NSArray  *indexs_array;

@property (nonatomic,weak) __weak id  delegate;

-(void)drawOneRowView;

@end
