//
//  TPShareEnumeration.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//


/**
 shareModel所分享的渠道
 */
typedef NS_ENUM(NSInteger, TPShareModelChannel) {
    TPShareModelChannelNone,
    TPShareModelChannelQQ,
    TPShareModelChannelQQSpace,
    TPShareModelChannelWechat,
    TPShareModelChannelFriends,
    TPShareModelChannelCopyLink,
    TPShareModelChannelTotal
};

/**
 分享内容的类型：链接、图片、文字
 */
typedef NS_ENUM(NSInteger, TPShareContentType) {
    TPShareContentTypeLink = 0, // 链接
    TPShareContentTypeImage, // 图片
    TPShareContentTypeText // 文字
};


/**
 分享平台类型

 - TPSharePlatformTypeQQ: QQ
 - TPSharePlatformTypeWechat: 微信
 */
typedef NS_ENUM(NSInteger, TPSharePlatformType) {
    TPSharePlatformTypeQQ = 0,
    TPSharePlatformTypeWechat
};

/**
 分享结果类型
 
 - TPShareResultTypeBegin: 开始
 - TPShareResultTypeSuccess: 成功
 - TPShareResultTypeFail: 失败
 - TPShareResultTypeCancle: 取消
 */
typedef NS_ENUM(NSInteger, TPShareResultState) {
    TPShareResultStateBegin,
    TPShareResultStateSuccess,
    TPShareResultStateFail,
    TPShareResultStateCancle
};
