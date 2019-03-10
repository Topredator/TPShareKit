# TPShareKit

[![CI Status](https://img.shields.io/travis/Topredator/TPShareKit.svg?style=flat)](https://travis-ci.org/Topredator/TPShareKit)
[![Version](https://img.shields.io/cocoapods/v/TPShareKit.svg?style=flat)](https://cocoapods.org/pods/TPShareKit)
[![License](https://img.shields.io/cocoapods/l/TPShareKit.svg?style=flat)](https://cocoapods.org/pods/TPShareKit)
[![Platform](https://img.shields.io/cocoapods/p/TPShareKit.svg?style=flat)](https://cocoapods.org/pods/TPShareKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TPShareKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TPShareKit'
```

## Author

Topredator, luyanggold@163.com

## License

TPShareKit is available under the MIT license. See the LICENSE file for more info.

## 使用
> 由于app中多个地方需要进行第三方平台分享功能，正好赶上项目进行组件化拆分，于是就自己写了个分享公共组件控件。目前该组件只集成了QQ、微信平台的分享；而且分享只提供关于链接、图片、文字功能。

由于有现成的第三方平台集成分享功能，所以此库，是在shareSDK的基础上进行封装，实现数据与UI的分离

- 提供了统一调用的API，引用`#import "TPShareKit.h" / #import "TPShareUIAPI.h"`
- 在分享时要先在第三方平台上面注册自己的app，可以获取`appkey`和`appSecret`两个参数，于是创建了一个关于注册信息的model，即`TPSharePlatformModel`


```objective-c
/// 注册第三方平台信息，有两种方式，一为使用代理，二为调用API接口，都是在application:didFinishLaunchingWithOptions:中调用
/// ①代理方式 协议<TPSharePlatformProtocol>
[TPShareAPI TPSharePlatformDelegate:self];
/// 注册平台信息
- (NSArray<TPSharePlatformModel *> *)TPFetchPlatforms {
    /// 使用链式语法
    return @[TPPlatformModel(@"appKey", @"appSecret", TPSharePlatformTypeQQ), TPPlatformModel(@"appKey", @"appSecret", TPSharePlatformTypeWechat)];
}
/// 如果使用本组件提供的UI，可以实现下面代理方法
// 此方法是提供UI显示的地方
- (UIViewController *)sharedRootViewController {
    return self.window.rootViewController;
}

/// ②接口方式
[TPShareAPI TPConfigurationPlatforms:@[TPPlatformModel(@"appKey", @"appSecret", TPSharePlatformTypeQQ), TPPlatformModel(@"appKey", @"appSecret", TPSharePlatformTypeWechat)]];
```

- 其次是生成分享到第三方平台的信息，于是创建了关于分享信息的model，即`TPShareBaseModel`

```objective-c
///使用
// 1、初始化，采用链式
/*
* 参数：title、url、content、iamge，是常用参数
* TPShareModelChannel: 是指不同的方式、包含QQ、QQSpace、wechat、friend、copyLink
* contentType: 分享内容的类型；有链接、纯文本、图片
*/
// 分享链接
NS_INLINE __kindof TPShareBaseModel *TPShareLinkModel(NSString *title, NSString *url, NSString *content, id image, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].title(title).url(url).content(content).image(image).channel(@(chanel));
}
// 分享text
NS_INLINE  TPShareBaseModel *XHXShareTextModel(NSString *content, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].content(content).channel(@(chanel)).shareContentType(@(TPShareContentTypeText));
}
// 分享image
NS_INLINE  TPShareBaseModel *XHXShareImageModel(id image, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].image(image).channel(@(chanel)).shareContentType(@(TPShareContentTypeImage));
}

```

- 具体调用，使用`TPShareAction`类

```objective-c

//①使用自定义的UI，如下
// 以纯文本分享为例
TPShareAction *action = [TPShareAction actionWithShareModel:XHXShareTextModel(@"测试文本调用",TPShareModelChannelQQ)];

/// TPShareResultState参数是分享状态包含：开始、成功、失败、取消，可用于大数据埋点，或者其他回调需求
[action TPShareToThirdPlatformResult: ^(TPShareResultState state){                         
}];
//②使用自带的UI，如下
// 需要引入头文件#import "TPShareUIAPI.h"
/// 在那个类里面使用就让那个类执行协议<TPShareCustomeActionProtocol>
[TPShareUIAPI showCustomUI:@[XHXShareTextModel(@"测试文本调用",TPShareModelChannelQQ),XHXShareTextModel(@"测试文本调用",TPShareModelChannelQQ),XHXShareTextModel(@"测试文本调用",TPShareModelChannelQQ)] delegate:delegate];

/// 协议具体方法
@protocol TPShareCustomeActionProtocol <NSObject>
@optional
/// 选中的item，为埋点预留接口
- (void)TPDidSelectedShareModel:(__kindof TPShareBaseModel *)model;
/// 分享成功
- (void)TPSharedSuccess:(TPShareBaseModel *)model;
/// 分享失败
- (void)TPSharedFail:(TPShareBaseModel *)model;
- (void)TPDismiss;
@end
```
