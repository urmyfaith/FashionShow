//
//  PostCommentViewController.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "PostCommentViewController.h"
#import "ShowCommentsViewController.h"
#import "ZXNames.h"

@interface PostCommentViewController ()<UITextViewDelegate>

@end


#define textView_top_gap  10.0f
#define textView_left_gap  10.0f
#define textView_height  100.0f
#define wordsCount_label_height 30.0f

#define PLACEHOLDER_TEXT_STRING @"这篇文章真棒!"


#define TEXTVIEW_SHOULD_INPUT_TEXTLENGTH 140

#define TEXTVIEW_MAX_INPUT_TEXTLENGTH 200

@implementation PostCommentViewController

{
    UITextView *_textView;
    UILabel *_wordsCount_label;
    NSString *_urlIdentifier;
}

-(instancetype)init{

    if (self = [super init]) {
        _isCommentSuccess = @"0";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.00f green:0.98f blue:0.95f alpha:1.00f];
    [self createNavitaionbar];
    
    [self createTextView];
}

-(void)createTextView
{

    _textView = [[UITextView alloc]initWithFrame:CGRectMake(textView_left_gap,
                                                            zxStatusBar_NavigatinBar_HEIGHT+textView_top_gap,
                                                            self.view.frame.size.width - textView_left_gap*2,
                                                            textView_height)];
    _textView.text = PLACEHOLDER_TEXT_STRING;
    _textView.textColor = [UIColor lightGrayColor]; //optional
    
    _textView.font = [UIFont systemFontOfSize:16];
    
    //实际开发中,不是使用的layer层,而是是使用一张图片,进行拉伸缩.
    _textView.layer.masksToBounds=YES;
    _textView.layer.borderWidth=1.0;
    _textView.layer.cornerRadius = 5.0;
    _textView.backgroundColor  =  [UIColor colorWithRed:1.0f green:0.98f blue:0.95f alpha:1.00f];
    _textView.layer.borderColor = [[UIColor grayColor] CGColor];
    _textView.delegate =self;
    _textView.scrollEnabled = NO;
    [self.view addSubview:_textView];
    
    _wordsCount_label = [[UILabel alloc]initWithFrame:CGRectMake(textView_left_gap,
                                                                 _textView.frame.size.height- wordsCount_label_height ,
                                                                _textView.frame.size.width-2*textView_left_gap,
                                                                 wordsCount_label_height)];
    _wordsCount_label.text = [NSString stringWithFormat:@"%d",TEXTVIEW_SHOULD_INPUT_TEXTLENGTH];
    _wordsCount_label.textAlignment = NSTextAlignmentRight;
    [_textView addSubview:_wordsCount_label];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}

#pragma mark 输入框的代理


#pragma mark 实现placeHolder

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([_textView.text isEqualToString:PLACEHOLDER_TEXT_STRING]) {
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor]; //optional
    }
    [_textView becomeFirstResponder];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([_textView.text isEqualToString:@""]) {
        _textView.text = PLACEHOLDER_TEXT_STRING;
        _textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [_textView resignFirstResponder];
}


#pragma mark 限制输入长度

/**
 *  限制输入长度
 *
 思路:先得到原来的字符===>假设插入字符====>根据长度判断是否应该插入.
 *  @param textView 输入框
 *  @param range    光标位置+输入的长度
 *  @param text     输入的字符
 *
 *  @return yes,可以输入,no,不能输入
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

#if 1
    //将改变的字符串插入到源字符串中
    NSMutableString *mutString = [NSMutableString stringWithFormat:@"%@",_textView.text];
    [mutString insertString:text atIndex:range.location];
    //NSLog(@"mutString = %@ length=%lu",mutString,mutString.length);

    if ([mutString length] > TEXTVIEW_MAX_INPUT_TEXTLENGTH )
        return NO;
#else
    NSString * toBeString = [_textView.text stringByReplacingCharactersInRange:range withString:text];
    //NSLog(@"toBeString = %@ length=%lu",toBeString,toBeString.length);
    if ([toBeString length] > TEXTVIEW_MAX_INPUT_TEXTLENGTH )
        return NO;
#endif

    return YES;
}

#pragma mark 动态调整文本的高度

- (void)textViewDidChange:(UITextView *)textView{
    
    //第一步: 固定宽度
    CGFloat fixedWidth = _textView.frame.size.width;
    
    //第二步: 调整高度
    CGSize newSize = [_textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    
    //第三步: 得到之前的frame
    CGRect newFrame = _textView.frame;
    
    //第四步: 更改frame
    if (newSize.height + wordsCount_label_height >= textView_height) {
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height + wordsCount_label_height);
       
        //第五步: 应用新的frame
        _textView.frame = newFrame;

        _wordsCount_label.frame = CGRectMake(textView_left_gap,
                                             _textView.frame.size.height- wordsCount_label_height ,
                                             _textView.frame.size.width-2*textView_left_gap,
                                             wordsCount_label_height);
    }
}


#pragma mark 实时检测文本长度的变化

//此方法执行顺序在 textViewDidChange 方法之前

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
    //根据当前的字数,调整提示标签的number和颜色.
    NSString *textView_currentText = _textView.text;
    
    int count =  TEXTVIEW_SHOULD_INPUT_TEXTLENGTH - (int)textView_currentText.length;
       _wordsCount_label.text = [NSString stringWithFormat:@"%3d",count];
    if ( count >=  0 ) {
        _wordsCount_label.textColor  = [UIColor blackColor];
    }
    else{
        _wordsCount_label.textColor = [UIColor redColor];
    }
}

#pragma mark 绘制顶部导航栏
//重写root的创建导航栏的方法
-(void)createNavitaionbar{
    
    [self createRootNavigaitonBarWithTitleImag:nil
                                      andIsTop:NO
                                  andTitleName:@"写评论"
                            andBackgroundImage:nil
                          andLeftBtnImagesName:@"内文返回_1"
                         andRightBtnImagesName:@"确认_1"
                                      andClass:self
                                        andSEL:@selector(navigationBarClicked:)];
}

-(void)navigationBarClicked:(UIButton *)button{
    if (button.tag == zxNavigaionBarButtonLeftTag) {
#if 1
        [self.navigationController popViewControllerAnimated:YES];
#else
        [self dismissViewControllerAnimated:YES completion:nil];
#endif
    }
    if (button.tag == zxNavigaionBarButtonRightTag) {
        
        if ( _textView.text.length > TEXTVIEW_SHOULD_INPUT_TEXTLENGTH) {
            //提示删减文字
           // NSLog(@"%s [LINE:%d]", __func__, __LINE__);
        }
        else {
            //发送评论,跳转页面
            // NSLog(@"%s [LINE:%d]", __func__, __LINE__);
            //需要得到参数: 页面id,评论的内容,作者名称
            
            //发送评论,接收返回值===>显示发送状态,是否返回?
            
            [self downloadData];
            [self addObserver:self forKeyPath:@"isCommentSuccess" options:NSKeyValueObservingOptionNew context:nil]; //KVO---步骤1
           
        }
    }
}

//KVO---步骤3
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self removeObserver:self forKeyPath:@"isCommentSuccess" context:nil];//KVO---步骤4
    if ([_isCommentSuccess isEqualToString:@"1"]) {
        //评论成功
        NSLog(@"%s [LINE:%d]", __func__, __LINE__);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"%s [LINE:%d]", __func__, __LINE__);
    }
}


#pragma mark 下载数据
-(void)downloadData{

#pragma mark 随机生成姓名
    
    NSArray *namesArray = [ZXNames readNamesFromFilename:@"name" andFiletype:@"txt"];
    NSString *name = [namesArray objectAtIndex:arc4random()%(namesArray.count)];
    
    NSString *postData_string = @"action=wzpl&id=%@&name=%@&content=%@&uid=11111111&platform=a&mobile=HUAWEI+P6-C00&pid=10129&e=a2ae6a1b2c1a6aa2faa07bf2bd57ab37";
    
    postData_string = [NSString stringWithFormat:postData_string,_article_id,name,_textView.text];
    _urlIdentifier= [NSString stringWithFormat:@"%@%@",zxAPI_FULLPATH,postData_string];
    
    NSLog(@"%s [LINE:%d] _urlIdentifier=%@", __func__, __LINE__,_urlIdentifier);
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(postCommentFinish)
                                                name:_urlIdentifier
                                              object:nil];
    [[DownloadManager sharedDownloadManager] addDownloadWithDownloadURL:zxAPI_FULLPATH andDownloadResqustMethod:@"POST"andPostDataString:postData_string];
}


-(void)postCommentFinish{
    NSData *commentStatusData = [[DownloadManager sharedDownloadManager]getDownloadDataWithURLIdentifier:_urlIdentifier];
    
    NSDictionary *commentStatusDic = [NSJSONSerialization JSONObjectWithData:commentStatusData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%s [LINE:%d] commentStatusDic = %@", __func__, __LINE__,commentStatusDic);
    
    //需要使用属性
    //KVO---步骤2
    self.isCommentSuccess = [commentStatusDic objectForKey:@"code"];
    
}

@end
