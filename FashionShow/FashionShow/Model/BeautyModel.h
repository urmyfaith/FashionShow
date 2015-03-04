//
//  BeautyModel.h
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeautyModel : NSObject
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

+(instancetype)beautyModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

/*
 "type": "big",
 "title_position": "right",
 "icon": "http://qqssbb.cms.handleader.com/upload//day_140409/201404091342037_listthumb_iphone4.jpg",
 "id": "1783",
 "title": "定期排毒 106岁宋美龄养颜经",
 "des": "",
 "adddate": "2014-04-09",
 "timestamp": "1397022453",
 "buy": "0",
 "tag": ""
 */
