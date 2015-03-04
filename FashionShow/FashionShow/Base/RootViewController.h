//
//  RootViewController.h
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  引入顶部的自定义导航栏
 */
#import "ZXNavigaitonBar.h"

/**
 *  引入接口
 */
#import "INTERFACE.h"


/**
 *  引入数据解析方法
 */

#import "JSON2Model.h"


/**
 *  引入toast弹出消息提示
 */
#import "iToast.h"

/**
 *  通用网页展示 + 数据模型
 *
 */
#import "WebViewController.h"
#import "GenericModel.h"

/**
 * 滚动时图显示页面 ＋ 
 */

#import "PhotosViewController.h"

@interface RootViewController : UIViewController


-(void)createRootNavigaitonBarWithTitleImag:(NSString * )titleImageName
                                 andIsTop:(BOOL)isTopPage
                             andTitleName:(NSString *)titleName
                       andBackgroundImage:(NSString *)backgroundImage
                     andLeftBtnImagesName:(NSString *)leftBtnImage
                    andRightBtnImagesName:(NSString *)rightBtnImage
                                 andClass:(id)classObject
                                   andSEL:(SEL)sel;


@end
