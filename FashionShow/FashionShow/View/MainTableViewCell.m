//
//  MainTableViewCell.m
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "MainTableViewCell.h"
#import "GenericModel.h"


@implementation MainTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat gap = 5.0f;
        CGFloat cellHeight = 90.0f;
        CGFloat imageWidth = 50.0f;
        CGFloat imageHeight = 50.0f;
        CGFloat pictureWidth = 150.0f;
        CGFloat pictureHeight = 85.0f;
        
        UIImageView *backgroudImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zxSCRREN_WIDTH,cellHeight)];
        backgroudImageView.image = [UIImage imageNamed:@"背景"];
        [self.contentView addSubview:backgroudImageView];
        

        
        
        _mainCell_number_imageView = [[UIImageView alloc]init];
        _mainCell_number_imageView.frame = CGRectMake(gap,
                                                      (cellHeight - imageWidth)/2 ,
                                                      imageWidth,
                                                      imageHeight);
        [self.contentView addSubview:_mainCell_number_imageView];
        
        
        _mainCell_picture_imageView = [[UIImageView alloc]init];
        _mainCell_picture_imageView.frame = CGRectMake(CGRectGetMaxX(_mainCell_number_imageView.frame) + gap,
                                                       0,
                                                       pictureWidth,
                                                       pictureHeight);
        _mainCell_picture_imageView.clipsToBounds = YES;
        [_mainCell_picture_imageView.layer setCornerRadius:10];
        
        [self.contentView addSubview:_mainCell_picture_imageView];
        
        _mainCell_title_label = [[UILabel alloc]init];
        
        //如果屏幕宽度> 320,显示2行,
        //如果屏幕宽度 == 320 ,显示3行.
        
        _mainCell_title_label.frame = CGRectMake(CGRectGetMaxX(_mainCell_picture_imageView.frame)+gap,
                                                 0,
                                                 zxSCRREN_WIDTH - CGRectGetMaxX(_mainCell_picture_imageView.frame) - gap*2,
                                                 cellHeight);
        //NSLog(@" width = %.f",zxSCRREN_WIDTH);
        if (zxSCRREN_WIDTH > 320.f) {
            _mainCell_title_label.numberOfLines = 2;
        }
        else if (self.frame.size.width == 320.f)
            _mainCell_title_label.numberOfLines = 3;
        _mainCell_title_label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainCell_title_label];
        
    }
    return self;
}

+(MainTableViewCell *)cellWithTableView:(UITableView *)tableView{
    
    static NSString *identifer = @"mainCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

-(void)setMainCell_Model:(GenericModel *)mainCell_Model{
    _mainCell_Model = mainCell_Model;
    
    [_mainCell_picture_imageView setImageWithURL:[NSURL URLWithString:mainCell_Model.icon] placeholderImage:[UIImage imageNamed:@"列表图"]];
    _mainCell_title_label.text = mainCell_Model.title;
}

@end
