//
//  PhotosViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "PhotosViewController.h"

//导入库
#import "UIImageView+WebCache.h"

//json转数据模型
#import "JSON2Model.h"
#import "GenericModel.h"

//可以缩放的图片视图
#import "ZXImageView.h"
#import "ZXTabBar.h"

#define viewWIDTH self.view.frame.size.width

#define viewHEIGHT self.view.frame.size.height

#define buttomViewHEIGHT 49.0f

#define detailViewHEIGHT 150.0f

@interface PhotosViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>



@property(nonatomic,strong)NSMutableDictionary *imageView_originalFrame_mDic;//存储模型数组

@end

@implementation PhotosViewController
{

    UIScrollView *_mainScroolView;//图片滚动视图
    
    CGFloat _detailViewHeightWithoutTextView;
    CGFloat _detailViewHeightWithTextView;
    
    BOOL _toolBarIsHidden;//是否隐藏底部的工具栏
    BOOL _detailViewIsHidden;//是否显示详细视图
    BOOL _detailViewIsExpand;//是否展开的滚动视图
    
//    NSUInteger _currentPage;//滚动视图当前页
    
    UIView *_detailView;
    
    UILabel *_title_label;
    UILabel *_currentNumber_label;
    UILabel *_totalNumber_label;
    UIImageView *_arrow_imageView;
    UITextView *_textView;
}

#pragma mark _lazy_load
-(NSMutableArray *)dataSource_mArray{
    if (nil == _dataSource_mArray) {
        _dataSource_mArray = [[NSMutableArray alloc]init];
    }
    return _dataSource_mArray;
}

-(NSMutableDictionary *)imageView_originalFrame_mDic{
    if (nil == _imageView_originalFrame_mDic) {
        _imageView_originalFrame_mDic = [[NSMutableDictionary alloc]init];
    }
    return _imageView_originalFrame_mDic;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _toolBarIsHidden = NO;//初始化，默认是显示
    _detailViewIsHidden = NO; //默认是显示
    _detailViewIsExpand = NO; //默认是收起滚动视图的
    _currentPage = 0; //滚动视图当前页，第0页
    
    //创建底部的工具栏
    [self createButtomView];
    
    //下载数据
    [self downloadData];

}


#pragma mark 创建滚动视图
-(void)createMainScroolView{
    _mainScroolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    zxStatusBar_NavigatinBar_HEIGHT,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height - 49-zxStatusBar_NavigatinBar_HEIGHT)];
    _mainScroolView.delegate = self;
   
    
    for (int index=0 ; index < self.dataSource_mArray.count; index++) {
        NSLog(@"picture index =%d",index);
        
        GenericModel *gm = (GenericModel *)[self.dataSource_mArray objectAtIndex:index];
        
        CGFloat xPos = _mainScroolView.frame.size.width * index;
        
        //不只要添加一个手势，但是外部需要执行手势的方法，所以，
        //使用target－action方法
        __block ZXImageView *imageView = [[ZXImageView alloc]initWithObject:self andSelectors:@{
                                                  @"pinch": @"myPinch:",
                                                  @"tap" :  @"myTap:"
                                                  }];
        imageView.tag = index;
        
        NSLog(@" url=%@",gm.icon);
        [imageView setImageWithURL:[NSURL URLWithString:gm.icon]
                  placeholderImage:[UIImage imageNamed:@"内文缺省图"]
                           options:SDWebImageRefreshCached
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                             if(image){
                                 /*
                                  图片宽度／图片高度  视图宽度／视图高度 ＝ 1:2 ＝ 0.5。
                                  
                                  判断，如果 图片宽度／图片高度>0.5 宽度太宽，图片宽度＝ 视图宽度，计算图片高度
                                  
                                  《 0.5，图片台高，图片高度 ＝ 视图高度，计算图片宽度。
                                  然后居中显示。
                                  */
                                 CGFloat image_W = image.size.width;
                                 CGFloat image_H = image.size.height;
                                 CGFloat scrollView_W = _mainScroolView.frame.size.width;
                                 CGFloat scrollView_H = _mainScroolView.frame.size.height;
                                 NSLog(@"调整前 %.f %.f -- %.f %.f ",image_W,image_H, scrollView_W,scrollView_H);
                                 //图片太宽＝＝＝》固定宽度，计算高度
                                 if (image_W/image_H > scrollView_W/scrollView_H) {
                                     imageView.frame = CGRectMake(0,
                                                                  0,
                                                                  scrollView_W,
                                                                  scrollView_W/(image_W/image_H)
                                                                  );
                                     
                                     
                                     NSLog(@"初步调整：width=%.f HEIGTH---->%.f",scrollView_W,scrollView_W/(image_W/image_H));
                                 }
                                 //图片太高＝＝＝》固定高度
                                 else{
                                     imageView.frame = CGRectMake(0,
                                                                  0,
                                                                  (image_W/image_H)*scrollView_H,
                                                                  scrollView_H
                                                                  );
                                     NSLog(@"初步调整：WIDTH=%.f<---- height=%.f",(image_W/image_H)*scrollView_H,scrollView_H);
                                 }
                                 if (imageView.frame.size.width< scrollView_W) {
                                     imageView.frame = CGRectMake(0,0,scrollView_W,imageView.frame.size.height);
                                 }
                                 NSLog(@"最后的frame：width=%.f---- height=%.f",imageView.frame.size.width,imageView.frame.size.height);
                                 NSLog(@"   ");
                                 
                                 imageView.center = CGPointMake(xPos + _mainScroolView.frame.size.width/2,
                                                                _mainScroolView.frame.size.height/2);
                                 
                                 [self.imageView_originalFrame_mDic setObject:[NSValue valueWithCGRect: imageView.frame ] forKey:@(index)];
                             }
                         }];
        [_mainScroolView addSubview:imageView];
    
    }
    _mainScroolView.contentSize = CGSizeMake(_mainScroolView.frame.size.width*self.dataSource_mArray.count,
                                             _mainScroolView.frame.size.height);
    _mainScroolView.pagingEnabled = YES;
    [self.view addSubview:_mainScroolView];
}

#pragma mark  滚动视图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentPage = scrollView.contentOffset.x/viewWIDTH;
    [self refreshDetailView];
}


#pragma mark  缩放手势ACTION
-(void)myPinch:(UIPinchGestureRecognizer *) pinch{

    //NSLog(@"%s [LINE:%d] %@", __func__, __LINE__,self.imageView_originalFrame_mDic);
    if ([pinch.view isKindOfClass:[ZXImageView class]]) {
        ZXImageView *pinchView = (ZXImageView *)pinch.view;
        static NSValue *originalFrame = nil;
        if(originalFrame == nil){
            originalFrame = [NSValue valueWithCGRect: pinchView.originalFrame ];
        }
        pinchView.transform = CGAffineTransformScale(pinchView.transform, pinch.scale,pinch.scale);
        pinch.scale = 1;
        [self performSelector:@selector(shouldRestoreImageSize:) withObject:pinchView afterDelay:0.5];
    }
}

-(void)shouldRestoreImageSize:(ZXImageView *)imageView{
    if (imageView.frame.size.width < _mainScroolView.frame.size.width) {
        [UIView animateWithDuration:1.0 animations:^{
            imageView.frame = [[self.imageView_originalFrame_mDic objectForKey:@(imageView.tag)] CGRectValue];
        }];
    }
}

#pragma mark  单击手势ACTION
-(void)myTap:(UITapGestureRecognizer *)tap{
    NSLog(@"%s [LINE:%d] 单击手势ACTION", __func__, __LINE__);
    _detailViewIsHidden = ! _detailViewIsHidden;
    [UIView animateWithDuration:0.5 animations:^{
        //
        if(_detailViewIsHidden == NO){
            _detailView.alpha = 1.0f;
            [self shouldHiddenToolBar:NO];
        }
        else{
            _detailView.alpha = 0.0f;
            [self shouldHiddenToolBar:YES];
        }
    }];
}



#pragma mark 创建底部工具栏
-(void)createButtomView{
    [self createButtomViewWithImagesArray:@[@"内文返回_1",@"下载_1",@"分享_1",@"收藏_1",@"评论_1"]
                                 andClass:self
                                   andSEL:nil];
    
}

#pragma mark 下载数据
-(void)downloadData{

    NSString *postData_string = [NSString stringWithFormat:@"action=picture&gid=%@&uid=11111111&platform=a&mobile=HUAWEI+P6-C00&pid=10129&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37",self.gid];
    
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    NSLog(@"_urlIdentifier=%@",_urlIdentifier);
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(photoPage_downloadFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH
                                               andDownloadResqustMethod:@"POST"
                                                      andPostDataString:postData_string];
}

#pragma mark  下载数据完成
-(void)photoPage_downloadFinish{
    
    [self.dataSource_mArray  addObjectsFromArray:[JSON2Model JSONData2ModelWithURLIdentifier:_urlIdentifier andDataType:zxJSON_DATATYPE_GENERIC]];
    //下载数据完成
    
    
    //创建滚动视图
    [self createMainScroolView];
    
    //创建详细视图
    [self createDetailView];
}

-(void)createDetailView{
    
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                        viewHEIGHT - buttomViewHEIGHT - detailViewHEIGHT,
                                                        viewWIDTH,
                                                        detailViewHEIGHT)];
    _detailView.backgroundColor = [UIColor colorWithRed:125./255. green:125./255. blue:125./255. alpha:0.5];
    [self.view addSubview:_detailView];
    
#pragma mark 单击手势
    _detailView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                           action:@selector(detailViewTaped:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [_detailView addGestureRecognizer:tap];

    
    CGFloat labelLeftGap = 10.0f;
    CGFloat labelHeight = 80.0f;

#pragma mark 文字
    _title_label = [[UILabel alloc]initWithFrame:CGRectMake(labelLeftGap,
                                                              0,
                                                              viewWIDTH- labelLeftGap*2,
                                                              labelHeight)];
    
    _title_label.text = @"";
    _title_label.font = [UIFont boldSystemFontOfSize:18];
    _title_label.lineBreakMode = NSLineBreakByCharWrapping;
    _title_label.numberOfLines = 2;
    _title_label.textColor = [UIColor whiteColor];
    [_detailView addSubview:_title_label];

#pragma mark 线条
    UIImage *line_image = [UIImage imageNamed:@"线"];
    UIImageView *line_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(labelLeftGap,
                                                                         CGRectGetMaxY(_title_label.frame),
                                                                         line_image.size.width,
                                                                         line_image.size.height)];
    line_imageView.image = line_image;
    [_detailView addSubview:line_imageView];
    
#pragma mark 当前的数
    _currentNumber_label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line_imageView.frame) +10.0f,
                                                                            CGRectGetMaxY(_title_label.frame)-5.0f,
                                                                           15.0f,
                                                                            15.0f)];
    _currentNumber_label.text = @"abc";
    _currentNumber_label.textColor = [UIColor whiteColor];
    _currentNumber_label.font = [UIFont boldSystemFontOfSize:16];
    [_detailView addSubview:_currentNumber_label];
 
#pragma mark 总数
    _totalNumber_label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_currentNumber_label.frame),
                                                                          CGRectGetMaxY(_title_label.frame) -5.0f,
                                                                          30.0f,
                                                                          15.0f )];
    _totalNumber_label.text = @"def";
    _totalNumber_label.textColor = [UIColor whiteColor];
    _totalNumber_label.font = [UIFont boldSystemFontOfSize:14];
    [_detailView addSubview:_totalNumber_label];

#pragma mark 箭头
    UIImage *arrow_image = [UIImage imageNamed:@"内文箭头"];
    _arrow_imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                           CGRectGetMaxY(_title_label.frame),
                                                                            15.0f,
                                                                            15.0f)];
    _arrow_imageView.center = CGPointMake(viewWIDTH/2,
                                         CGRectGetMaxY(_arrow_imageView.frame) - 15.0f);
    _arrow_imageView.image = arrow_image;
    [_detailView addSubview:_arrow_imageView];
    
    _detailViewHeightWithoutTextView = CGRectGetMaxY(_arrow_imageView.frame);
    
    NSLog(@"_detailViewHeightWithoutTextView = %.f",_detailViewHeightWithoutTextView);
    
#pragma mark 文字
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(0,
                                                            CGRectGetMaxY(_arrow_imageView.frame),
                                                            _detailView.frame.size.width,
                                                            _detailView.frame.size.height - CGRectGetMaxY(line_imageView.frame) - 5.0f)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.text = @"";
    _textView.textColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.editable = NO;
    [_detailView addSubview:_textView];
    
    [self refreshDetailView];
//    [self shouldHiddenToolBar:NO];
}


#pragma mark  detailView单击手势ACTION
-(void)detailViewTaped:(UITapGestureRecognizer *)tap{

    [self refreshDetailView];
    //展开
    if (_detailViewIsExpand == YES) {
        [UIView animateWithDuration:0.5f animations:^{
            _arrow_imageView.transform = CGAffineTransformMakeRotation(0);
            _detailView.frame = CGRectMake(0,
                                           viewHEIGHT - buttomViewHEIGHT - detailViewHEIGHT,
                                           viewWIDTH,
                                           detailViewHEIGHT);
            _textView.alpha = 1.0f;
        }];
    }
    //收起
    else{
        [UIView animateWithDuration:0.5f animations:^{
            _arrow_imageView.transform = CGAffineTransformMakeRotation(M_PI);
            _detailView.frame = CGRectMake(0,
                                           viewHEIGHT - _detailViewHeightWithoutTextView - buttomViewHEIGHT,
                                           viewWIDTH,
                                           _detailViewHeightWithoutTextView);
            _textView.alpha = 0.0f;
            
        }];
    }
    //更新展开收起状态
    _detailViewIsExpand = !_detailViewIsExpand;
}

-(void)refreshDetailView{
    GenericModel *gm = [self.dataSource_mArray objectAtIndex:_currentPage];
    _title_label.text = gm.title;
    _currentNumber_label.text = [NSString stringWithFormat:@"%d",_currentPage+1];
    _totalNumber_label.text = [NSString stringWithFormat:@"/%d",[self.dataSource_mArray count]];
    _textView.text = gm.des;
}

#pragma mark 显示/隐藏底部的 工具栏

//实现方法：遍历子视图，找到对应的视图后,修改alpha透明度。
-(void)shouldHiddenToolBar:(BOOL) toolBarIsHidden{
    for (id subView in self.view.subviews) {
        if ([subView isKindOfClass:[ZXTabBar class]]) {
            ZXTabBar *tabBar = (ZXTabBar *)subView;
            
            //隐藏
            if (toolBarIsHidden == YES) {
                tabBar.alpha = 0;
            }else{
            //显示
                tabBar.alpha = 1;
            }
        }
    }
}

@end
