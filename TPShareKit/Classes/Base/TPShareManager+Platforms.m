//
//  TPShareManager+Platforms.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareManager+Platforms.h"
#import <ShareSDK/ShareSDK.h>


@implementation TPShareManager (Platforms)
- (void)configShareSDK {
    NSArray *platforms = TPShareManager.shareInstance.platforms.copy;
    if (!platforms) return;
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        for (TPSharePlatformModel *platform in platforms) {
            if (platform.platformType == TPSharePlatformTypeQQ) {
                [platformsRegister setupQQWithAppId:platform.platformID appkey:platform.platformSecret];
            } else if (platform.platformType == TPSharePlatformTypeWechat) {
                [platformsRegister setupWeChatWithAppId:platform.platformID appSecret:platform.platformSecret];
            }
        }
    }];
}
@end
