//
//  ZXTabBarVC.m
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXTabBarVC.h"
#import "BaseViewController.h"
#import "SettingViewController.h"
#import "ZXNavigaitonBar.h"

@interface ZXTabBarVC ()

@end

/**
 *  自定义tabBar
 1.新建vc,继承自UITabBarController
 2.将原来的隐藏
 3.创建自定义的按钮,图片,文字
 a)按钮==>页面跳转
 b)图片
 4.用自定义tabBar替换掉系统的tabBar
 */

/**
 *
 *  底部的标签栏:明星,时装,美容,生活,视觉
 */
@implementation ZXTabBarVC
{
    NSArray *_unSelectedImages;
    NSArray *_selectedImages;
    int _tabBarItems_count;
    NSArray *_viewControllers;
   // NSMutableArray *_viewConrollers_mArray;
}

+(ZXTabBarVC *)sharedZXTabBarViewController{
    static ZXTabBarVC *_sharedTabBarVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTabBarVC = [[ZXTabBarVC alloc]init];
      //  [_sharedTabBarVC createTabBar];
    });
    return _sharedTabBarVC;
}


-(void)createTabBar{
    self.tabBar.hidden = YES;
    
    CGFloat tabBarHeight = 49.0f;
    
    _customTabBar = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                            self.view.frame.size.height-tabBarHeight,
                                                            self.view.frame.size.height,
                                                            tabBarHeight)];
    _customTabBar.backgroundColor = [UIColor colorWithRed:0.59f green:0.59f blue:0.60f alpha:0.1f];
    _unSelectedImages = @[@"明星_1",@"时装_1",@"美容_1",@"生活_1",@"视觉_1"];
    _selectedImages = @[@"明星_2",@"时装_2",@"美容_2",@"生活_2",@"视觉_2"];
    
    _tabBarItems_count = [_unSelectedImages count];
    
    
    CGFloat button_width = self.view.frame.size.width/_tabBarItems_count;
    CGFloat button_heigth = tabBarHeight;
    CGFloat yPos =  0 ;
    
    for (int index = 0 ; index < _tabBarItems_count; index++) {
        
        CGFloat xPos = button_width * index;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xPos, yPos, button_width, button_heigth);
        [button setImage:[UIImage imageNamed:_unSelectedImages[index]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_selectedImages[index]] forState:UIControlStateSelected];
        button.tag  = index + zxZXTabBarVCButtonBaseTag;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customTabBar addSubview:button];
        
        if (index == 0) {
            [button setSelected: YES];
        }
    }
    [self.view addSubview:_customTabBar];
    
    _viewConrollers_mArray = [[NSMutableArray alloc]init];
    _viewControllers= @[@"StarViewController",@"FashionViewController",
                        @"BeautyViewController",@"LifeViewController",@"VisualViewController"];
    
    for (int index = 0 ; index < _viewControllers.count; index++) {
        BaseViewController *bvc =  (BaseViewController *) [[NSClassFromString(_viewControllers[index]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:bvc];
        //隐藏上面的系统的导航栏
        nav.navigationBarHidden = YES;
        [_viewConrollers_mArray addObject:nav];
    }
    self.viewControllers =_viewConrollers_mArray;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createTabBar];
}

-(void)buttonClick:(UIButton *)button{
    int button_selected_index = (int)button.tag -zxZXTabBarVCButtonBaseTag;
    
    self.selectedIndex = button_selected_index;
    //或者下面的这句,选中指定的标签
    //self.selectedViewController = [self.viewControllers objectAtIndex:button_selected_index];
    
    for (int i = 0 ; i < _tabBarItems_count; i++) {
         UIButton *tempButton = (UIButton *)[self.view viewWithTag:(zxZXTabBarVCButtonBaseTag+i)];
        if (button_selected_index == i ) {
            [tempButton setSelected:YES];
        }
        else{
            [tempButton setSelected:NO];
        }
    }
}

@end
