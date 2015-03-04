//
//  MainViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "MainViewController.h"
#import "ZXTabBarVC.h"
#import "BaseViewController.h"
#import "MainTableViewCell.h"




@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainViewController
{
    NSString *_urlIdentifier;
    NSArray *_tableViewDataSource_array;
    UITableView *_tabelView;

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

    [self createNavitaionbar];
    
    [self createTableView];
    [self downloadData];

}

#pragma mark 创建表视图
-(void)createTableView{
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              64,
                                                              self.view.frame.size.width,
                                                              self.view.frame.size.height-64)
                                             style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    UIImageView *backgroudImageView  = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroudImageView.image = [UIImage imageNamed:@"背景"];
    _tabelView.backgroundView = backgroudImageView;
    [self.view addSubview:_tabelView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableViewDataSource_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [MainTableViewCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        //调整首行cell: 数字居中,图片大小调整,文本下移.
        cell.mainCell_number_imageView.center = CGPointMake((CGRectGetMaxX(cell.mainCell_number_imageView.frame)+ 5.0f)/2,
                                                            150/2);
        cell.mainCell_picture_imageView.frame = CGRectMake(CGRectGetMaxX(cell.mainCell_number_imageView.frame) + 5.0f,
                                                           0,
                                                           250,
                                                           145);
        cell.mainCell_title_label.frame = CGRectMake(CGRectGetMaxX(cell.mainCell_number_imageView.frame)+ 5.0f + 5.0f,
                                                     CGRectGetMaxY(cell.mainCell_picture_imageView.frame) - 40.0f,
                                                     240,
                                                     40);
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.mainCell_number_imageView.frame)+ 5.0f,
                                                                   CGRectGetMaxY(cell.mainCell_picture_imageView.frame) - 40.0f,
                                                                   250,
                                                                   40)];
        backView.backgroundColor = [UIColor colorWithRed:0.90f green:0.91f blue:0.91f alpha:0.200f];
        [cell.contentView addSubview:backView];
    }
    cell.mainCell_Model = [_tableViewDataSource_array objectAtIndex:indexPath.row];
    cell.mainCell_number_imageView.image = [UIImage imageNamed: [NSString stringWithFormat:@"%02d",(int)indexPath.row+1]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark 页面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *webVC = [[WebViewController alloc]init];
    GenericModel *model = (GenericModel *)[_tableViewDataSource_array objectAtIndex:indexPath.row];
    
    webVC.article_id =  model.id;  //用于webView地址的拼接
    webVC.model = model; //用于收藏webView的时候,展示收藏页面的标题.
    webVC.modelType = zxJSON_DATATYPE_GENERIC; //标记数据模型的类型
    
    [self.navigationController pushViewController:webVC animated:YES];
}

/*
 
 尺寸:
 首行cell
 高度145
 数字图片宽度65
 
 其他行
 高度85
 图片150w*85h
 320-64-150= 106 剩余
 gapW = 8???
 gapH = 5;

 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return 150;
    }
    return 85;
}

#pragma mark 下载数据
-(void)downloadData{
    
    NSString *postData_string = @"action=home&sa=Main&offset=0&count=20&uid=11111111&platform=a&mobile=HUAWEI+P6-C00&pid=10129&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37";
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(mainPage_downloadFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH andDownloadResqustMethod:@"POST"andPostDataString:postData_string];
}


-(void)mainPage_downloadFinish{
     _tableViewDataSource_array = [JSON2Model JSONData2ModelWithURLIdentifier:_urlIdentifier andDataType:zxJSON_DATATYPE_GENERIC];
    [_tabelView reloadData];
}

#pragma mark 绘制顶部导航栏
//重写root的创建导航栏的方法
-(void)createNavitaionbar{
    
    [self createRootNavigaitonBarWithTitleImag:@"logo"
                                  andIsTop:YES
                              andTitleName:nil
                        andBackgroundImage:nil
                      andLeftBtnImagesName:nil
                     andRightBtnImagesName:@"栏目_1"
                                  andClass:self
                                    andSEL:@selector(navigationBarClicked:)];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag == zxNavigaionBarButtonRightTag) {
        
#if 1
        ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
        
        //模态跳转
        tvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:tvc animated:YES completion:^{
            NSLog(@"%s [LINE:%d] 从主页==>tabBar视图", __func__, __LINE__);
        }];

        
#else
        BaseViewController *bvc = [[BaseViewController alloc]init];
        
        StarViewController *svc = [[StarViewController alloc]init];
        
//        UINavigationController *nav =[[ UINavigationController alloc]initWithRootViewController:bvc];
//        nav.navigationBar.hidden = YES;
//        [self presentViewController:nav animated:YES completion:nil];
        
        [self.navigationController pushViewController:svc animated:YES];
        
#endif
        
    }
}

@end
