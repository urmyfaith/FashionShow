//
//  DetailViewController.m
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "DetailViewController.h"
#import "ZXTabBar.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
}

-(void)createButtomViewWithImagesArray:(NSArray *)imagesArray
                              andClass:(id)classObject
                                andSEL:(SEL)sel{
    ZXTabBar *tb = [[ZXTabBar alloc]init];
    tb.frame = CGRectMake(0, self.view.frame.size.height- 49, self.view.frame.size.width, 49);
    [tb tabBarWithImagesArray:imagesArray andClass:classObject andSEL:sel];
    [self.view addSubview:tb];
}
@end
