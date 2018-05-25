//
//  UMShareTypeViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/16/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMShareTypeViewController.h"
#import <UShareUI/UShareUI.h>
#import "UMShareCustomParamView.h"
#import <MobileCoreServices/MobileCoreServices.h>

static NSString* const UMS_Title = @"【友盟+】社会化组件U-Share";
static NSString* const UMS_Prog_Title = @"【友盟+】U-Share小程序";
static NSString* const UMS_Text = @"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Text_image = @"i欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Web_Desc = @"W欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Music_Desc = @"M欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Video_Desc = @"V欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";

static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";


typedef void (^PickMediaBlock)(NSURL *);

@interface UMShareTypeViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UMSocialPlatformType platform;

@property (nonatomic, strong) NSDictionary *platfomrSupportTypeDict;

@property (nonatomic, strong) UMShareCustomParamView *paramView;

@property (nonatomic, copy) PickMediaBlock pickMediaCompletion;

@end


@implementation UMShareTypeViewController

- (instancetype)initWithType:(UMSocialPlatformType)type
{
    if (self = [super init]) {
        self.platform = type;
        [self initPlatfomrSupportType];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *platformName = nil;
    NSString *iconName = nil;
    [UMSocialUIUtility configWithPlatformType:self.platform withImageName:&iconName withPlatformName:&platformName];
    self.titleString = [NSString stringWithFormat:@"分享到%@", platformName];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UMS_SHARE_TBL_CELL];

    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.bounds;
}

- (void)initPlatfomrSupportType
{
    self.platfomrSupportTypeDict =
    @{
      @(UMSocialPlatformType_WechatSession): @[@(UMS_SHARE_TYPE_MINI_PROGRAM), @(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_EMOTION), @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_WechatTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_WechatFavorite): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_Sina): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_MULTI), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_QQ): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Qzone): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_MULTI), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Tim): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_AlipaySession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_DingDing): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK)],
      
      @(UMSocialPlatformType_LaiWangSession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_LaiWangTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinSession): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinTimeLine): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_YixinFavorite): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Douban): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Renren): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_TencentWb): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Linkedin): @[@(UMS_SHARE_TYPE_TEXT), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Facebook): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL),  @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_VIDEO)],
      
      @(UMSocialPlatformType_Twitter): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_Instagram): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_KakaoTalk): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Line): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Tumblr): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_MULTI), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_EMOTION)],
      
      @(UMSocialPlatformType_Pinterest): @[@(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Whatsapp): @[@(UMS_SHARE_TYPE_TEXT), @(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Flickr): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL)],
      
      @(UMSocialPlatformType_Sms): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE)],
      
      @(UMSocialPlatformType_Email): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_TEXT_IMAGE), @(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_YouDaoNote): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK), @(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_EverNote): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK),  @(UMS_SHARE_TYPE_FILE)],
      
      @(UMSocialPlatformType_GooglePlus): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      @(UMSocialPlatformType_Pocket): @[@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
       @(UMSocialPlatformType_DropBox): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE),@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK),@(UMS_SHARE_TYPE_FILE)],
      @(UMSocialPlatformType_VKontakte): @[@(UMS_SHARE_TYPE_TEXT),@(UMS_SHARE_TYPE_IMAGE),@(UMS_SHARE_TYPE_IMAGE_URL), @(UMS_SHARE_TYPE_WEB_LINK), @(UMS_SHARE_TYPE_MUSIC_LINK), @(UMS_SHARE_TYPE_VIDEO_LINK)],
      
      @(UMSocialPlatformType_FaceBookMessenger): @[@(UMS_SHARE_TYPE_IMAGE), @(UMS_SHARE_TYPE_IMAGE_URL),  @(UMS_SHARE_TYPE_WEB_LINK)],
      };
}

- (NSString *)typeNameWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            return @"纯文本";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            return @"本地图片";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_MULTI:
        {
            return @"多张图片";
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            return @"HTTPS网络图片";
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
            if (self.platform == UMSocialPlatformType_Linkedin) {
                return @"文本+HTTPS图片";
            }
            return @"文本+图片";
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            return @"网页链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
            return @"音乐链接";
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
            return @"本地音乐";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
            return @"视频连接";
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
            return @"本地视频";
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            return @"Gif表情";
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            return @"文件";
        }
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            return @"微信小程序";
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)shareWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            [self shareTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            [self shareImageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_MULTI:
        {
            [self shareMultiImageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            [self shareImageURLToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_TEXT_IMAGE:
        {
            [self shareImageAndTextToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            [self shareWebPageToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC_LINK:
        {
            [self shareMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MUSIC:
        {
//            [self shareLocalMusicToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO_LINK:
        {
            [self shareVedioToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_VIDEO:
        {
            __weak typeof(self) ws = self;
            [self pickMediaDataURLWithCompletion:^(NSURL *url) {
                [ws shareVedioToPlatformType:ws.platform withUrlString:url.absoluteString];
            }];
        }
            break;
        case UMS_SHARE_TYPE_EMOTION:
        {
            [self shareEmoticonToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_FILE:
        {
            [self shareFileToPlatformType:self.platform];
        }
            break;
        case UMS_SHARE_TYPE_MINI_PROGRAM:
        {
            [self shareMiniProgramToPlatformType:self.platform];
        }
            break;
        default:
            break;
    }
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];
    return typeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UMS_SHARE_TBL_CELL];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:.35 blue:.3 alpha:1];
    
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];

    cell.textLabel.text = [self typeNameWithType:[typeList[indexPath.row] integerValue]];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageNamed:@"access"]
                                                                         size:CGSizeMake(8.f, 14.f)]];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongGesture:)];
    
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];

    [self shareWithType:[typeList[indexPath.row] integerValue]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

#pragma mark - pick image
- (void)pickMediaDataURLWithCompletion:(PickMediaBlock)completion
{
    self.pickMediaCompletion = completion;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,nil];
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    if (self.pickMediaCompletion) {
        self.pickMediaCompletion(videoURL);
    }
    
}

#pragma mark - Long gesture
- (void)cellLongGesture:(UIGestureRecognizer *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.view;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSArray *typeList = self.platfomrSupportTypeDict[@(self.platform)];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self shareCustomParamWithType:[typeList[indexPath.row] integerValue]];
    }
}

- (void)shareCustomParamWithType:(UMS_SHARE_TYPE)type
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
//        case UMS_SHARE_TYPE_IMAGE:
        case UMS_SHARE_TYPE_IMAGE_URL:
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            self.paramView = [[UMShareCustomParamView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:_paramView];
            __weak typeof(self) ws = self;
            [_paramView showCustomShareWithType:type completion:^(UMS_SHARE_TYPE type, NSDictionary *data) {
                [ws shareWithType:type param:data];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)shareWithType:(UMS_SHARE_TYPE)type param:(NSDictionary *)paramDict
{
    switch (type) {
        case UMS_SHARE_TYPE_TEXT:
        {
            
            [self shareTextToPlatformType:self.platform withText:paramDict[UMSCUSTOM_PARAM_TEXT]];
        }
            break;
        case UMS_SHARE_TYPE_IMAGE:
        {
            [self shareImageToPlatformType:self.platform withThumb:paramDict[UMSCUSTOM_PARAM_THUMB] image:paramDict[UMSCUSTOM_PARAM_IMAGE]];
            
        }
            break;
        case UMS_SHARE_TYPE_IMAGE_URL:
        {
            [self shareImageURLToPlatformType:self.platform withThumb:paramDict[UMSCUSTOM_PARAM_THUMB] image:paramDict[UMSCUSTOM_PARAM_IMAGE_URL]];
            
        }
            break;
        case UMS_SHARE_TYPE_WEB_LINK:
        {
            [self shareWebPageToPlatformType:self.platform withTitle:paramDict[UMSCUSTOM_PARAM_TITLE] descr:paramDict[UMSCUSTOM_PARAM_DESCR] url:paramDict[UMSCUSTOM_PARAM_LINK] thumb:paramDict[UMSCUSTOM_PARAM_THUMB]];
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    [self shareTextToPlatformType:platformType withText:UMS_Text];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType withText:(NSString *)text
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

     
//分享小程序
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:UMS_Prog_Title descr:UMS_Text thumImage:[UIImage imageNamed:@"icon"]];
    shareObject.webpageUrl = @"http://sdk.umsns.com/download/demo/";
    shareObject.userName = @"gh_3ac2059ac66f";
    shareObject.path = @"pages/page10007/page10007";
    shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"]];
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
  
         
//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    [self shareImageToPlatformType:platformType withThumb:[UIImage imageNamed:@"icon"] image:[UIImage imageNamed:@"logo"]];
}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType withThumb:(id)thumb image:(id)image
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = thumb;
    
    [shareObject setShareImage:image];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
     
     
     //分享多张图片
- (void)shareMultiImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = @"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];

    shareObject.shareImageArray = @[UIImagePNGRepresentation([UIImage imageNamed:@"logo"]), UIImagePNGRepresentation([UIImage imageNamed:@"icon"]), UIImagePNGRepresentation([UIImage imageNamed:@"logo"]), [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"], [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"], [UIImage imageNamed:@"icon"], [UIImage imageNamed:@"logo"]];

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

#ifdef UM_Swift
[UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************分享失败 %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//分享网络图片
- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
{
    [self shareImageURLToPlatformType:platformType withThumb:UMS_THUMB_IMAGE image:UMS_IMAGE];
}
- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType withThumb:(id)thumb image:(id)image
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = thumb;
    
    [shareObject setShareImage:image];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//分享图片和文字
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = UMS_Text_image;
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    if (platformType == UMSocialPlatformType_Linkedin) {
        // linkedin仅支持URL图片
        shareObject.thumbImage = UMS_THUMB_IMAGE;
        [shareObject setShareImage:UMS_IMAGE];
    } else {
        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        shareObject.shareImage = [UIImage imageNamed:@"logo"];
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    [self shareWebPageToPlatformType:platformType withTitle:UMS_Title descr:UMS_Web_Desc url:UMS_WebLink thumb:UMS_THUMB_IMAGE];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title descr:(NSString *)descr url:(NSString *)url thumb:(id)thumb
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  thumb;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

//音乐分享
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:UMS_Title descr:UMS_Music_Desc thumImage:thumbURL];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    shareObject.musicDataUrl = @"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
    
}
//视频分享
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType
 {
     [self shareVedioToPlatformType:platformType withUrlString:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"];
 }
 
 - (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType withUrlString:(NSString *)url
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Video_Desc thumImage:thumbURL];
    //设置视频网页播放地址
    shareObject.videoUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

/*
- (void)shareLocalVedioToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    //设置视频网页播放地址
    //shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"videoviewdemo" withExtension:@"mp4"];
    NSData* videoData = [[NSData alloc] initWithContentsOfURL:bundleURL];
    shareObject.videoData = videoData;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
*/

- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res6"
                                                         ofType:@"gif"];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    shareObject.emotionData = emoticonData;
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)shareFileToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareFileObject *shareObject = [UMShareFileObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    
    NSString *kFileExtension = @"txt";
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"umengFile"
                                                         ofType:kFileExtension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    shareObject.fileData = fileData;
    shareObject.fileExtension = kFileExtension;
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
#ifdef UM_Swift
    [UMShareSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
    
}

#define BUFFER_SIZE 1024 * 100
//微信官方不推荐使用
- (void)shareExternAppToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareExtendObject *shareObject = [UMShareExtendObject shareObjectWithTitle:UMS_Title descr:UMS_Text thumImage:thumbURL];
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    shareObject.url =  @"http://weixin.qq.com";
    shareObject.extInfo = @"<xml>extend info</xml>";
    shareObject.fileData = data;
    
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}



- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share complete"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}


- (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}

@end
