//
//  TPShareCustomeVC+ShareSDK.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareCustomeVC+ShareSDK.h"
#import "TPShareBaseModel+ConfigUI.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDK/ShareSDK.h>
#import <TPUIKit/TPToast.h>

@implementation TPShareCustomeVC (ShareSDK)
- (void)tpShareToPlatformWithModel:(__kindof TPShareBaseModel *)model {
    if (!model) return;
    NSMutableDictionary *dict = [self fetchShareInfoFromModel:model];
    /// 单独处理 链接拷贝
    if (model.modelChannel == TPShareModelChannelCopyLink) {
        NSURL *url = dict[@"url"];
        if (url && [url isKindOfClass:[NSURL class]]) {
            [UIPasteboard generalPasteboard].string = [url absoluteString];
            [TPToast showInfo:@"链接已复制到粘贴板" inView:self.view];
        } else {
            [TPToast showInfo:@"链接复制失败" inView:self.view];
        }
        return;
    }
    
    TPShareModelChannel channel = model.modelChannel;
    SSDKPlatformType platformType = SSDKPlatformTypeUnknown;
    if (channel == TPShareModelChannelQQ) {
        platformType = SSDKPlatformSubTypeQQFriend;
    } else if (channel == TPShareModelChannelQQSpace) {
        platformType = SSDKPlatformSubTypeQZone;
    } else if (channel == TPShareModelChannelWechat) {
        platformType = SSDKPlatformTypeWechat;
    } else if (channel == TPShareModelChannelFriends) {
        platformType = SSDKPlatformSubTypeWechatTimeline;
    }
    __weak typeof(self) weakSelf = self;
    [ShareSDK share:platformType parameters:dict onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (state == SSDKResponseStateSuccess) { // 分享成功回调
            if ([weakSelf.delegate respondsToSelector:@selector(TPSharedSuccess:)]) {
                [weakSelf.delegate TPSharedSuccess:model];
            }
        } else if (state == SSDKResponseStateFail) { // 分享失败回调
            if ([weakSelf.delegate respondsToSelector:@selector(TPSharedFail:)]) {
                [weakSelf.delegate TPSharedFail:model];
            }
        }
    }];
}

- (NSMutableDictionary *)fetchShareInfoFromModel:(TPShareBaseModel *)model {
    NSMutableDictionary *mdic = @{}.mutableCopy;
    TPShareContentType type = model.contentType;
    /// 默认的分享类型为 链接
    SSDKContentType contentType = SSDKContentTypeAuto;
    if (type == TPShareContentTypeImage) {
        contentType = SSDKContentTypeImage;
    } else if (type == TPShareContentTypeText) {
        contentType = SSDKContentTypeText;
    }
    [mdic SSDKSetupShareParamsByText:model.shareContent ?: nil
                              images:model.shareImage ?: nil
                                 url:model.shareUrl ? [NSURL URLWithString:model.shareUrl] : nil
                               title:model.shareTitle ?: nil
                                type:contentType];
    return mdic;
}

/**
 获取验证通过的数据源
 如果本地没有安装第三方客户端，直接过滤
 */
- (void)tpFetchVerificationDataSource:(NSArray <TPShareBaseModel *>*)models {
    if (!models || !models.count)  return;
    
    [self.modelList removeAllObjects];
    
    for (TPShareBaseModel *model in models) {
        if (model.modelChannel == TPShareModelChannelQQ && [ShareSDK isClientInstalled:SSDKPlatformSubTypeQQFriend]) {
            [self.modelList addObject:model.copy];
        } else if (model.modelChannel == TPShareModelChannelQQSpace && [ShareSDK isClientInstalled:SSDKPlatformSubTypeQZone]) {
            [self.modelList addObject:model.copy];
        } else if (model.modelChannel == TPShareModelChannelWechat &&  [ShareSDK isClientInstalled:SSDKPlatformSubTypeWechatSession]) {
            [self.modelList addObject:model.copy];
        } else if (model.modelChannel == TPShareModelChannelFriends && [ShareSDK isClientInstalled:SSDKPlatformSubTypeWechatTimeline]) {
            [self.modelList addObject:model.copy];
        } else if (model.modelChannel == TPShareModelChannelCopyLink) {
            [self.modelList addObject:model.copy];
        }
    }
}
@end
