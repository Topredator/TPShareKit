//
//  TPSharePlatformModel.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPSharePlatformModel.h"

@implementation TPSharePlatformModel
#pragma mark ==================  NSCopying   ==================
- (id)copyWithZone:(NSZone *)zone {
    TPSharePlatformModel *model = [[[self class] allocWithZone:zone] init];
    model.platformID = self.platformID;
    model.platformSecret = self.platformSecret;
    model.platformType = self.platformType;
    return model;
}
- (TPSharePlatformChain)appId {
    return ^ (id appId) {
        if ([appId isKindOfClass:NSString.class]) {
            self.platformID = (NSString *)appId;
        }
        return self;
    };
}
- (TPSharePlatformChain)appSecret {
    return ^ (id appSecret) {
        if ([appSecret isKindOfClass:NSString.class]) {
            self.platformSecret = (NSString *)appSecret;
        }
        return self;
    };
}
- (TPSharePlatformChain)type {
    return ^ (id type) {
        if ([type respondsToSelector:@selector(integerValue)]) {
            self.platformType = [type integerValue];
        }
        return self;
    };
}
@end
