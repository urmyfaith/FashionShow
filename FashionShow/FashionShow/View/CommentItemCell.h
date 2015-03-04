//
//  CommentItemCell.h
//  FashionShow
//
//  Created by zx on 15/2/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *adddate;

@property (weak, nonatomic) IBOutlet UILabel *content;

@end
