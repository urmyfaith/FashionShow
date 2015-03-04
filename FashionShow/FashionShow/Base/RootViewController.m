//
//  RootViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createRootNavigaitonBarWithTitleImag:(NSString * )titleImageName
                                   andIsTop:(BOOL)isTopPage
                               andTitleName:(NSString *)titleName
                         andBackgroundImage:(NSString *)backgroundImage
                       andLeftBtnImagesName:(NSString *)leftBtnImage
                      andRightBtnImagesName:(NSString *)rightBtnImage
                                   andClass:(id)classObject
                                     andSEL:(SEL)sel{
    ZXNavigaitonBar *nb = [[ZXNavigaitonBar alloc]init];
    nb.frame = CGRectMake(0, 0, 320, 64);
    [nb createMyNavigaitonBarWithTitleImag:titleImageName
                                  andIsTop:isTopPage
                              andTitleName:titleName
                        andBackgroundImage:backgroundImage
                      andLeftBtnImagesName:leftBtnImage
                     andRightBtnImagesName:rightBtnImage
                                  andClass:classObject
                                    andSEL:sel];
    
    [self.view addSubview:nb];
}


@end
