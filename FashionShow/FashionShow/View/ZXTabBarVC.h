//
//  ZXTabBarVC.h
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *
 *  底部的标签栏:明星,时装,美容,生活,视觉
 */

@interface ZXTabBarVC : UITabBarController

@property(nonatomic,strong)    UIView *customTabBar;

@property (nonatomic,strong)  NSMutableArray   *viewConrollers_mArray;
+(ZXTabBarVC *)sharedZXTabBarViewController;

@end
