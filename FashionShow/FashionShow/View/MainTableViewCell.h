//
//  MainTableViewCell.h
//  FashionShow
//
//  Created by zx on 15/2/5.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GenericModel;


@interface MainTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView    *mainCell_number_imageView;
@property (nonatomic,strong) UIImageView    *mainCell_picture_imageView;
@property (nonatomic,strong) UILabel        *mainCell_title_label;

@property (nonatomic, strong) GenericModel  *mainCell_Model;

+(MainTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
