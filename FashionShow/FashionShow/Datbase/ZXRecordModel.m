//
//  ZXRecordModel.m
//  FashionShow
//
//  Created by zx on 15/3/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXRecordModel.h"

@implementation ZXRecordModel

-(NSString *)description{
    return[NSString stringWithFormat:@"recoredModel: recordType=%d, article_title=%@, article_link=%@, article_id=%@,article_image_link=%@ favouriteImageHeight=%.f",self.recordType,self.article_title,self.article_link,self.article_id,self.article_image_link,self.favouriteImageHeight];
}

@end
