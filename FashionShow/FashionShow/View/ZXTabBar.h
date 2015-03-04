//
//  ZXTabBar.h
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  详细页面的ToolBar:返回前一页,分享,收藏,评论
 */
@interface ZXTabBar : UIView

-(ZXTabBar *)tabBarWithImagesArray:(NSArray *)imagesArray
                          andClass:(id)classObject
                            andSEL:(SEL)sel;

@end
