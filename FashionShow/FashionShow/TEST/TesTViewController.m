//
//  TesTViewController.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "TesTViewController.h"
#import "Download.h"
#import "INTERFACE.h"
#import "DownloadManager.h"
#import "NSDate+Transform.h"
#import "ZXNavigaitonBar.h"
#import "ZXTabBar.h"

@interface TesTViewController ()<DownloadDelegate>

@end

@implementation TesTViewController
{

    NSString *_urlIdentifier;
}

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
    
//    [self testAPI];
    
//    [self testDownload];
    
//    [self testDownloadManager];
    
//    [self testNSDateTransform];
    
    [self testZXNavigationbar];
    
//     [self testZXTabBar];
}

#pragma mark 测试testZXTabBar

-(void)testZXTabBar{
    ZXTabBar *tb = [[ZXTabBar alloc]init];
    tb.frame = CGRectMake(0, self.view.frame.size.height- 49, self.view.frame.size.width, 49);
    
    NSArray *imagesArray = @[@"内文返回_1",@"下载_1",@"分享_1",@"收藏_1",@"评论_1"];
    
    [tb tabBarWithImagesArray:imagesArray andClass:self andSEL:@selector(tabbarClicked:)];
    [self.view addSubview:tb];
}

-(void)tabbarClicked:(UIButton *)button{
    NSLog(@"%s [LINE:%d] button.tag = %d", __func__, __LINE__,button.tag);
}



#pragma mark 测试ZXNavigationbar
-(void)testZXNavigationbar{
    ZXNavigaitonBar *nb = [[ZXNavigaitonBar alloc]init];
     nb.frame = CGRectMake(0, 0, 320, 64);
    [nb createMyNavigaitonBarWithTitleImag:@"logo"
                                  andIsTop:YES
                              andTitleName:nil
                        andBackgroundImage:nil
                      andLeftBtnImagesName:@"top_1"
                     andRightBtnImagesName:@"栏目_1"
                                  andClass:self
                                    andSEL:@selector(navigationBarClicked:)];
   
    [self.view addSubview:nb];
    
    
    ZXNavigaitonBar *nb2 = [[ZXNavigaitonBar alloc]init];
    nb2.frame = CGRectMake(0, 64*3, 320, 64);
    [nb2 createMyNavigaitonBarWithTitleImag:nil
                                  andIsTop:NO
                              andTitleName:@"评论"
                        andBackgroundImage:nil
                      andLeftBtnImagesName:@"返回_1"
                     andRightBtnImagesName:nil
                                  andClass:self
                                    andSEL:@selector(navigationBarClicked:)];
    
    [self.view addSubview:nb2];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag  == zxNavigaionBarButtonLeftTag) {
        NSLog(@"%s [LINE:%d]", __func__, __LINE__);
    }
    if (button.tag == zxNavigaionBarButtonRightTag) {
        NSLog(@"%s [LINE:%d]", __func__, __LINE__);
    }
}

#pragma mark 测试分类 NSDate+Transform.h
-(void)testNSDateTransform{
    
    NSString *string = @"1422842994";
    // [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSLog(@"%@",[NSDate transformDateFromIntevalSince1970:string withFormate:@"yyyy/MM/dd HH:mm:ss"]);
    //NSLog(@"%@",[NSDate transformDateFromIntevalSince1970:string withFormate:nil]);
}


#pragma mark 测试下载管理类

-(void)testDownloadManager{
    
    NSString *postData_string = @"action=home&sa=Main&offset=0&count=20&uid=11111111&platform=a&mobile=HUAWEI+P6-C00&pid=10129&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37";
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(managerFinished)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH andDownloadResqustMethod:@"POST"andPostDataString:postData_string];
}

-(void)managerFinished{
    //_focusListItemsArray = [[DownloadManager sharedDownloadManager]getDownloadDataWithDownloadStr:kFOUCS_LIST_URL];
    NSData *data = [[DownloadManager sharedDownloadManager]getDownloadDataWithURLIdentifier:_urlIdentifier];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%s [LINE:%d dic=%@]", __func__, __LINE__,dic);
    //解析为字典
}


#pragma mark 测试接口地址

-(void)testAPI{

    NSLog(@"%@",zxAPI_FULLPATH);
}



#pragma mark 测试下载类

-(void)testDownload{

    
    Download *download = [[Download alloc]init];
    download.downloadURL = zxAPI_FULLPATH;
    download.downloadRequestMethod = @"POST";
    download.postData_String = @"action=home&sa=Main&offset=0&count=20&uid=11111111&platform=a&mobile=HUAWEI+P6-C00&pid=10129&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37";
    download.delegate = self;
    [download startDownloadData];
}
-(void)downloadFinishWithDownload:(Download *)download{

    NSString *string = [[NSString alloc]initWithData:download.downloadData encoding:NSUTF8StringEncoding];
    NSLog(@"%s [LINE:%d] string=%@", __func__, __LINE__,string);
    //解析为字符串

    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:download.downloadData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%s [LINE:%d dic=%@]", __func__, __LINE__,dic);
    //解析为字典
    
}

@end
