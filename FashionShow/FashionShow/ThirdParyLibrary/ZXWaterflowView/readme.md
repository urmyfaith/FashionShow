# 使用UIScrollView实现的瀑布流的使用


可以使用瀑布流来代替简单的UICollectionView

##  view_cell

### cell.h

~~~objectivec
#import "ZXWaterflowViewCell.h"

@class ZXWaterflowView,ZXShop;

@interface ZXShopCell : ZXWaterflowViewCell

@property (nonatomic,strong) ZXShop    *shop;

+(instancetype)cellWithWaterflowView:(ZXWaterflowView *)waterflowView;

@end
~~~




### cell.m

~~~objectivec

#import "ZXShopCell.h"
#import "ZXWaterflowView.h"
#import "ZXWaterflowViewCell.h"
#import "ZXShop.h"
#import "UIKit+AFNetworking.h"

@interface ZXShopCell()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *priceLabel;

@end

@implementation ZXShopCell


//这里创建控件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView=[[UIImageView alloc]init];
		[self addSubview:imageView];
		self.imageView=imageView;
        
		UILabel *priceLabel=[[UILabel alloc]init];
		priceLabel.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
		priceLabel.textAlignment=NSTextAlignmentCenter;
		priceLabel.textColor=[UIColor whiteColor];
        
		[self addSubview:priceLabel];
        
		self.priceLabel=priceLabel;
    }
    return self;
}

+(instancetype)cellWithWaterflowView:(ZXWaterflowView *)waterflowView{
    static NSString *identifier = @"cell_identifier";
    ZXShopCell *cell = [waterflowView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ZXShopCell alloc]init];
        cell.identifier = identifier;
    }
    return cell;
}

-(void)setShop:(ZXShop *)shop{
    _shop = shop;
    self.priceLabel.text = shop.price;
    [self.imageView setImageWithURL:[NSURL URLWithString:shop.img]
                   placeholderImage:[UIImage imageNamed:@"loading"]];
}

//这里给控件赋值
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    CGFloat priceX = 0;
    CGFloat priceH = 25;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
}

@end

~~~

## model

### model.h



~~~objectivec
#import <Foundation/Foundation.h>

@interface ZXShop : NSObject

@property (nonatomic,assign)           CGFloat     h;
@property (nonatomic,assign)           CGFloat     w;
@property (nonatomic,copy)           NSString     *img;
@property (nonatomic,copy)           NSString     *price;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)shopWithDic:(NSDictionary *)dic;

+(NSMutableArray *)objectArrayWithFilename:(NSString *)filename;

@end
~~~


### model.m

~~~objectivec

#import "ZXShop.h"

@implementation ZXShop

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)shopWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

+(NSMutableArray *)objectArrayWithFilename:(NSString *)filename{
    NSString *path = [[NSBundle mainBundle]pathForResource:filename ofType:nil];
    NSArray *fileContent_array = [[NSArray alloc]initWithContentsOfFile:path];
    
    NSMutableArray *shops_marray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in fileContent_array) {
        [shops_marray addObject:[ZXShop shopWithDic:dic]];
    }
    return shops_marray;
}

/**
  *  KVC的时候,防止给不存在的属性赋值
  *
  *  @param value 值
  *  @param key   键
  */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s [LINE:%d] key=%@", __func__, __LINE__,key);
}

-(NSString *)description{
    static int  i = 0;
    return [NSString stringWithFormat:@"ZXShop %2d: w=%3.f h=%3.f img=%@ price=%@ ",i++,self.w,self.h,self.img,self.price];
}

@end
### ``
~~~


## controllver

`MJRefresh_new_category/demo/zxWaterFallFlow/ZXViewController.m`

~~~objectivec

#import "ZXViewController.h"

/*==========自定义的瀑布流===========*/
#import "ZXWaterflowView.h"
#import "ZXWaterflowViewCell.h"

/*==========自定义cell/模型===========*/
#import "ZXShop.h"
#import "ZXShopCell.h"

/*==========刷新数据===========*/
#import "MJRefresh.h"

#import "UIColor+ZXRandomColor.h"

@interface ZXViewController ()<ZXWaterflowViewDataSource,ZXWaterflowViewDelegate>
@property (nonatomic,strong)  NSMutableArray    *shops;
@end

@implementation ZXViewController
{
    
    ZXWaterflowView *_waterflowView;
}

#pragma mark lazy load
-(NSMutableArray *)shops{
    if (nil == _shops) {
        _shops = [[NSMutableArray alloc]init];
    }
    return _shops;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建瀑布流,加载数据源,刷新数据
    [self createWaterflowView];
    self.shops= [ZXShop objectArrayWithFilename:@"shopData.plist"];
    [_waterflowView reloadData];
}

-(void)createWaterflowView{
    
    _waterflowView = [[ZXWaterflowView alloc]init];
    _waterflowView.frame = self.view.bounds;
    _waterflowView.delegate = self;
    _waterflowView.dataSource = self;
    [self.view addSubview:_waterflowView];
    
    [_waterflowView addHeaderWithTarget:self action:@selector(loadNewShops)];
    [_waterflowView addFooterWithTarget:self action:@selector(loadMoreShops)];
}

/**
 *  上拉刷新时调用: 更新数据源(替换已有数据),重新绘制,结束刷新.
 */
-(void)loadNewShops{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *newShop=[ZXShop objectArrayWithFilename:@"shopData.plist"];
        [self.shops insertObjects:newShop atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShop.count)]];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_waterflowView reloadData];
        [_waterflowView  headerEndRefreshing];
    });
}

/**
 *  下拉刷新时调用: 更新数据源(追加新数据),重新绘制,结束刷新.
 */
-(void)loadMoreShops{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *newShop=[ZXShop objectArrayWithFilename:@"shopData2.plist"];
        [self.shops addObjectsFromArray:newShop];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_waterflowView reloadData];
        [_waterflowView footerEndRefreshing];
    });
}

#pragma mark 必须实现-->数据源方法

-(NSUInteger)numberOfCellsInWaterflowView:(ZXWaterflowView *)waterflowView{
    return self.shops.count;
}

-(ZXWaterflowViewCell *)waterflowView:(ZXWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index{
    
    ZXShopCell *cell=[ZXShopCell cellWithWaterflowView:waterflowView];
    cell.shop=self.shops[index];
    return cell;
}

#pragma mark 可选方法--->根据需要设置

/**
 *  可以设置的有cell的列数,cell的间距,cell的高度,选中cell执行的方法
 */

-(NSUInteger)numberOfColumnsInWaterflowView:(ZXWaterflowView *)waterflowView{
    return 3;
}

-(CGFloat)waterflowView:(ZXWaterflowView *)waterflowView marginForType:(ZXWaterFlowViewMarginType)type{
    switch (type) {
        case ZXWaterFlowViewMarginTypeTop:
        case ZXWaterFlowViewMarginTypeBottom:
        case ZXWaterFlowViewMarginTypeLeft:
        case ZXWaterFlowViewMarginTypeRight:
            return 1.0f;
            break;
            
        case ZXWaterFlowViewMarginTypeColumn:
        case ZXWaterFlowViewMarginTypeRow:
            return 1.0f;
            break;
    }
    return 2;
}

/**
 *  这个方法应该是对于自定义的cell最为有用的方法,确定每个cell的高度
 */

-(CGFloat)waterflowView:(ZXWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index{
    ZXShop *shop = (ZXShop *)[self.shops objectAtIndex:index];
    return shop.h;
}

/**
 *  cell点击事件
 *
 *  @param waterflowView 当前瀑布流对象
 *  @param index         cell标志索引
 */
-(void)waterflowView:(ZXWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index{
    NSLog(@"%s [LINE:%d] clicked:%lu cell.", __func__, __LINE__,index);
}

@end
~~~
