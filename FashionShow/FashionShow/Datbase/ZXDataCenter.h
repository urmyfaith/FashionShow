//
//  ZXDataCenter.h
//  FashionShow
//
//  Created by zx on 15/3/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXRecordModel;

/**
 *  数据中心,存储模型数据;
 */
@interface ZXDataCenter : NSObject

+(id)sharedDB;

//添加记录
-(BOOL)addRecordWithModel:(ZXRecordModel *)model;

//删除记录
-(BOOL)deleteRecordWithModel:(ZXRecordModel *)model;

//查询所有的记录
-(NSArray *)getAllRecordsWithRecordType:(zxDBRecordType )type;

//是否在数据库中
-(BOOL)isInDataBaseWithModel:(ZXRecordModel *)model;

@end
