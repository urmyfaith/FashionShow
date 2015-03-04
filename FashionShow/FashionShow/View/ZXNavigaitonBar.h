//
//  ZXNavigaitonBar.h
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXNavigaitonBar : UIView

//首页,明星,时装,美容,生活,视觉
//设置,我的收藏,评论,写评论
/**
 *  自定义导航条
 *
 *  @param titleImageName  中间的图片
 *  @param isTopPage       是否添加top图片
 *  @param titleName       中间的标题
 *  @param backgroundImage 背景图片
 *  @param leftBtnImage    左侧图片
 *  @param rightBtnImage   右侧图片
 *  @param classObject     类
 *  @param sel             方法
 */
-(void)createMyNavigaitonBarWithTitleImag:(NSString *)titleImageName
                                 andIsTop:(BOOL)isTopPage
                             andTitleName:(NSString *)titleName
                       andBackgroundImage:(NSString *)backgroundImage
                     andLeftBtnImagesName:(NSString *)leftBtnImage
                    andRightBtnImagesName:(NSString *)rightBtnImage
                                 andClass:(id)classObject
                                   andSEL:(SEL)sel;

@end
