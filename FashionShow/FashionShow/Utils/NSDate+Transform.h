//
//  NSDate+Transform.h
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Transform)

+(NSString *)transformDateFromIntevalSince1970:(NSString *)date_in_1970
                                   withFormate:(NSString *)formate;

@end
