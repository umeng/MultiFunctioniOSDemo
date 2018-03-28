//
//  UMShareCustomParamView.m
//  UMengComDemo
//
//  Created by wyq.Cloudayc on 01/02/2018.
//  Copyright © 2018 张军华. All rights reserved.
//

#import "UMShareCustomParamView.h"
#import <UMShare/UMShare.h>

static NSString *TABLEVIEW_CELL_PARAM = @"TABLEVIEW_CELL_PARAM";
static NSUInteger TEXT_BASE_TAG = 91000;

@interface UMShareCustomParamView()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, strong) NSMutableDictionary *paramDict;
@property (nonatomic, assign) UMS_SHARE_TYPE type;
@property (nonatomic, assign) NSUInteger tableViewHeight;
@property (nonatomic, copy) UMSocialCustomParamCompletionHandler handler;

@end

@implementation UMShareCustomParamView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:maskView];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.5f;
        
        self.paramDict = [NSMutableDictionary dictionaryWithCapacity:4];
        
        //注册通知,监听键盘弹出事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        //注册通知,监听键盘消失事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden)
                                                     name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showCustomShareWithType:(UMS_SHARE_TYPE)type
                    completion:(UMSocialCustomParamCompletionHandler)completion
{
    self.type = type;
    self.handler = completion;
    
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            self.titleList = @[UMSCUSTOM_PARAM_TEXT];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            self.titleList = @[UMSCUSTOM_PARAM_IMAGE, UMSCUSTOM_PARAM_THUMB];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            self.titleList = @[UMSCUSTOM_PARAM_IMAGE_URL, UMSCUSTOM_PARAM_THUMB];
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            self.titleList = @[UMSCUSTOM_PARAM_TITLE, UMSCUSTOM_PARAM_DESCR, UMSCUSTOM_PARAM_LINK, UMSCUSTOM_PARAM_THUMB];
        }
            break;
            
        default:
            break;
    }
    
    [self customtableView];
}

- (void)customtableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TABLEVIEW_CELL_PARAM];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = [self headerView];
    UIView *footerView = [self footerView];
    self.tableView.tableFooterView = footerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTableView:)]];
    
    [self addSubview:_tableView];
    
    _tableViewHeight = [self cellHeight] * _titleList.count + footerView.frame.size.height * 2 + 10.f/*调整参数*/;
    CGRect frame = self.tableView.frame;
    frame.size.height = _tableViewHeight;
    frame.origin.y = self.bounds.size.height - _tableViewHeight;
    self.tableView.frame = frame;
}

- (UIView *)headerView
{
    CGRect frame = self.bounds;
    frame.size.height = 30.f;
    UILabel *title = [[UILabel alloc] initWithFrame:frame];
    title.font = [UIFont systemFontOfSize:14.f];
    title.textColor = [self colorWithHex:0x333333];
    title.text = @"  设置分享内容";
    
    return title;
}

- (UIView *)footerView
{
    UIButton *sendButton = [self buttonWithName:@"发送"];
    sendButton.backgroundColor = [UIColor colorWithRed:0.f/255.f green:134.f/255.f blue:220.f/255.f alpha:1.f];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.userInteractionEnabled = YES;
    [sendButton addTarget:self action:@selector(sendData:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelButton = [self buttonWithName:@"取消"];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancelButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancelButton.userInteractionEnabled = YES;
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = self.bounds;
    frame.size.height = inputPad + sendButton.frame.size.height;
    UIView *footer = [[UIView alloc] initWithFrame:frame];
    
    [footer addSubview:sendButton];
    [footer addSubview:cancelButton];
    
    // position of button
    frame.origin.y = 0.f;
    frame.size = sendButton.frame.size;
    frame.origin.x = footer.frame.size.width - frame.size.width - inputPad;
    sendButton.frame = frame;
    
    frame.origin.x = sendButton.frame.origin.x - sendButton.frame.size.width - inputPad;
    cancelButton.frame = frame;
    
    return footer;
}

- (void)onTapTableView:(id)sender
{
    [self endEditing:YES];
}

- (void)sendData:(id)sender
{
    if (_handler) {
        _handler(_type, _paramDict);
    }
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (void)cancel:(id)sender
{
    self.tableView = nil;
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (UIButton *)buttonWithName:(NSString *)name
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.f, 0.f, 56.f, 32.f);
    button.layer.borderColor = [UIColor colorWithRed:0.f green:0.53f blue:0.8f alpha:1.f].CGColor;
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 3.f;
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.f green:0.53f blue:0.86f alpha:1.f] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    return button;
}

- (NSString *)getInputTitle:(NSUInteger)index
{
    switch (index) {
        case 1:
            return @"文本";
            break;
        case 2:
            return @"标题";
            break;
        case 3:
            return @"描述";
            break;
        case 4:
            return @"链接";
            break;
        case 5:
            return @"本地图片";
            break;
        case 6:
            return @"网络图片url";
            break;
        case 7:
            return @"缩略图url";
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSUInteger)cellHeight
{
    CGFloat height = inputPad + inputTitleHeight + inputPad + inputTextHeight;// + inputPad;
    return height;
}

#pragma mark - delegate
static NSUInteger inputPad = 10.f;
static NSUInteger inputTitleHeight = 30.f;
static NSUInteger inputTextHeight = 30.f;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_PARAM];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    CGRect frame = CGRectMake(inputPad, 0.f, 100.f, inputTitleHeight);
    
    NSUInteger titleIndex = [self.titleList[indexPath.row] integerValue];
    
    NSUInteger titleTag = 9001;
    NSUInteger textViewTag = TEXT_BASE_TAG + titleIndex;
    
    UILabel *title = (UILabel *)[cell viewWithTag:titleTag];
    if (!title) {
        title = [[UILabel alloc] initWithFrame:frame];
        title.tag = titleTag;
        title.font = [UIFont systemFontOfSize:14.f];
        title.textColor = [self colorWithHex:0x666666];
        [cell addSubview:title];
    }
    title.text = [self getInputTitle:titleIndex];
    
    frame.origin = CGPointMake(inputPad, title.frame.origin.y + title.frame.size.height + inputPad);
    frame.size.width = self.bounds.size.width - inputPad * 2;
    frame.size.height = inputTextHeight;
    
    UITextView *textView = (UITextView *)[cell viewWithTag:textViewTag];
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:frame];
        textView.backgroundColor = [UIColor clearColor];
        
        textView.tag = textViewTag;
        textView.editable = YES;
        textView.font = [UIFont systemFontOfSize:13.f];
        textView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.borderWidth = 1.f;
        
        textView.delegate = self;
        [cell addSubview:textView];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeight];
}

#pragma mark - text delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *content = textView.text;
    NSUInteger index = textView.tag - TEXT_BASE_TAG;
    _paramDict[@(index)] = content;
}

#pragma mark - keyboard
-(void)keyboardDidShow:(NSNotification *)notification
{
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    CGRect frame = self.tableView.frame;
    CGFloat height = self.frame.size.height - keyboardRect.size.height;
    if (height < _tableViewHeight) {
        frame.size.height = height;
    }
    frame.origin.y = self.frame.size.height - keyboardRect.size.height - frame.size.height;
    self.tableView.frame = frame;
    [UIView commitAnimations];
    
}

-(void)keyboardDidHidden
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelay:0];
    CGRect frame = self.tableView.frame;
    frame.origin.y = self.frame.size.height - _tableViewHeight;
    frame.size.height = _tableViewHeight;
    self.tableView.frame = frame;
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


- (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:1.f];
}

@end
