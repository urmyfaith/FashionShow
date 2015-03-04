//
//  BeautyModel.m
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BeautyModel.h"

@implementation BeautyModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)beautyModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

/**
 *  KVC的时候,防止给不存在的属性赋值
 *
 *  @param value 值
 *  @param key   键
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s [LINE:%d] key=%@", __func__, __LINE__,key);
}
@end
