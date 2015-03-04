//
//  FashionModel.m
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "FashionModel.h"

@implementation FashionModel

+(instancetype)fashionModelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
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

-(NSString *)description{
    return [NSString stringWithFormat:@"icon=%@ gid=%@ tiltle=%@ pic_height=%.f timestamp=%@",
            self.icon,
            self.gid,
            self.title,
            self.pic_height,
            self.timestamp];
}


/*
 @property (nonatomic,strong) NSString    *icon;
 @property (nonatomic,strong) NSString    *gid;
 @property (nonatomic,strong) NSString    *title;
 @property (nonatomic,assign) CGFloat     pic_height;
 @property (nonatomic,strong) NSString    *timestamp;
 */
@end
