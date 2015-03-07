
#import <Foundation/Foundation.h>

@interface ZKDataCache : NSObject

@property(nonatomic,assign) NSTimeInterval validTime;

+(id)sharedInstance;
-(void)saveData:(NSData *)data withFilename:(NSString *)urlString;
-(NSData *)getDataWithUrlString:(NSString *)urlString;

-(NSData *)getImageFromCacheOrDownloadWithUrlString:(NSString *)urlString;

-(void)setImageOfImageView:(UIImageView *)imageView withImageCacheOrDownloadFromURL:(NSString *)urlString;
@end
