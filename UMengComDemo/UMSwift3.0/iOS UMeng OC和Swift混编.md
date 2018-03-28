# iOS UMeng OC和Swift混编

Swift调用Objective-C需要建立一个桥接头文件进行交互

## 新建桥接头文件
<img src="http://dev.umeng.com/system/images/W1siZiIsIjIwMTcvMDUvMzEvMTdfMTVfNDFfOTM3X18ucG5nIl1d/新建桥接文件.png" > 

本例桥接文件命名为：**UMengDemo-Bridging-Header.h**

## 设置Objective-C桥接文件

<img src="http://dev.umeng.com/system/images/W1siZiIsIjIwMTcvMDUvMzEvMTdfMTZfMTJfNTUzX19PYmplY3RpdmVfQ18ucG5nIl1d/设置Objective-C桥接文件.png" > 

## 导入SDK头文件
在**UMengDemo-Bridging-Header.h**中加入U-Share SDK头文件：

```

//导入UMCommon的OC的头文件
#import <UMCommon/UMCommon.h>

//导入UShare的OC的头文件
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

//导入UMAnalytics的OC的头文件
#import <UMAnalytics/DplusMobClick.h>
#import <UMAnalytics/MobClick.h>
#import <UMAnalytics/MobClickGameAnalytics.h>

//导入UMPush的OC的头文件
#import <UMPush/UMessage.h>

```

## UMengDemo的OC和Swift的切换

UMengDemo是用OC的代码编写的，同时也兼容了swift3.0的调用示例（UMengDemo不再对swift2.0做示例兼容).

### swift文件夹的结构

![swift3.0源文件结构](http://dev.umeng.com/system/images/W1siZiIsIjIwMTcvMDUvMzEvMTdfMTZfNDlfODQ2X3N3aWZ0My4wXy5wbmciXV0/swift3.0的文件结构.png)

文件名功能说明如下：

> 1. UMSocialSDK-Bridging-Header.h 为swift3.0的桥接文件，主要是在swift3.0中，调用oc的代码。

> 2. UMShareSwiftInterface.swift 为社会化分享Swift3.0的接口文件，主要是为了展示用户让oc调用swift3.0的代码的示例（用户可以在swift3.0的工程中直接调用对应的swift接口）。
***备注:UMSocialSwiftInterface.swift这个文件是单独分享工程Demo用的swift文件，现在只是换了一个类名而已，请用户知晓。***

> 3. UMAnalyticsSwiftInterface.swift 为统计SDK的Swift3.0的接口文件和OC的API一一对应。

> 4. UMGameAnalyticsSwiftInterface.swift 为游戏统计SDK的Swift3.0的接口文件和OC的API一一对应。

> 5. UMDplusMobClickSwiftInterface.swift 为Dplus的统计SDK的Swift3.0的接口文件和OC的API一一对应。

> 6. UMessageSwiftInterface.swift 为PushSdk的Swift3.0的接口文件和OC的API一一对应。

> 7. UMCommonSwiftInterface.swift 为Common组件的Swift3.0的接口文件和OC的API一一对应。


## 设置切换swift的宏

![swift3.0宏设置](http://dev.umeng.com/system/images/W1siZiIsIjIwMTcvMDIvMDYvMTZfNTZfMzFfNTI5X3N3aWZ0M18wX3NldHRpbmcucG5nIl1d/swift3_0_setting.png)

### 引入对应的swift的头文件，并在OC中调用swift3.0的代码如下

代码如下

```

#ifdef UM_Swift
#import "UMengDemo-Swift.h"
#endif

//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = UMS_Text;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
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

```


**注意事项如下：**

1. **UMengDemo-Swift.h** 是工程自动为OC调用swift生成的，如果在新建的工程中应该是 **$(TARGET_NAME)-Swift.h** ，$(TARGET_NAME)为你的工程默认配置的名字


2. UMengDemo需要xcode8下打开，因为里面引入了swift3.0的文件，不然会编译出错（如果不需要swift3.0，直接运行OC的代码，可以去掉对应宏 **UM_Swift** 和工程里面对应的 **UMSwift3.0**文件夹 即可编译通过）。