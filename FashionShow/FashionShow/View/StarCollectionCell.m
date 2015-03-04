//
//  StarCollectionCell.m
//  FashionShow
//
//  Created by zx on 15/2/12.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "StarCollectionCell.h"

@implementation StarCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.backgroundView = _imageView;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
