//
//  NSDate+Transform.m
//  FashionShow
//
//  Created by zx on 15/2/4.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "NSDate+Transform.h"

@implementation NSDate (Transform)

+(NSString *)transformDateFromIntevalSince1970:(NSString *)date_in_1970
                                   withFormate:(NSString *)formate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    
    if (formate != nil ) {
        [dateFormatter setDateFormat:formate];
    }
    else{
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }
    
    return  [dateFormatter stringFromDate:
             [NSDate dateWithTimeIntervalSince1970:
                                           [date_in_1970 intValue]]];
}

/*
 ~~~objectivec
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
 [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
 NSDate *theday = [NSDate dateWithTimeIntervalSince1970:1422515735];
 NSString *day = [dateFormatter stringFromDate:theday];
 NSLog(@"%s [LINE:%d] day=%@", __func__, __LINE__,day);
 
 NSDate *now = [[NSDate alloc]init];
 NSLog(@"%s [LINE:%d] now=%@", __func__, __LINE__,now);
 ~~~

 */

@end
