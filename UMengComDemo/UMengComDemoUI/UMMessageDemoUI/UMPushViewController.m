//
//  UMPushViewController.m
//  UMengComDemo
//
//  Created by shile on 2018/1/30.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMPushViewController.h"
#import <UMPush/UMessage.h>
#import "UMAlertView.h"
@interface UMPushViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *tag;
@property (strong, nonatomic) UITextField *weightedTagName;
@property (strong, nonatomic) UITextField *weightedTagValue;
@property (strong, nonatomic) UITextField *aliasName;
@property (strong, nonatomic) UITextField *aliasType;
@property (strong, nonatomic) UILabel *tagRemain;
@property (strong, nonatomic) UILabel *weightedTagRemain;

@end

@implementation UMPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1/1.0];
    self.title = @"推送";
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 760);
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_scrollView];
    [self initTagUI];
    [self initWeightedTagUI];
    [self initAliasUI];
    [self initCardMessageUI];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"-0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_tag resignFirstResponder];
    [_weightedTagName resignFirstResponder];
    [_weightedTagValue resignFirstResponder];
    [_aliasName resignFirstResponder];
    [_aliasType resignFirstResponder];
}

-(void)addTag
{
    if ([_tag.text length]> 0 ) {
        [UMessage addTags:_tag.text response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
            if (responseObject) {
                if ([[responseObject objectForKey:@"success"] isEqualToString:@"ok"]) {
                    _tagRemain.text = [responseObject objectForKey:@"remain"];
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"添加成功!" content:_tag.text];
                    [alert showAlert];
                    
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加失败!" content:[NSString stringWithFormat:@"%@",responseObject]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加失败!" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"Tag不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)deleteTag
{
    if ([_tag.text length]> 0 ) {
        [UMessage deleteTags:_tag.text response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
            if (responseObject) {
                if ([[responseObject objectForKey:@"success"] isEqualToString:@"ok"]) {
                    _tagRemain.text = [responseObject objectForKey:@"remain"];
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"删除成功!" content:_tag.text];
                    [alert showAlert];
                    
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除失败!" content:[NSString stringWithFormat:@"%@",responseObject]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除失败!" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"Tag不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)getAllTags
{
    [UMessage getTags:^(NSSet * _Nonnull responseTags, NSInteger remain, NSError * _Nonnull error) {
        if (responseTags) {
            _tagRemain.text = [NSString stringWithFormat:@"%ld",remain];
            NSArray * tags = [responseTags allObjects];
            UMAlertView * alert = [[UMAlertView alloc] initMessageViewWithTitle:@"展示所有标签" content:[tags componentsJoinedByString:@","]];
            [alert showAlert];
        }else
        {
            UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误!" content:error.localizedDescription];
            [alert showAlert];
        }
    }];
}

-(void)addWeightedTag
{
    if (([_weightedTagName.text length]> 0 )&& ([_weightedTagValue.text length]> 0 )) {
        NSDictionary * weightedTag = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:[_weightedTagValue.text intValue]] ,_weightedTagName.text, nil];
        [UMessage addWeightedTags:weightedTag response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
            if (responseObject){
                if ([[responseObject objectForKey:@"code"] intValue] == 200) {
                    _weightedTagRemain.text = [[responseObject objectForKey:@"data"] objectForKey:@"remian"];
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"添加加权标签成功！" content: [self stringByReplaceUnicode:[NSString stringWithFormat:@"%@",weightedTag]]];
                    [alert showAlert];
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加加权标签失败！" content: [self stringByReplaceUnicode:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]]]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加加权标签失败！" content: [self stringByReplaceUnicode:error.localizedDescription]];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"WeightedTag不能为空或者空字串"];
        [alert showAlert];
    }

}

-(void)deleteWeightedTag
{
    if ([_weightedTagName.text length]> 0 ) {
        [UMessage deleteWeightedTags:_weightedTagName.text response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
            if (responseObject){
                if ([[responseObject objectForKey:@"code"] intValue] == 200) {
                    _weightedTagRemain.text = [[responseObject objectForKey:@"data"] objectForKey:@"remian"];
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"删除加权标签成功！" content: _weightedTagName.text];
                    [alert showAlert];
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除加权标签失败！" content: [self stringByReplaceUnicode:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]]]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除加权标签失败！" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"WeightedTag不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)getAllWeightedTag
{
    [UMessage getWeightedTags:^(NSDictionary * _Nonnull responseWeightedTags, NSInteger remain, NSError * _Nonnull error) {
        _tagRemain.text = [NSString stringWithFormat:@"%ld",remain];
        if (responseWeightedTags) {
            UMAlertView * alert = [[UMAlertView alloc] initMessageViewWithTitle:@"展示所有加权标签" content: [self stringByReplaceUnicode:[NSString stringWithFormat:@"%@",responseWeightedTags]]];
            [alert showAlert];
        }else
        {
            UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:error.localizedDescription];
            [alert showAlert];
        }
        
    }];
}

-(void)addAlias
{
    if (([_aliasName.text length]> 0 )&& ([_aliasType.text length]> 0 )) {
        [UMessage addAlias:_aliasName.text type:_aliasType.text response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            if (responseObject) {
                if ([[responseObject objectForKey:@"success"] isEqualToString:@"ok"]) {
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"添加别名成功！" content:[NSString stringWithFormat:@"aliasName:【%@】\naliasType:【%@】",_aliasName.text,_aliasType.text]];
                    [alert showAlert];
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加别名失败!" content:[NSString stringWithFormat:@"%@",responseObject]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"添加别名失败!" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"别名不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)deleteAlias
{
    if (([_aliasName.text length]> 0 )&& ([_aliasType.text length]> 0 )) {
        [UMessage removeAlias:_aliasName.text type:_aliasType.text response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            if (responseObject) {
                if ([[responseObject objectForKey:@"success"] isEqualToString:@"ok"]) {
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"删除别名成功！" content:[NSString stringWithFormat:@"aliasName:【%@】\naliasType:【%@】",_aliasName.text,_aliasType.text]];
                    [alert showAlert];
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除别名失败!" content:[NSString stringWithFormat:@"%@",responseObject]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"删除别名失败!" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"别名不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)setAlias
{
    if (([_aliasName.text length]> 0 )&& ([_aliasType.text length]> 0 )) {
        [UMessage setAlias:_aliasName.text type:_aliasType.text response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            if (responseObject) {
                if ([[responseObject objectForKey:@"success"] isEqualToString:@"ok"]) {
                    UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"Set别名成功！" content:[NSString stringWithFormat:@"aliasName:【%@】\naliasType:【%@】",_aliasName.text,_aliasType.text]];
                    [alert showAlert];
                }else
                {
                    UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"Set别名失败!" content:[NSString stringWithFormat:@"%@",responseObject]];
                    [alert showAlert];
                }
            }else
            {
                UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"Set别名失败!" content:error.localizedDescription];
                [alert showAlert];
            }
        }];
    }else
    {
        UMAlertView * alert = [[UMAlertView alloc] initErrorAlertViewWithTitle:@"错误" content:@"别名不能为空或者空字串"];
        [alert showAlert];
    }
}

-(void)addCardMessage
{
    [UMessage addCardMessageWithLabel:@"democard"];
}

-(void)addCustomCardMessage
{
    [UMessage addCustomCardMessageWithPortraitSize:CGSizeMake(300, 450) LandscapeSize:CGSizeMake(200, 300) CloseBtn:nil Label:@"democustomcard" umCustomCloseButtonDisplayMode:YES];
}

-(void)addTextCardMessage
{
    [UMessage addPlainTextCardMessageWithTitleFont:[UIFont systemFontOfSize:16] ContentFont:[UIFont systemFontOfSize:14] buttonFont:[UIFont systemFontOfSize:16] Label:@"demotextcrad"];
}

-(void)initTagUI
{
    UIView * tagView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, CGRectGetWidth(self.view.frame) , 140)];
    tagView.backgroundColor = [UIColor whiteColor];
    
    UILabel *namelabel = [self createLabelWithTitle:@"标签"];
    namelabel.frame = CGRectMake(16, 17, 28, 22);
    [namelabel sizeToFit];
    [tagView addSubview:namelabel];
    
    _tagRemain = [self createLabelWithTitle:@"0"];
    _tagRemain.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 50, 17, 50, 22);
//    [_tagRemain sizeToFit];
    [tagView addSubview:_tagRemain];
    
    _tag = [self createTextFieldWithHolderText:@"请输入Tag"];
    _tag.frame = CGRectMake(16, 43, CGRectGetWidth(self.view.frame) - 32, 32);
    [tagView addSubview:_tag];
    
    UIButton * addbutton = [self createButtonWithTitle:@"添加"];
    addbutton.frame = CGRectMake(16, 91, 56, 32);
    [addbutton addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [tagView addSubview:addbutton];
    
    UIButton * deletebutton = [self createButtonWithTitle:@"删除"];
    deletebutton.frame = CGRectMake(CGRectGetMaxX(addbutton.frame) + 8, 91, 56, 32);
    [deletebutton addTarget:self action:@selector(deleteTag) forControlEvents:UIControlEventTouchUpInside];
    [tagView addSubview:deletebutton];
    
    UIButton * getall = [self createButtonWithTitle:@"展示所有"];
    getall.frame = CGRectMake(CGRectGetMaxX(deletebutton.frame) + 8, 91, 80, 32);
    [getall addTarget:self action:@selector(getAllTags) forControlEvents:UIControlEventTouchUpInside];
    [tagView addSubview:getall];
    
    
    [_scrollView addSubview:tagView];
}

-(void)initWeightedTagUI
{
    UIView * weightedTagView = [[UIView alloc]initWithFrame:CGRectMake(0, 185, CGRectGetWidth(self.view.frame) , 180)];
    weightedTagView.backgroundColor = [UIColor whiteColor];

    UILabel *namelabel = [self createLabelWithTitle:@"加权标签"];
    namelabel.frame = CGRectMake(16, 17, 20, 22);
    [namelabel sizeToFit];
    [weightedTagView addSubview:namelabel];
    
    _weightedTagRemain = [self createLabelWithTitle:@"0"];
    _weightedTagRemain.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 50, 17, 50, 22);
    [_weightedTagRemain sizeToFit];
    [weightedTagView addSubview:_weightedTagRemain];
    
    _weightedTagName = [self createTextFieldWithHolderText:@"请输入WeightedTagName"];
    _weightedTagName.frame = CGRectMake(16, CGRectGetMaxY(namelabel.frame) + 8, CGRectGetWidth(self.view.frame) - 32, 32);
    [weightedTagView addSubview:_weightedTagName];
    
    _weightedTagValue = [self createTextFieldWithHolderText:@"请输入Value(-10 ~ 10)，仅添加时填写"];
    _weightedTagValue.delegate = self;
    _weightedTagValue.frame = CGRectMake(16, CGRectGetMaxY(_weightedTagName.frame) + 8, CGRectGetWidth(self.view.frame) - 32, 32);
    [weightedTagView addSubview:_weightedTagValue];
    
    UIButton * addbutton = [self createButtonWithTitle:@"添加"];
    addbutton.frame = CGRectMake(16, CGRectGetMaxY(_weightedTagValue.frame) + 8, 56, 32);
    [addbutton addTarget:self action:@selector(addWeightedTag) forControlEvents:UIControlEventTouchUpInside];
    [weightedTagView addSubview:addbutton];
    
    UIButton * deletebutton = [self createButtonWithTitle:@"删除"];
    deletebutton.frame = CGRectMake(CGRectGetMaxX(addbutton.frame) + 8, CGRectGetMaxY(_weightedTagValue.frame) + 8, 56, 32);
    [deletebutton addTarget:self action:@selector(deleteWeightedTag) forControlEvents:UIControlEventTouchUpInside];
    [weightedTagView addSubview:deletebutton];
    
    UIButton * getall = [self createButtonWithTitle:@"展示所有"];
    getall.frame = CGRectMake(CGRectGetMaxX(deletebutton.frame) + 8, CGRectGetMaxY(_weightedTagValue.frame) + 8, 80, 32);
    [getall addTarget:self action:@selector(getAllWeightedTag) forControlEvents:UIControlEventTouchUpInside];
    [weightedTagView addSubview:getall];
    
    [_scrollView addSubview:weightedTagView];
}

-(void)initAliasUI
{
    UIView * aliasView = [[UIView alloc]initWithFrame:CGRectMake(0, 395, CGRectGetWidth(self.view.frame) , 180)];
    aliasView.backgroundColor = [UIColor whiteColor];
    
    UILabel *namelabel = [self createLabelWithTitle:@"别名"];
    namelabel.frame = CGRectMake(16, 17, 20, 22);
    [namelabel sizeToFit];
    [aliasView addSubview:namelabel];
    
    _aliasName = [self createTextFieldWithHolderText:@"请输入AliasName"];
    _aliasName.frame = CGRectMake(16, CGRectGetMaxY(namelabel.frame) + 8, CGRectGetWidth(self.view.frame) - 32, 32);
    [aliasView addSubview:_aliasName];
    
    _aliasType = [self createTextFieldWithHolderText:@"请输入AliasType"];
    _aliasType.frame = CGRectMake(16, CGRectGetMaxY(_aliasName.frame) + 8, CGRectGetWidth(self.view.frame) - 32, 32);
    [aliasView addSubview:_aliasType];
    
    UIButton * addbutton = [self createButtonWithTitle:@"添加"];
    addbutton.frame = CGRectMake(16, CGRectGetMaxY(_aliasType.frame) + 8, 56, 32);
    [addbutton addTarget:self action:@selector(addAlias) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:addbutton];
    
    UIButton * deletebutton = [self createButtonWithTitle:@"删除"];
    deletebutton.frame = CGRectMake(CGRectGetMaxX(addbutton.frame) + 8, CGRectGetMaxY(_aliasType.frame) + 8, 56, 32);
    [deletebutton addTarget:self action:@selector(deleteAlias) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:deletebutton];
    
    UIButton * setbutton = [self createButtonWithTitle:@"set Alias"];
    setbutton.frame = CGRectMake(CGRectGetMaxX(deletebutton.frame) + 8, CGRectGetMaxY(_aliasType.frame) + 8, 80, 32);
    [setbutton addTarget:self action:@selector(setAlias) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:setbutton];
    
    [_scrollView addSubview:aliasView];
}

-(void)initCardMessageUI
{
    UIView * aliasView = [[UIView alloc]initWithFrame:CGRectMake(0, 605, CGRectGetWidth(self.view.frame) , 140)];
    aliasView.backgroundColor = [UIColor whiteColor];
    
    UILabel *namelabel = [self createLabelWithTitle:@"应用内消息"];
    namelabel.frame = CGRectMake(16, 17, 20, 22);
    [namelabel sizeToFit];
    [aliasView addSubview:namelabel];
    
    UIButton * addbutton = [self createButtonWithTitle:@"添加普通插屏消息"];
    addbutton.frame = CGRectMake(16, CGRectGetMaxY(namelabel.frame) + 8, (CGRectGetWidth(self.view.frame) - 48) /2 , 32);
    [addbutton addTarget:self action:@selector(addCardMessage) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:addbutton];
    
    UIButton * addcustombutton = [self createButtonWithTitle:@"添加自定义插屏消息"];
    addcustombutton.frame = CGRectMake(CGRectGetMaxX(addbutton.frame) + 16, CGRectGetMaxY(namelabel.frame) + 8, (CGRectGetWidth(self.view.frame) - 48) /2, 32);
    [addcustombutton addTarget:self action:@selector(addCustomCardMessage) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:addcustombutton];
    
    UIButton * addtextbutton = [self createButtonWithTitle:@"添加文本插屏消息"];
    addtextbutton.frame = CGRectMake(16, CGRectGetMaxY(addbutton.frame) + 8, (CGRectGetWidth(self.view.frame) - 48) /2, 32);
    [addtextbutton addTarget:self action:@selector(addTextCardMessage) forControlEvents:UIControlEventTouchUpInside];
    [aliasView addSubview:addtextbutton];
    
    [_scrollView addSubview:aliasView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString
{
    NSString * string = [NSString stringWithCString:[[NSString stringWithFormat:@"%@",unicodeString] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return string;
    
}


- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    return label;
}

-(UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1/1.0].CGColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[self createImageWithColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self createImageWithColor:  [UIColor colorWithRed:30/255.0 green:128/255.0 blue:240/255.0 alpha:1/1.0]] forState:UIControlStateHighlighted];
    [button  setTitleColor:  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    [button  setTitleColor:  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0] forState:UIControlStateHighlighted];
    [button.titleLabel setFont: [UIFont systemFontOfSize:12]];
    return button;
}

-(UITextField *)createTextFieldWithHolderText:(NSString *)holderText
{
    UITextField *textField = [[UITextField alloc]init];
    textField.layer.borderWidth = 1.0f;
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(textField.frame.origin.x,textField.frame.origin.y,15.0, textField.frame.size.height)];
    textField.leftView = blankView;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.leftViewMode =UITextFieldViewModeAlways; 
    textField.layer.borderColor =  [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1/1.0].CGColor;
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:12]
                        range:NSMakeRange(0, holderText.length)];
    textField.attributedPlaceholder = placeholder;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    return textField;
}
@end
