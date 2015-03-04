//
//  WebViewController.h
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface WebViewController : DetailViewController

@property (nonatomic,strong) NSString    *article_id;

@property (nonatomic,strong) id    model;

@property (nonatomic,assign) int   modelType;

@property(nonatomic,strong)  NSString *urlIdentifier;

@end
