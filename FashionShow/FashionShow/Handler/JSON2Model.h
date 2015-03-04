//
//  JSON2Model.h
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON2Model : NSObject

+(NSArray *)JSONData2ModelWithURLIdentifier:(NSString *)urlIdentifier andDataType:(int)dataType;

@end
