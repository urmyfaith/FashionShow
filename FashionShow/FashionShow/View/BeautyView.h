//
//  BeautyView.h
//  FashionShow
//
//  Created by zx on 15/2/27.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface BeautyView : UIScrollView

@property (nonatomic,strong) NSArray    *models_array;

@property (nonatomic,assign) CGFloat     currentHeight;

-(void)drawBeautyView;

-(id)initWithViewController:(id)viewController;

@end
