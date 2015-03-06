//
//  ZXDataCenter.m
//  FashionShow
//
//  Created by zx on 15/3/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXDataCenter.h"

#import "FMDatabase.h"

#import "ZXRecordModel.h"


@implementation ZXDataCenter
{
    FMDatabase    *_database;
    BOOL _result;
}


+(id)sharedDB{
    static ZXDataCenter  *_dataCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataCenter = [[ZXDataCenter alloc]init];
        NSLog(@"%s [LINE=%i] createDatabase status=%d",__func__,__LINE__,[_dataCenter createDatabase]);
    });
    return _dataCenter;
}

-(BOOL)createDatabase{
    NSString *dbPath = [NSString stringWithFormat:@"%@/Documents/dataCenter.db",NSHomeDirectory()];
    
    _database = [[FMDatabase alloc]initWithPath:dbPath];
    
    if (_database.open) {
        NSLog(@"%s [LINE=%i]打开数据库成功 ",__func__,__LINE__);
    }
    else{
        NSLog(@"%s [LINE=%i]打开数据库失败 ",__func__,__LINE__);
        return NO ;
    }
    return [self createFavouriteTable];
}

-(BOOL)createFavouriteTable{
    [_database open];
    NSString *sql = @"create table if not exists favourite( id integer primary key autoincrement not null,recordType integer,article_title varchar(100),article_link varchar(100),article_id varchar(100),article_image_link varchar(200));";
    _result = [_database executeUpdate:sql];
    [_database close];
    return _result;
}

-(BOOL)addRecordWithModel:(ZXRecordModel *)model{
    
    [_database open];
    NSString *sql  = @"insert into favourite(recordType,article_title,article_link,article_id,article_image_link) values(?,?,?,?,?);";
    NSInteger recordType = model.recordType;
    NSString *article_title = model.article_title;
    NSString *article_link = model.article_link;
    NSString *article_id = model.article_id;
    NSString *article_image_link = model.article_image_link;
    
    _result = [_database executeUpdate:sql,
               [NSString stringWithFormat:@"%d",model.recordType],
               article_title,
               article_link,
               article_id,
               article_image_link
               ];
    [_database close];
    return _result;
}

-(BOOL)deleteRecordWithModel:(ZXRecordModel *)model{
    [_database open];
    NSString *sql = nil;
    if (model.recordType == zxDBRecordTypeWithWebView) {
         sql  = @"delete from favourite where recordType=? and article_link=?;";
        _result = [_database executeUpdate:sql,
                   [NSString stringWithFormat:@"%d",model.recordType],
                   model.article_link];
    }
    else{
        sql = @"delete from favourite where recordType=? and article_image_link=?;";
        _result = [_database executeUpdate:sql,
                   [NSString stringWithFormat:@"%d",model.recordType],
                   model.article_image_link];
    }
    [_database close];
    return _result;
}

-(BOOL)isInDataBaseWithModel:(ZXRecordModel *)model{
    
    [_database open];
    NSString *sql = nil;
    FMResultSet *set = nil;
    if (model.recordType == zxDBRecordTypeWithWebView) {
        sql = @"select count(*) from favourite where recordType=? and article_link=?;";
        set =  [_database executeQuery:sql,
                [NSString stringWithFormat:@"%d",model.recordType],
                model.article_link];
    }
    else{
        sql =@"select count(*) from favourite where recordType=? and article_image_link=?;";
        set =  [_database executeQuery:sql,
                [NSString stringWithFormat:@"%d",model.recordType],
                model.article_image_link];
    }

    int count = 0 ;
    if ([set next]){
        count = [set intForColumnIndex:0];
    }
    [_database close];
    return count>0;
}

-(NSArray *)getAllRecordsWithRecordType:(zxDBRecordType)type{
    [_database open];
    NSString *sql = @"select * from favourite where recordType=?;";
    FMResultSet *set = [_database executeQuery:sql,
                        [NSString stringWithFormat:@"%d",type]];
    NSMutableArray *mArray = [NSMutableArray array];
    while ([set next]) {
        ZXRecordModel *rm = [[ZXRecordModel alloc]init];
        rm.recordType = type;
        rm.article_title = [set stringForColumn:@"article_title"];
        rm.article_link = [set stringForColumn:@"article_link"];
        rm.article_id = [set stringForColumn:@"article_id"];
        rm.article_image_link = [set stringForColumn:@"article_image_link"];
        [mArray addObject:rm];
    }
    [_database close];
    return mArray;
}

/*
test:
 
 .tables
 .schema favourite
 .mode column
 .header on
 insert into favourite(recordType,article_title,article_link,article_id,article_image_link) values(1,"2","3","4","6");
 select * from favourite where recordType=1;
 */
@end
