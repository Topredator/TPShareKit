//
//  TPShareAction.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareAction.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/NSMutableDictionary+SSDKShare.h>
@implementation TPShareAction
@synthesize shareModel = _shareModel;

+ (instancetype)actionWithShareModel:(__kindof TPShareBaseModel *)shareModel {
    return [[self alloc] initWithShareModel:shareModel];
}
- (instancetype)initWithShareModel:(__kindof TPShareBaseModel *)shareModel {
    self = [super init];
    if (self) {
        _shareModel = shareModel;
    }
    return self;
}

#pragma mark ==================  TPSharePlatformDataProtocol   ==================
- (id)TPFetchShareInfoFromModel {
    NSMutableDictionary *mdic = @{}.mutableCopy;
    TPShareContentType type = self.shareModel.contentType;
    /// 默认的分享类型为 链接
    SSDKContentType contentType = SSDKContentTypeAuto;
    if (type == TPShareContentTypeImage) {
        contentType = SSDKContentTypeImage;
    } else if (type == TPShareContentTypeText) {
        contentType = SSDKContentTypeText;
    }
    [mdic SSDKSetupShareParamsByText:self.shareModel.shareContent ?: nil
                              images:self.shareModel.shareImage ?: nil
                                 url:self.shareModel.shareUrl ? [NSURL URLWithString:self.shareModel.shareUrl] : nil
                               title:self.shareModel.shareTitle ?: nil
                                type:contentType];
    return mdic;
}
- (void)TPShareToThirdPlatformResult:(void (^)(TPShareResultState state))block {
    TPShareModelChannel channel = self.shareModel.modelChannel;
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
    [ShareSDK share:platformType parameters:[self TPFetchShareInfoFromModel] onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (!block) return;
        if (state == SSDKResponseStateBegin) {
            block(TPShareResultStateBegin);
        } else if (state == SSDKResponseStateFail) {
            block(TPShareResultStateFail);
        } else if (state == SSDKResponseStateSuccess) {
            block(TPShareResultStateSuccess);
        } else if (state == SSDKResponseStateCancel) {
            block(TPShareResultStateCancle);
        }
    }];
}
@end
