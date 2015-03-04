//
//  GenericModel.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "GenericModel.h"

@implementation GenericModel

+(GenericModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
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


/*
 @property (nonatomic,strong) NSString    *type;
 @property (nonatomic,strong) NSString    *title_position;
 @property (nonatomic,strong) NSString    *icon;
 @property (nonatomic,strong) NSString    *id;
 @property (nonatomic,strong) NSString    *title;
 @property (nonatomic,strong) NSString    *des;
 @property (nonatomic,strong) NSString    *adddate;
 @property (nonatomic,strong) NSString    *timestamp;
 @property (nonatomic,strong) NSString    *buy;
 @property (nonatomic,strong) NSString    *tag;
 */

-(NSString *)description{
    return [NSString stringWithFormat:@"type=%@, title_position=%@, \
            icon=%@, id=%@, title=%@, des=%@, \
            adddate=%@, timesstamp=%@, buy=%@, \
            tag=%@\n",
            _type,_title_position,_icon,
            _id,_title,_des,
            _adddate,_timestamp,_buy,
            _tag];
}

@end
