//
//  BeautySmallVIew.m
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautySmallView.h"

#define defaultGapBetweenPic 2.0f

#define tagGapInImageView 5.0f

@implementation BeautySmallView
{
 //todo 触摸方法,存储frame
}

-(instancetype)init{
    if (self = [super init]) {
       
    }
    return self;
}

-(void)drawOneRowView{
    [super drawOneRowView];

    if (0 == self.gapBewtweenPic ) {
        self.gapBewtweenPic = defaultGapBetweenPic;
    }
    CGFloat pictureWidth = (self.OneRowViewWidth - 2*self.gapBewtweenPic)/3;
    
    for (int i = 0 ; i < 3; i++) {
        CGFloat xPos = i*(self.gapBewtweenPic+pictureWidth);
        CGFloat yPos = 0.0f;
        
        UIImageView *imageView  = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(xPos, yPos, pictureWidth, self.OneRowViewHeight);
        BeautyModel *bm = [self.models_array objectAtIndex:i];
        [imageView setImageWithURL:[NSURL URLWithString:bm.icon]
                  placeholderImage:[UIImage imageNamed:@"缺省图2"]];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        
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
            [imageView addSubview:tag_imageView];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s [LINE:%d] ", __func__, __LINE__);
    //todo 判断点击的view的id
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];//坐标系以滚动视图为参考
    

    
    int index = touchPoint.x/(self.frame.size.width/3);
    int tapped_cell_index = [[self.indexs_array objectAtIndex:index] intValue];

    NSLog(@"touch postion: %@  tapped_cell_index=%d",NSStringFromCGPoint(touchPoint),tapped_cell_index);
    
    /**
     单击某个cell之后执行操作: 1.页面的跳转 2.底部标签栏的隐藏
     */
    
    //返回单击的索引号
    if ([self.delegate respondsToSelector:@selector(clickedOneRowViewAtIndex:)]) {
        [self.delegate performSelector:@selector(clickedOneRowViewAtIndex:) withObject:[self.indexs_array objectAtIndex:index]];
    }
}



@end
