//
//  ZXImageView.h
//  FashionShow
//
//  Created by qianfeng on 15/3/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXImageView : UIImageView

@property(nonatomic,assign)CGRect originalFrame;

-(instancetype)initWithObject:(id)obj andSelectors:(NSDictionary *)sels_dic;

@end
