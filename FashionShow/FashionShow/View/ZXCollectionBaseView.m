//
//  ZXCollectionBaseView.m
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXCollectionBaseView.h"

@implementation ZXCollectionBaseView


-(NSArray *)modelsArray{
    if (_modelsArray == nil) {
        _modelsArray = [[NSArray alloc]init];
    }
    return _modelsArray;
}

-(void)drawView{

}

-(void)removeAllSubViewInView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}


-(void)createTipsViewInView:(UIView *)view{
    UILabel *lable = [[UILabel alloc]initWithFrame:self.bounds];
    lable.text  = @"暂无收藏";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    [view addSubview:lable];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
