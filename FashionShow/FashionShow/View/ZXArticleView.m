//
//  ZXArticleView.m
//  FashionShow
//
//  Created by zx on 15/3/6.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXArticleView.h"


@interface ZXArticleView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZXArticleView
{
    UITableView *_tableView;
}

-(void)drawView{
    [self removeAllSubViewInView:self];
    if(self.modelsArray.count > 0){
        [self createTableView];
    }else{
        [self createTipsViewInView:self];
    }
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_tableView];
    NSLog(@"%@",NSStringFromCGRect(_tableView.frame));
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"articleView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时的颜色;
        CGFloat zxLableLeftGap = 15.0f;
        CGFloat zxLableHeight = 44.0f;
        
        UILabel *zxLable = [[UILabel alloc]init];
        zxLable.textColor = [UIColor whiteColor];
        zxLable.font = [UIFont systemFontOfSize:14];
        zxLable.frame = CGRectMake(zxLableLeftGap, 0, self.frame.size.width - zxLableLeftGap*2, zxLableHeight);
        zxLable.tag = 10086;
        [cell addSubview:zxLable];
    }
    UILabel *lable = (UILabel *)[cell viewWithTag:10086];
    lable.text = ((ZXRecordModel *)[self.modelsArray objectAtIndex:indexPath.row]).article_title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //执行页面跳转
    [self.delegate pushToViewControllerWithRecoredModel:[self.modelsArray  objectAtIndex:indexPath.row]];
}

@end
