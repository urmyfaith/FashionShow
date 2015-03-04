//
//  CommentModel.m
//  FashionShow
//
//  Created by zx on 15/2/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "CommentModel.h"
#import "CommentIteModel.h"

@implementation CommentModel


+(CommentModel *)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        
        //数组初始化
        _list = [[NSMutableArray alloc]init];
        
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            if ([key isEqualToString:@"list"]) {
                NSArray *listArray = dic[@"list"];
                if (listArray.count > 0 ) {
                    for (NSDictionary *list_dic in listArray) {
                        CommentIteModel *cim = [[CommentIteModel alloc]initWithDic:list_dic];
                        [_list addObject:cim];
                    }
                }
            }
            else{
                [self setValue:dic[key] forKey:key];
            }
        }
        //[self setValuesForKeysWithDictionary:dic];
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
    return [NSString stringWithFormat:@"code=%@, msg=%@, def=%@, list=%@",_code,_msg,_def,_list];
}

@end
