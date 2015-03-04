//
//  GenericModel.h
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  通用数据模型
 * 首页,明星,美容,生活,视觉
 
 */
@interface GenericModel : NSObject

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

+(GenericModel *)modelWithDic:(NSDictionary *)dic;

-(id)initWithDic:(NSDictionary *)dic;

@end

/*
 "type": "small",
 "title_position": "",
 "icon": "http://qqssbb.cms.handleader.com/upload//day_140814/201408140936510_home_iphone4.jpg",
 "id": "1986",
 "title": "底妆清透看得见 1分钟上妆你能做到吗？",
 "des": "",
 "adddate": "2014-08-14",
 "timestamp": "1407980352",
 "buy": "0",
 "tag": ""
 
 */

/*
 显示相册的数据模型：2时装，5视觉
 key author不要，undefinekey来出来
 {
// "icon": "http://qqssbb.cms.handleader.com/upload//day_140626/201406261031120.jpg",
// "title": "Carven 2015春夏 Carven 拼接衬衫",
// "author": "",
// "des": "Carven 2015春夏 Carven 拼接衬衫",
// "id": "1906"
 },
 */
