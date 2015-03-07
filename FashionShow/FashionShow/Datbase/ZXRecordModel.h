//
//  ZXRecordModel.h
//  FashionShow
//
//  Created by zx on 15/3/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  数据库 一条记录的数据模型
 */
@interface ZXRecordModel : NSObject
@property (nonatomic,assign) zxDBRecordType  recordType;
@property (nonatomic,strong) NSString    *article_title;
@property (nonatomic,strong) NSString    *article_link;
@property (nonatomic,strong) NSString    *article_id;
@property (nonatomic,strong) NSString    *article_image_link;
@property (nonatomic,assign) CGFloat     favouriteImageHeight;
@end


/**
 
 分析:
 - 对于普通的网页,只需要收藏链接地址和和title ==>WebView传过来的.
 - 对于时装和视觉页面,需要收藏 第一张图片, 和页面的id.
 
 设计数据库:
 1.插入,查询,删除.
 2.字段设计  index(自动增长),类型(WebView/PhotoView),title,link,article_id,image
 3.需要有的方法:
 收藏-->根据类型--->数据查询(是否存在)/插入数据
 显示收藏--->根据类型--->查询数据
 取消收藏--->根据类型和id--->删除数据
 */