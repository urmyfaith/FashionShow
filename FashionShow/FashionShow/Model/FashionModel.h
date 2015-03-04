//
//  FashionModel.h
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FashionModel : NSObject

@property (nonatomic,strong) NSString    *icon;
@property (nonatomic,strong) NSString    *gid;
@property (nonatomic,strong) NSString    *title;
@property (nonatomic,assign) CGFloat     pic_height;
@property (nonatomic,strong) NSString    *timestamp;

+(instancetype)fashionModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end


/*
 "icon": "http://qqssbb.cms.handleader.com/upload//day_140528/201405281150413_home_iphone4.jpg",
 "gid": "1827",
 "title": "宇舶表2014 年FIFA巴西世界杯™官方手表",
 "pic_height": 281,
 "timestamp": "1401248880"
 */