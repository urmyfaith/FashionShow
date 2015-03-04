//
//  JSON2Model.m
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "JSON2Model.h"

/*==========通用数据模型:明星===========*/
#import "GenericModel.h"

/*==========评论数据模型===========*/
#import "CommentModel.h"

/*==========时装:美搭,导购===========*/
#import "FashionModel.h"

/*==========美容 数据模型===========*/
#import "BeautyModel.h"

@implementation JSON2Model

+(NSArray *)JSONData2ModelWithURLIdentifier:(NSString *)urlIdentifier andDataType:(int)dataType{
    
    
    NSData *data = [[DownloadManager sharedDownloadManager]getDownloadDataWithURLIdentifier:urlIdentifier];
    
#if 0
    //调试语句
    
    NSString *data_string  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%s [LINE:%d] data_string=%@", __func__, __LINE__,data_string);
#endif
    
    
    NSDictionary *root_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//  NSLog(@"%s [LINE:%d dic=%@]", __func__, __LINE__,root_dic);
    
    NSMutableArray *models_array = [[NSMutableArray alloc]init];
    
    switch (dataType) {
        case zxJSON_DATATYPE_GENERIC:
            {
                //解析数据
                NSArray *list_array = root_dic[@"list"];
                for (NSDictionary *dic in list_array) {
                    GenericModel *gm  =  [GenericModel modelWithDic:dic];
                    [models_array addObject:gm];
                }
            }
            break;
        case zxJSON_DATATYPE_SPECIAL:
            {
                //解析美搭,导购数据
                NSArray *list_array = root_dic[@"list"];
                for (NSDictionary *dic in list_array) {
                    FashionModel *fm  =  [FashionModel fashionModelWithDic:dic];
                    [models_array addObject:fm];
                }
            }
            break;
        case zxJSON_DATATYPE_COMMENT:
            {
                //解析评论
                CommentModel *cm = [CommentModel modelWithDic:root_dic];
                [models_array addObject:cm];
            }
            break;
        case zxJSON_DATATYPE_BEAUTYPAGE:
            {
                //解析Beauty页面的数据
                NSArray *list_array = root_dic[@"list"];
                for (NSDictionary *dic in list_array) {
                    BeautyModel *bm  =  [BeautyModel beautyModelWithDic:dic];
                    [models_array addObject:bm];
                }
            }
            break;
        //移除default,这样在dataType不存在的时候,程序崩溃,方便改错.
//        default:
//            break;
    }
    return models_array;
}

@end
