//
//  ZXImageView.m
//  FashionShow
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXImageView.h"

@implementation ZXImageView

-(CGRect)originalFrame{
    return self.frame;
}

/*
 重写init方法，添加图片缩放的方法，并且可以传入：
    一个对象（这里用这个对象作为协议的代理方法的实现；
    传入一个方法，在缩放的时候下执行，Target—Action
 */
-(instancetype)initWithObject:(id)obj andSelectors:(NSDictionary *)sels_dic{
    
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        
#pragma mark 缩放，
        UIPinchGestureRecognizer *pinch =[[ UIPinchGestureRecognizer alloc]initWithTarget:obj
                                                                                   action:NSSelectorFromString([sels_dic objectForKey:@"pinch"])];

        [self addGestureRecognizer:pinch];
        pinch.delegate = obj;
        
#pragma mark 单击手势
        UITapGestureRecognizer  *tap =  [[UITapGestureRecognizer alloc]initWithTarget:obj
                                                                               action:NSSelectorFromString([sels_dic objectForKey:@"tap"])];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}
@end
