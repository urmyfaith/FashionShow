
#import "ZKDataCache.h"
#import "NSString+Hashing.h"
#import "UIKit+AFNetworking.h"


@implementation ZKDataCache

static ZKDataCache *cache = nil;

+(id)sharedInstance{
    @synchronized(self){
        if (cache == nil) {
//            cache = [[ZKDataCache alloc]init];
            cache = [[[self class] alloc]init];
            cache.validTime = 20*60;
        }
    }
    return cache;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    if (cache == nil) {
        cache = [super allocWithZone:zone];
    }
    return cache;
}


-(void)saveData:(NSData *)data withFilename:(NSString *)urlString{
    //路径
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/DataCache",NSHomeDirectory()];

    
    //创建文件夹
    [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    //保存文件
    //文件的名字使用 MD5编码
    NSString *md5String = [urlString MD5Hash];

    
    NSString *newString = [NSString stringWithFormat:@"%@/%@",path,md5String];
    BOOL b = [data writeToFile:newString atomically:YES];
    NSLog(@"%s [LINE=%i] 保存文件(图片/json)到本地--->%@",__func__,__LINE__,b==YES?@
          "成功":@"失败");
}


/*
 写成工具方法.
 文件名
 文件的内容 imgae-->NSData
 取出之前,判断是否
 (NSData *)getImageFromCacheOrDownloadWithUrlString:(NSString *)urlString
 先从缓存读取,若果有,返回图片,如果没有,网络去请求,并且缓存起啦.
 */

-(NSData *)getImageFromCacheOrDownloadWithUrlString:(NSString *)urlString{
    __block NSData *imageData  = [self getDataWithUrlString:urlString];
    
    if (imageData == nil) { //本地没有缓存
        //下载图片,缓存起来
        NSLog(@"%s [LINE:%d] 无图片缓存,从网络获取,\n urlString=%@", __func__, __LINE__,urlString);
        
        UIImageView *imageView = [[UIImageView alloc]init];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        
        [imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"icon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            //
            NSLog(@"%s [LINE:%d]UIImagePNGRepresentation(image)=%@", __func__, __LINE__,UIImagePNGRepresentation(image));
            
            NSLog(@"%s [LINE:%d]UIImageJPEGRepresentation(image, 1.0)=%@", __func__, __LINE__,UIImageJPEGRepresentation(image, 1.0));
            imageData = UIImagePNGRepresentation(image) != nil ? UIImagePNGRepresentation(image) : UIImageJPEGRepresentation(image, 1.0);
            
            [self saveData:[NSData dataWithData:imageData] withFilename:urlString];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%s [LINE:%d] download failed.", __func__, __LINE__);
        }];
//        return [NSData dataWithData: UIImagePNGRepresentation([UIImage imageNamed:@"icon"])];
    }
    else{
        NSLog(@"%s [LINE:%d] 有图片缓存", __func__, __LINE__);
    }
    return imageData;
}


-(void)setImageOfImageView:(UIImageView *)imageView withImageCacheOrDownloadFromURL:(NSString *)urlString{
    __block NSData *imageData  = [self getDataWithUrlString:urlString];
    if (imageData == nil) {
        
        NSLog(@"%s [LINE:%d] 无图片缓存,从网络获取", __func__, __LINE__);
        [imageView setImageWithURLRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]]
                         placeholderImage:[UIImage imageNamed:@"缺省图1"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            imageData = [NSData dataWithData:UIImagePNGRepresentation(image) ];
                                            imageView.image = [UIImage imageWithData:imageData];
                                            [self saveData:[NSData dataWithData:imageData] withFilename:urlString];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                            NSLog(@"%s [LINE:%d] download failed.", __func__, __LINE__);
        }];
    }
    else{
        NSLog(@"%s [LINE:%d] 有图片缓存", __func__, __LINE__);
        imageView.image = [UIImage imageWithData:imageData];
    }
}
-(NSData *)getDataWithUrlString:(NSString *)urlString{
    
    NSString *filename  = [NSString stringWithFormat:@"%@/Documents/DataCache/%@",NSHomeDirectory(),[urlString MD5Hash]];
    
    //如果不存在==>没有缓存
    if ([[NSFileManager defaultManager] fileExistsAtPath:filename] == NO) {
        return  nil;
    }
    else{
        // 最后操作文件的 时间差
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:[self getlastmodifyTime:filename]];
        if (interval > self.validTime)
            return nil;
    }
    return [NSData dataWithContentsOfFile:filename];//从本地文件读取出数据,返回.
    
}

//取最后操作文件的时间
-( NSDate *)getlastmodifyTime:(NSString *)filename{
    
    //存的是当前文件的属性列表;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filename error:nil];
    return dic[@"NSFileModificationDate"];
}

@end
