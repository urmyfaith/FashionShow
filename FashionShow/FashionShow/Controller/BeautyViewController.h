//
//  BeautyViewController.h
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "BaseViewController.h"

//引入协议，实现协议方法（协议方法的目的：实现不同的类之间传值）
#import "BeautyBaseView.h"
@interface BeautyViewController : BaseViewController<BeautyOneRowViewDelegate>

@end
