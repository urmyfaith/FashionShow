//
//  PhotosViewController.h
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailViewController.h"

@interface PhotosViewController : DetailViewController

//跳转过来到页面的id，
@property(nonatomic,strong)NSString *gid;

@property (nonatomic,assign)    zxDBRecordType    type;

//数据模型
@property (nonatomic,strong) id    model;

@property (nonatomic,assign) int   modelType;

@property(nonatomic,strong)NSMutableArray *dataSource_mArray;//存储模型数组

@property(nonatomic,assign)NSUInteger currentPage;

@property (nonatomic,assign)  CGFloat    favouriteImageHeight;//用于图片收藏
@property (nonatomic,assign)  NSString   *favouriteImageURL;//用用于图片收藏,图片的链接地址-->key

@property(nonatomic,strong)    NSString *urlIdentifier;//下载地址（浏览器中使用的时候，需要添加问号）
@end
