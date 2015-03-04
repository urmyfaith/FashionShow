//
//  BaseViewController.h
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "RootViewController.h"

/*==========通用数据模型===========*/
#import "GenericModel.h"

/*==========下拉刷新===========*/
#import "MJRefresh.h"

/*==========UICollectionView===========*/
#import "ZXCustomCVFL.h"
#import "StarCollectionCell.h"

/*==========底部标签栏===========*/
#import "ZXTabBarVC.h"

@interface BaseViewController : RootViewController

@property (nonatomic,strong) NSString    *postURL_action;
@property (nonatomic,strong) NSString    *postURL_sa;
@property (nonatomic,strong) NSString    *postURL_offset;
@property (nonatomic,strong) NSString    *postURL_count;


@end
