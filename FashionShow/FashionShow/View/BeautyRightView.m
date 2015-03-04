//
//  BeautyRightView.m
//  FashionShow
//
//  Created by zx on 15/2/28.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautyRightView.h"

#define tagGapInImageView 5.0f

#define leftViewWidth self.frame.size.width*2/3

#define labelWidth  80.0f
#define labelHeight 100.0f
#define labelLeftGap  15.0f
#define labelUpGap 25.0f

@implementation BeautyRightView

-(void)drawOneRowView{
    
    BeautyModel *bm = (BeautyModel *)[self.models_array firstObject];
    
    self.userInteractionEnabled = YES;
    

    
    
#pragma mark 绘制左侧侧图片
    UIImageView *rightImage_imageView = [[UIImageView alloc]initWithFrame:
                                         CGRectMake(0,
                                                    0,
                                                    leftViewWidth,
                                                    self.OneRowViewHeight)];
    [rightImage_imageView setImageWithURL:[NSURL URLWithString:bm.icon]
                         placeholderImage:[UIImage imageNamed:@"缺省图"]];
    [self addSubview:rightImage_imageView];
    
#pragma mark 绘制左侧侧图片上的标签图片
    if (![bm.tag isEqualToString:@""]) {
        UIImage *tag_image =  [UIImage imageNamed:@"标签"];
        
        UIImageView *tag_imageView = [[UIImageView alloc]init];
        if ([bm.tag isEqualToString:@"健康"]) {
            tag_imageView.image = [UIImage imageNamed:@"健康"];
        }else if ([bm.tag isEqualToString:@"家居"]){
            tag_imageView.image = [UIImage imageNamed:@"家居"];
        }else if ([bm.tag isEqualToString:@"彩妆"]){
            tag_imageView.image = [UIImage imageNamed:@"彩妆"];
        }else if ([bm.tag isEqualToString:@"护肤"]){
            tag_imageView.image = [UIImage imageNamed:@"护肤"];
        }else if ([bm.tag isEqualToString:@"旅行"]){
            tag_imageView.image = [UIImage imageNamed:@"旅行"];
        }else if ([bm.tag isEqualToString:@"电影"]){
            tag_imageView.image = [UIImage imageNamed:@"电影"];
        }else if ([bm.tag isEqualToString:@"美体"]){
            tag_imageView.image = [UIImage imageNamed:@"美体"];
        }else if ([bm.tag isEqualToString:@"美发"]){
            tag_imageView.image = [UIImage imageNamed:@"健康"];
        }else if ([bm.tag isEqualToString:@"美食"]){
            tag_imageView.image = [UIImage imageNamed:@"美食"];
        }else if ([bm.tag isEqualToString:@"艺术"]){
            tag_imageView.image = [UIImage imageNamed:@"艺术"];
        }else if ([bm.tag isEqualToString:@"音乐"]){
            tag_imageView.image = [UIImage imageNamed:@"音乐"];
        }else if ([bm.tag isEqualToString:@"香水"]){
            tag_imageView.image = [UIImage imageNamed:@"香水"];
        }else{
            NSLog(@"%s [LINE:%d] 需要处理更多标签.", __func__, __LINE__);
            tag_imageView.image = tag_image; //默认的图,无标签文字
        }
        tag_imageView.frame = CGRectMake(tagGapInImageView,
                                         tagGapInImageView,
                                         tag_image.size.width,
                                         tag_image.size.height);
        [rightImage_imageView addSubview:tag_imageView];
    }
    
#pragma mark 绘制右侧文字+背景
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightImage_imageView.frame),
                                                               0,
                                                               leftViewWidth/2,
                                                               self.OneRowViewHeight)];
    leftView.backgroundColor = [UIColor colorWithRed:0.93f green:0.36f blue:0.36f alpha:1.00f];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelLeftGap,
                                                              labelUpGap ,
                                                              labelWidth,
                                                              labelHeight)];
    label.text = bm.title;
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:0.99f green:0.92f blue:0.90f alpha:1.00f];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    [leftView addSubview:label];
    [self addSubview:leftView];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s [LINE:%d] ", __func__, __LINE__);
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];//坐标系以滚动视图为参考
    
    int tapped_cell_index = [[self.indexs_array firstObject] intValue];
    
    NSLog(@"touch postion: %@  tapped_cell_index=%d",NSStringFromCGPoint(touchPoint),tapped_cell_index);
    
    if ([self.delegate respondsToSelector:@selector(clickedOneRowViewAtIndex:)]) {
        [self.delegate performSelector:@selector(clickedOneRowViewAtIndex:)withObject:[self.indexs_array firstObject]];
    }
}


@end
