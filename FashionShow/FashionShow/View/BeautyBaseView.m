//
//  BeautyBaseView.m
//  FashionShow
//
//  Created by zx on 15/2/28.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautyBaseView.h"

@implementation BeautyBaseView

-(void)drawOneRowView{
    //让子类自己实现自己的方法

}

#pragma mark ---lazy_load_array

-(NSArray *)models_array{
    if (nil == _models_array) {
        _models_array = [[NSArray alloc]init];
    }
    return _models_array;
}

-(NSArray *)indexs_array{
    if (nil == _indexs_array) {
        _indexs_array = [[NSArray alloc]init];
    }
    return _indexs_array;
}

@end
