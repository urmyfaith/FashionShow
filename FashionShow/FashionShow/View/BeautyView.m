//
//  BeautyView.m
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautyView.h"
#import "BeautySmallVIew.h"
#import "BeautyLeftView.h"
#import "BeautyRightView.h"
#import "BeautyModel.h"

//代理


#define defaultRowHeight 140.0f
#define gapBetweenRow 2.0f

@interface BeautyBaseView ()

@end


@implementation BeautyView
{
    id _viewController;
}
-(id)initWithViewController:(id)viewController{
    if (self = [super init]) {
        //
        _viewController = viewController;
    }
    return self;
}

/**
 *      
 //记录高度,每绘制一行,总高度更新;
 //遍历数组,如果是small图片,取出连续三个,绘制一行
 //如果是大图片,取出数据,绘制一行
 //如果是左边,绘制左侧
 //如果是右侧,绘制右侧
 *
 *  @return self
 */
-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

-(void)drawBeautyView{
    
    self.currentHeight = 0;
    for (int i = 0 ; i < self.models_array.count; i++) {
        BeautyModel *bm = [self.models_array objectAtIndex:i];
        
        //NSLog(@"i=%d bm.type=%@ bm.title_positon=%@",i,bm.type,bm.title_position);
        
        if ([bm.type isEqualToString:@"small"]) {
            //取出三个,绘制一行
            //取出i,i+1,i+2三个数据,构成数组,赋值给模型
            
            /**
             *  1.创建View
             *  2.准备数据
             *  3.绘制控件
             *  4.调整frame
             */
            
            BeautySmallView *bsv = [[BeautySmallView alloc]init];
            bsv.delegate = _viewController;
            bsv.models_array  = [[NSArray alloc]initWithObjects:self.models_array[i],
                                 self.models_array[i+1],
                                 self.models_array[i+2],
                                 nil];
            bsv.indexs_array = [[NSArray alloc]initWithObjects:@(i),@(i+1),@(i+2),nil];
            bsv.OneRowViewWidth = self.frame.size.width;
            bsv.OneRowViewHeight = defaultRowHeight;
            
            bsv.frame = CGRectMake(0, self.currentHeight + gapBetweenRow, self.frame.size.width,defaultRowHeight);
            
            [bsv drawOneRowView];
            [self addSubview:bsv];
            
            i = i+2;
            self.currentHeight += defaultRowHeight + gapBetweenRow;
            //NSLog(@"%s [LINE:%d] self.currentHeight=%.f", __func__, __LINE__,self.currentHeight);
        }
        if ([bm.type isEqualToString:@"big"]) {
            //绘制大图
            
            NSArray *tempModelsArray  = [[NSArray alloc]initWithObjects:self.models_array[i], nil];
            NSArray *tempIndexsArray  = [[NSArray alloc]initWithObjects:@(i), nil];
            if ([bm.title_position isEqualToString:@"left"]) {
                //文字左侧
                BeautyLeftView *blv = [[BeautyLeftView alloc]init];
                blv.delegate = _viewController;
                blv.models_array = tempModelsArray;
                blv.indexs_array = tempIndexsArray;
                blv.OneRowViewWidth = self.frame.size.width;
                blv.OneRowViewHeight = defaultRowHeight;
                
                blv.frame = CGRectMake(0, self.currentHeight + gapBetweenRow, blv.OneRowViewWidth,blv.OneRowViewHeight);
                [blv drawOneRowView];
                [self addSubview:blv];
            }
            if ([bm.title_position isEqualToString:@"right"]) {
                //文字右侧
                
                BeautyRightView *brv = [[BeautyRightView alloc]init];
                brv.delegate = _viewController;
                brv.models_array = tempModelsArray;
                brv.indexs_array = tempIndexsArray;
                
                brv.OneRowViewWidth = self.frame.size.width;
                brv.OneRowViewHeight = defaultRowHeight;
                
                brv.frame = CGRectMake(0, self.currentHeight + gapBetweenRow, brv.OneRowViewWidth,brv.OneRowViewHeight);
                [brv drawOneRowView];
                [self addSubview:brv];
            }
            self.currentHeight += defaultRowHeight + gapBetweenRow;
        }
    }
}


@end
