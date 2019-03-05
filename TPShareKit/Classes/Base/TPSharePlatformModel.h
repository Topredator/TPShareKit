//
//  TPSharePlatformModel.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPShareEnumeration.h"

@class TPSharePlatformModel;
typedef TPSharePlatformModel *(^TPSharePlatformChain)(id);

@interface TPSharePlatformModel : NSObject <NSCopying>
/// 第三方平台注册时，生成的appId或appKey
@property (nonatomic, copy) NSString *platformID;
/// 第三方平台注册时，生成的appSecret
@property (nonatomic, copy) NSString *platformSecret;
@property (nonatomic, assign) TPSharePlatformType platformType;
- (TPSharePlatformChain)appId;
- (TPSharePlatformChain)appSecret;
- (TPSharePlatformChain)type;
@end

NS_INLINE TPSharePlatformModel *TPPlatformModel(NSString *platformId, NSString *platformSecret, TPSharePlatformType platformType) {
    return [TPSharePlatformModel new].appId(platformId).appSecret(platformSecret).type(@(platformType));
}
