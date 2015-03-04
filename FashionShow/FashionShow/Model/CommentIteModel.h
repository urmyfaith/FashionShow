//
//  CommentIteModel.h
//  FashionShow
//
//  Created by zx on 15/2/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 "uid": "9268286",
 "name": "达人",
 "content": "小编是男的吗？",
 "adddate": "2013-12-11 17:30"
 },
 */
@interface CommentIteModel : NSObject

@property (nonatomic,strong) NSString    *uid;
@property (nonatomic,strong) NSString    *name;
@property (nonatomic,strong) NSString    *content;
@property (nonatomic,strong) NSString    *adddate;

+(CommentIteModel *)modelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
