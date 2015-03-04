
- 工程目录组织

Application：这个group中放的是AppDelegate和一些系统常量及系统配置文件；
Base：一些基本父类，包括父ViewController和一些公用顶层自定义父类，其他模块的类一般都继承自这里的一些类；
Controller：系统控制层，放置ViewController，均继承于Group Base中的BaseViewController或BaseTableViewController；
View：系统中视图层，由于我比较喜欢通过代码实现界面，所以这里放的都是继承于UIView的视图，我将视图从ViewController中分离出来全部放在这里，这样能保持ViewController的精简；
Model：系统中的实体，通过类来描述系统中的一些角色和业务，同时包含对应这些角色和业务的处理逻辑；
Handler：系统业务逻辑层，负责处理系统复杂业务逻辑，上层调用者是ViewController；
Storage：简单数据存储，主要是一些键值对存储及系统外部文件的存取，包括对NSUserDefault和plist存取的封装；
Network：网络处理层(RTHttpClient)，封装了基于AFNetworking的网络处理层，通过block实现处理结果的回调，上层调用者是Handler层；
Database：数据层，封装基于FMDB的sqlite数据库存取和管理(RTDatabaseHelper)，对外提供基于Model层对象的调用接口，封装对数据的存储过程。
Utils：系统工具类(AppUtils)，主要放置一些系统常用工具类；
Categories：类别，对现有系统类和自定义类的扩展；
Resource：资源库，包括图片，plist文件等；


- 

宏定义:网络接口
常量是用宏定义或者枚举



#问题1 --已解决

post请求,url地址相同,只是请求体不同,

所以下载之后,缓存数据的的key不能是url,而是请求体.

将ulr和postData拼接起来,作为唯一的标志符


#问题2

首页,页面能够下拉刷新,但是不能上拉.
这是怎么实现的?


##问题3  ---已解决

使用模态视图转换

从UINavigationController/UIViewController  push到 UITabBarController
~~~objectivec

kindDemo里面确实是push了啊????


~~~

## 问题4
 
 计算文件夹的大小
 
 http://www.cocoachina.com/bbs/read.php?tid-265475.html
 http://blog.sina.com.cn/s/blog_63b4ee0d0101gdli.html
 http://www.2cto.com/kf/201412/360426.html

## 问题5 --已经解决

首页首行cell的尺寸调整问题

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

## 问题6

webView点击图片,添加自定义视图

## 问题7

webView的内容怎么缓存?

从webView的创建过来看,数据的下载已经封装到内部了.
怎么取出下载的数据?

UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
NSURL *url = [NSURL URLWithString:_urlIdentifier];
NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
[webView loadRequest:request];
[self.view addSubview:webView];

> 参考资料:

- http://code4app.com/ios/UIWebView-%E7%A6%BB%E7%BA%BF%E6%B5%8F%E8%A7%88/51204e716803fa2949000001
- http://openq.cn/use-nsurlprotocol-uiwebview-offline-cache/
- http://openq.cn/nsurlcache-to-achieve-a-little-experience-for-offline-reading/
- http://blog.csdn.net/mad2man/article/details/30285001



## 问题8  ---已解决

PostCommentViewController.m

UITextView
怎么得到输入文字的高度,比如输入了两行数据?

怎么得到这两行数据的整体高度?


# 问题9 KVO的使用 ---已解决

PostCommentViewController.m # 228

- 使用_isCommentSuccess改变值的时候,不会触发KVO的方法.

- 自己能监听自己的属性的么?(可以)

- 监听属性(可以是私有的属性)

- https://github.com/urmyfaith/roadofios/blob/e7ab82dcd9b6e3ef12b986a7adb6c1e5a1d46686/advancedUI/week14/FashionShow/FashionShow/Controller/FashionViewController.m#L145-156

# 问题10 下拉刷新无数据返回 -- 已解决

下拉刷新的时候,没有数据返回的时候,给用户一个提示
使用第三方库 iToast,类似android上自带的toast消息提示.

使用很简单,消息内容,消息位置,消息显示时间长度,显示

- https://github.com/urmyfaith/roadofios/blob/1847404a85859d16851ab84b56e7d26d1d66fc7b/advancedUI/week14/FashionShow/FashionShow/Controller/FashionViewController.m#L88-93


# 问题11  美容页面怎么实现? --已解决

难点:数据源是一样的,但是怎么摆放控件:

- a.一行3个小图 

- b.文字左侧+图片右侧 
- c.文字右侧+ 图片左侧

解决的办法:先下载数据,转换为模型,模型存入数组,遍历数组,根据每个模型,分支判断,逐渐创建 ==> 添加到滚动视图.

一般是先创建控件,然后给视图里填充数据.

反过来之后,可以 

- a.使用代理,外部传入数据,动态创建(例如UITablieView,ZXWaterflow瀑布流)

- b.不在init方法里创建,而是等这个对象创建完成之后,调用对象的方法来创建控件.

# 问题11 自定义的标签栏控件在push到下一页怎么隐藏? -- 已解决

解决的方法是:

> 把这个控件的创建做成一个单例,并且,自定义的控件全部加载一个View上,让这个View作为这个单例的属性.

> 这样,在任何地方,只要通过这个单例,访问单例的属性,操作view的hidden属性,就可以显示和隐藏自定义的标签栏控件.


# 问题12 代理的使用 －－已解决

单击页面的每行Row的View的，时候，进行页面跳转：不同的类之间的传值。

协议方法在父类，自类调用来让代理实现协议方法。

属于反向传值的问题

由于创建View是在单独的类中，BeautyView,创建的时候的需要设置代理，这样的话，就需要重写init方法，

将ViewController传进来。

```

.h

-(id)initWithViewController:(id)viewController;

@implementation BeautyView
{
    id _viewController;
}

.m

-(id)initWithViewController:(id)viewController{
    if (self = [super init]) {
        //
        _viewController = viewController;
    }
    return self;
}

bsv.delegate = _viewController;
blv.delegate = _viewController;
brv.delegate = _viewController;

```

代理方法：

```

父生成的协议方法：

@protocol BeautyOneRowViewDelegate <NSObject>

@required
-(void)clickedOneRowViewAtIndex:(NSNumber *)index;
@end

if ([self.delegate respondsToSelector:@selector(clickedOneRowViewAtIndex:)]) {
    [self.delegate performSelector:@selector(clickedOneRowViewAtIndex:) withObject:[self.indexs_array objectAtIndex:index]];
}


```

实现代理协议：

```
//引入协议，实现协议方法（协议方法的目的：实现不同的类之间传值）
#import "BeautyBaseView.h"
@interface BeautyViewController : BaseViewController<BeautyOneRowViewDelegate>

@end
-(void)clickedOneRowViewAtIndex:(NSNumber *)index{
    NSLog(@"%s %d %@",__func__,__LINE__,index);
    
    WebViewController *webVC = [[WebViewController alloc]init];
    GenericModel *model = (GenericModel *)[self.beautyModels_mArray objectAtIndex:index.intValue];
    
    webVC.article_id =  model.id;  //用于webView地址的拼接
    webVC.model = model; //用于收藏webView的时候,展示收藏页面的标题.
    webVC.modelType = zxJSON_DATATYPE_GENERIC; //标记数据模型的类型
    
    ZXTabBarVC *tvc = [ZXTabBarVC sharedZXTabBarViewController];
    tvc.customTabBar.hidden = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}


```

## 问题13 图片等比例压缩 －－已解决

下载的图片尺寸太大,

```
2015-03-02 19:25:50.766 FashionShow[7732:607] 449 675.-- 320 431
2015-03-02 19:25:50.769 FashionShow[7732:607] 300 300.-- 320 431
2015-03-02 19:25:50.784 FashionShow[7732:607] 450 675.-- 320 431
```

在下载图片完成之前，不知道图片的尺寸。

需要有下载图片完成后的回调方法。

1.要么使用代理的回调

2.要么使用block形式的回调。

使用blokc的形式回调可能会导致 retian Circle


图片宽度／图片高度  视图宽度／视图高度 ＝ 1:2 ＝ 0.5。

判断，如果 图片宽度／图片高度>0.5 宽度太宽，图片宽度＝ 视图宽度，计算图片高度

《 0.5，图片台高，图片高度 ＝ 视图高度，计算图片宽度。
然后居中显示。 


##问题14  调整状态栏的颜色 －－已解决

参考资料： http://my.oschina.net/shede333/blog/304560


```
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
```

##问题15  图片对缩放

图片首先缩放，图片缩放后怎么还原原来图片的大小？

```
-(void)myPinch:(UIPinchGestureRecognizer *) pinch{
    NSLog(@"%s [LINE:%d]", __func__, __LINE__);
    if ([pinch.view isKindOfClass:[ZXImageView class]]) {
        ZXImageView *pinchView = (ZXImageView *)pinch.view;
        CGRect originalFrame = pinchView.originalFrame;
        pinchView.transform = CGAffineTransformScale(pinchView.transform, pinch.scale,pinch.scale);
        pinch.scale = 1;
        if (pinchView.frame.size.width < _mainScroolView.frame.size.width) {
            pinchView.frame = originalFrame;
        }
    }
    /*
     self.imageView.transform = CGAffineTransformMakeRotation(0);
     self.imageView.frame = self.imageView.originalFrame;
     */
}
```

解决办法，在创建图像的时候，纪录图像的位置＝＝＝》dic：key（tag），value（pos）

key是图像的tag，value时图像的位置

在缩放完成之后，延时执行一个方法，与原始尺寸判断，如果缩放过小，恢复原始frame

```

//纪录frame
[self.imageView_originalFrame_mDic setObject:[NSValue valueWithCGRect: imageView.frame ] forKey:@(index)];

//执行缩放手势
#pragma mark  缩放手势ACTION
-(void)myPinch:(UIPinchGestureRecognizer *) pinch{

    NSLog(@"%s [LINE:%d] %@", __func__, __LINE__,self.imageView_originalFrame_mDic);
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

//判断是否需要恢复原始大小
-(void)shouldRestoreImageSize:(ZXImageView *)imageView{
    if (imageView.frame.size.width < _mainScroolView.frame.size.width) {
        [UIView animateWithDuration:1.0 animations:^{
            imageView.frame = [[self.imageView_originalFrame_mDic objectForKey:@(imageView.tag)] CGRectValue];
        }];
    }
}

```

这样话，就只能把图片放大，而不能缩小。


## 问题16 CGRect转换为对象 －－ 以解决

NSValue包装对象指针，CGRect结构体等

参考资料：http://www.cocoachina.com/bbs/read.php?tid-9411.html
@interface NSValue (NSValueUIGeometryExtensions)
  
+ (NSValue *)valueWithPointer:(const void *)pointer;//保存对象指针
 
+ (NSValue *)valueWithCGPoint:(CGPoint)point;//保存CGPoint结构体
+ (NSValue *)valueWithCGSize:(CGSize)size;//保存CGSize结构体
+ (NSValue *)valueWithCGRect:(CGRect)rect;//保存CGRect结构体
+ (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform;
+ (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets;
  
- (void *)pointerValue;
- (CGPoint)CGPointValue;
- (CGSize)CGSizeValue;
- (CGRect)CGRectValue;
- (CGAffineTransform)CGAffineTransformValue;
- (UIEdgeInsets)UIEdgeInsetsValue;
  
@end

## 问题17  保存图片到到相册-- 已解决

UIImageWriteToSavedPhotosAlbum 方法是UIKit中的方法（C语言方法）


```
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage,
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:),
                                   NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}
```

使用nil仍然出不了

> 最后的解决

>> 使用Xcode6.1和iphone5模拟器就好了.

>> 在Xcode5.1中使用的话,保存不成功.


- http://blog.csdn.net/hengshujiyi/article/details/22879495
- https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKitFunctionReference/#//apple_ref/c/func/UIImageWriteToSavedPhotosAlbum
- http://www.cnblogs.com/85538649/archive/2011/12/05/2276901.html
- http://stackoverflow.com/questions/7628048/ios-uiimagewritetosavedphotosalbum

##  复习,友盟分享 --友盟


### 第一步: 导入库

- Security.framework,
- libiconv.dylib,
- SystemConfiguration.framework,
- CoreGraphics.framework，
- libsqlite3.dylib，
- CoreTelephony.framework,
- libstdc++.dylib,
- libz.dylib。

### 第二步:初始化友盟库

(1)先包含头文件
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"


(2)加载时---初始化并且设置AppKey

```
-(void)createUmeng{

[UMSocialData setAppKey:zxYOUMENG_APPKEY];

NSString *url = @"http://zuoxue.sinaapp.com/UISettingResources/userInfo.json";

[UMSocialWechatHandler setWXAppId:zxWEIXIN_APPKEY
url:url];

[UMSocialConfig setQQAppId:zxQQ_APPKEY
url:url
importClasses:@[[QQApiInterface class],[TencentOAuth class]]];

}
```

### 第三步:调用,使用分享:

```
/*==========导入友盟库===========*/
#import "UMSocial.h"
```

分享需要指定,a)分享的文字,b)分享的图片,c)分享的平台

> 分享方式一:(不使用代理)

```
//简单处理,不使用代理,需要设置 -->[图片],[文字],[分享平台];
[UMSocialSnsService presentSnsIconSheetView:curren_vc
appKey:zxYOUMENG_APPKEY
shareText:[NSString stringWithFormat:@"我在看%@ ,",_downlaod_url]
shareImage:_shareImage
shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,
UMShareToTencent,
UMShareToWechatTimeline,
UMShareToQzone,
nil]
delegate:nil];
```

> 分享方式二:(使用代理)

```
//使用代理,需要设置 -->[图片],[文字],[分享平台];
UIActionSheet *sheet =[ [UIActionSheet alloc]initWithTitle:@"分享"
delegate:self
cancelButtonTitle:@"取消"
destructiveButtonTitle:nil
otherButtonTitles:@"新浪微博",@"腾讯微博",@"朋友圈",@"QQ空间", nil];
[sheet showInView:self];
```
代理方法:

```
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

if(buttonIndex < 5){

NSString *shareText = [NSString stringWithFormat:@"我在看%@ ,",_downlaod_url];

[[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:_shareImage socialUIDelegate:nil];

NSArray *sharePlatforms = @[UMShareToSina,UMShareToTencent,UMShareToWechatTimeline,UMShareToQzone];

UMSocialSnsPlatform *platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:sharePlatforms[buttonIndex]];

platform.snsClickHandler(_currentClassObject,[UMSocialControllerService defaultControllerService],YES);
}
}
```






#todo 代码的复用,单行图片在左还是在右的代码的复用?

#todo UICollectionView的复用

#todo  将所有的尺寸改写为宏定义
