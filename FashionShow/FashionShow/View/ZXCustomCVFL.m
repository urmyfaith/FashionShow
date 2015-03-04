//
//  ZXCustomCVFL.m
//  FashionShow
//
//  Created by zx on 15/2/12.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXCustomCVFL.h"

@implementation ZXCustomCVFL

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 1; i < [answer count]; ++i) {

        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = 4;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}
@end
