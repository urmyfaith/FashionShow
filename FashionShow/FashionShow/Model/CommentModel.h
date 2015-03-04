//
//  CommentModel.h
//  FashionShow
//
//  Created by zx on 15/2/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>


 /*
 {
 "code": "1",
 "msg": "",
 "def": 0,
 "list": [
 {
 "uid": "9268286",
 "name": "达人",
 "content": "小编是女的",
 "adddate": "2013-12-11 17:31"
 },
 {
 "uid": "9268286",
 "name": "达人",
 "content": "小编是男的吗？",
 "adddate": "2013-12-11 17:30"
 },
 */


@interface CommentModel : NSObject


@property (nonatomic,strong) NSString    *code;
@property (nonatomic,strong) NSString    *msg;
@property (nonatomic,strong) NSString    *def;
@property (nonatomic,strong) NSMutableArray     *list;

+(CommentModel *)modelWithDic:(NSDictionary *)dic;

-(id)initWithDic:(NSDictionary *)dic;

@end
