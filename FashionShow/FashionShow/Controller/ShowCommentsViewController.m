//
//  ShowCommentsViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ShowCommentsViewController.h"
#import "CommentModel.h"
#import "CommentIteModel.h"
#import "PostCommentViewController.h"
#import "CommentItemCell.h"


#define writeCommentImageView_gap 5.0f

@interface ShowCommentsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShowCommentsViewController
{
    NSArray *_tableViewDataSource_array;
    NSString *_tips;
    UIImageView *_writeCommentImageView;
    UITableView *_tableView;
    
    BOOL _isNoComment;
}

- (void)viewDidLoad
{
    _isNoComment = YES;
    [super viewDidLoad];
    [self createNavitaionbar];
    [self previewLoadUI];
    [self downloadData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[DownloadManager sharedDownloadManager] removeCachedDataWithURLIdentifier:_urlIdentifier];
    [self downloadData];
    
}

-(void)previewLoadUI{
    self.view.backgroundColor = [UIColor colorWithRed:1.00f green:0.98f blue:0.95f alpha:1.00f];
    
#pragma mark 绘制底部评论框
    UIImage *writeCommentImage = [UIImage imageNamed:@"我要评论_1"];
    
    _writeCommentImageView= [[UIImageView alloc]initWithFrame:
                                          CGRectMake(0,
                                                     self.view.frame.size.height - writeCommentImage.size.height -writeCommentImageView_gap,
                                                     self.view.frame.size.width,
                                                     writeCommentImage.size.height)];
    _writeCommentImageView.image = writeCommentImage;
    [self.view addSubview:_writeCommentImageView];

    _writeCommentImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(writeCommentClicked)];
    [_writeCommentImageView addGestureRecognizer:tap];
    
#pragma mark 绘制表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              zxStatusBar_NavigatinBar_HEIGHT,
                                                              self.view.frame.size.width,
                                                              self.view.frame.size.height - zxStatusBar_NavigatinBar_HEIGHT -_writeCommentImageView.frame.size.height-writeCommentImageView_gap)
                                             style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

#pragma mark 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableViewDataSource_array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    CommentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        //从nib文件创建cell
       // cell = [[CommentItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentItemCell" owner:self options:nil] lastObject];
    }
    
    if (!_isNoComment) {
        CommentIteModel *cim = (CommentIteModel *)([_tableViewDataSource_array objectAtIndex:indexPath.row]);
        cell.name.text = cim.name;
        cell.content.text = cim.content;
        cell.adddate.text = cim.adddate;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


#pragma mark 点击评论框,跳转页面
-(void)writeCommentClicked{
    PostCommentViewController *pvc =[[PostCommentViewController alloc]init];
    pvc.article_id = _comment_article_id;
    [self.navigationController pushViewController:pvc animated:YES];
}

#pragma mark 下载数据
-(void)downloadData{
    
    /*
     NSString *postData_string = @"action=article&id=%@&uid=11111111&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37&platform=a&pid=10129&mobile=HUAWEI+P6-C00&fontsize=m";
     postData_string = [NSString stringWithFormat:postData_string,_article_id];
     
     //注意,这里地址中间有一个问号,将地址和参数分割开来
     _urlIdentifier = [NSString stringWithFormat:@"%@?%@",zxAPI_FULLPATH,postData_string];

     */

    NSString *postData_string = @"action=commentlist&id=%@&uid=11111111&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37&platform=a&pid=10129&mobile=HUAWEI+P6-C00&fontsize=m";
    postData_string = [NSString stringWithFormat:postData_string,_comment_article_id];
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    NSLog(@"_urlIdentifier=%@ %@",_urlIdentifier,[self class]);
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(comment_downloadFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH andDownloadResqustMethod:@"POST"andPostDataString:postData_string];
}

-(void)comment_downloadFinish{
    NSArray *tempArray  = [JSON2Model JSONData2ModelWithURLIdentifier:_urlIdentifier andDataType:zxJSON_DATATYPE_COMMENT];
    CommentModel *cm =  (CommentModel *) tempArray[0];
    
    if ([cm.code intValue] ==0 ) {
        _tips = cm.msg;
        _isNoComment = YES;
    }
    else if ([cm.code intValue] == 1){
        _tableViewDataSource_array = cm.list;
        _isNoComment = NO;
    }
    
    [_tableView reloadData];
    NSLog(@"刷表完成");
}


#pragma mark 绘制顶部导航栏
//重写root的创建导航栏的方法
-(void)createNavitaionbar{
    
    [self createRootNavigaitonBarWithTitleImag:nil
                                      andIsTop:NO
                                  andTitleName:@"大家在评论"
                            andBackgroundImage:nil
                          andLeftBtnImagesName:@"内文返回_1"
                         andRightBtnImagesName:nil
                                      andClass:self
                                        andSEL:@selector(navigationBarClicked:)];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag == zxNavigaionBarButtonLeftTag) {
#if 1
        [self.navigationController popViewControllerAnimated:YES];
#else
        [self dismissViewControllerAnimated:YES completion:nil];
#endif
    }
}


@end
