//
//  DetailViewController.h
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

-(void)createButtomViewWithImagesArray:(NSArray *)imagesArray
                              andClass:(id)classObject
                                andSEL:(SEL)sel;

@end

