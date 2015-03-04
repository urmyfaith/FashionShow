//
//  BaseViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
#import "ZXTabBarVC.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    [self createZXNavigationbar];
    
//    ZXTabBarVC *tvc =[ZXTabBarVC sharedZXTabBarViewController];
    
}

-(void)createZXNavigationbar{

    [self createRootNavigaitonBarWithTitleImag:@"logo"
                                  andIsTop:NO
                              andTitleName:nil
                        andBackgroundImage:nil
                      andLeftBtnImagesName:@"top_1"
                     andRightBtnImagesName:@"设置_1"
                                  andClass:self
                                    andSEL:@selector(navigationBarClicked:)];
    
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag  == zxNavigaionBarButtonLeftTag) {
        
  //      [self.navigationController popViewControllerAnimated:YES];
#if 1
     //   self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%s [LINE:%d]", __func__, __LINE__);
 }];
#else
        [self.navigationController popViewControllerAnimated:YES];
#endif
      
    }
    if (button.tag == zxNavigaionBarButtonRightTag) {

        SettingViewController *settingVC = [[SettingViewController alloc] init];
     
        
#if 0
        [self.navigationController pushViewController:settingVC animated:YES];
#else
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:settingVC];
        nav.navigationBar.hidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
#endif
    }
}

@end
