//
//  CommentIteModel.m
//  FashionShow
//
//  Created by zx on 15/2/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "CommentIteModel.h"

@implementation CommentIteModel


+(CommentIteModel *)modelWithDic:(NSDictionary *)dic{
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
    return [NSString stringWithFormat:@"uid=%@, name=%@, content=%@, adddate=%@",_uid,_name,_content,_adddate];
}

@end
