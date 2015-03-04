//
//  SettingViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "SettingViewController.h"
#import "CollectionViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingViewController
{
    NSArray *_tableViewDataSoucrce;
    UITableView *_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavitaionbar];
    [self loadTableViewDataSource];
    [self createTableView];
}

#pragma mark  准备表视图数据
-(void)loadTableViewDataSource{
    _tableViewDataSoucrce = @[@[@"一键推荐"],
                              @[@"我的收藏",@"用户反馈",@"推送通知",@"清除缓存"],
                              @[@"关于我们"]];
}

#pragma mark 创建表视图
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
    
    
}

#pragma mark tableVeiw 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_tableViewDataSoucrce count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableViewDataSoucrce[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        UIImageView *backgourdImaggeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, cell.frame.size.width-20, cell.frame.size.height)];
        backgourdImaggeView.image = [UIImage imageNamed:@"列表1_1"];
        [cell.contentView addSubview:backgourdImaggeView];
    }
    if(indexPath.section == 1)
    {
        //推送通知
        if (indexPath.row == 2) {
            
            UISwitch *mySwitch = [[UISwitch alloc]init];
            mySwitch.center = CGPointMake(cell.frame.size.width - mySwitch.frame.size.width,(cell.frame.size.height- mySwitch.frame.size.height)/2 + mySwitch.frame.size.height/2);
            [mySwitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventValueChanged ];
            [cell.contentView addSubview:mySwitch];
            
        }else if (indexPath.row == 3)
        {
            //清除缓存.
            //#todo
            NSString *string = @"8.3M";
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.center = CGPointMake(cell.frame.size.width - label.frame.size.width/2 , (cell.frame.size.height - label.frame.size.height)/2 + label.frame.size.height/2);
            label.text = string;
            [cell.contentView addSubview:label];
            
        }else{
            cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    cell.textLabel.text = [[_tableViewDataSoucrce objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0://我的收藏
                {
                    CollectionViewController *cvc = [[CollectionViewController alloc]init];
                    [self.navigationController pushViewController:cvc animated:YES];
                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
                }
                    break;
                case 1://用户反馈
                {
                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
                }
                    break;
//                case 2://推送通知--->使用swith了,不需要选中犯法了.
//                {
//                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
//                }
                    break;
                case 3://清除缓存
                {
                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
                    
                }
                    break;
                    
                default:
                    break;
            }
        
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}



-(void)switchClicked:(UISwitch *)s{

    if (s.on) {
        //接收推送通知
        //#todo
    }
    else{
        //不接收推送通知
        //#todo
    }
}



#pragma mark 绘制顶部导航栏
//重写root的创建导航栏的方法
-(void)createNavitaionbar{
    
    [self createRootNavigaitonBarWithTitleImag:nil
                                      andIsTop:NO
                                  andTitleName:@"设置"
                            andBackgroundImage:nil
                          andLeftBtnImagesName:@"内文返回_1"
                         andRightBtnImagesName:nil
                                      andClass:self
                                        andSEL:@selector(navigationBarClicked:)];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag == zxNavigaionBarButtonLeftTag) {
#if 0
        [self.navigationController popViewControllerAnimated:YES];
#else
        [self dismissViewControllerAnimated:YES completion:nil];
#endif
    }
}

@end
