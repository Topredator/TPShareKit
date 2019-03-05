//
//  TPShareManager.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareManager.h"
#import "TPShareManager+Platforms.h"


static TPShareManager *shareManager = nil;
@implementation TPShareManager
@synthesize platforms = _platforms;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[TPShareManager alloc] init];
    });
    return shareManager;
}

#pragma mark ==================  lazy method  ==================
- (void)setPlatforms:(NSArray<TPSharePlatformModel *> *)platforms {
    _platforms = platforms;
    [self configShareSDK];
}
- (void)setPlatformDelegate:(id<TPSharePlatformProtocol>)platformDelegate {
    _platformDelegate = platformDelegate;
    [self configShareSDK];
}
- (NSArray<TPSharePlatformModel *> *)platforms {
    if (!_platforms) {
        if (_platformDelegate && [_platformDelegate respondsToSelector:@selector(TPFetchPlatforms)]) {
            _platforms = [_platformDelegate TPFetchPlatforms];
        } else {
            @throw [NSException exceptionWithName:@"平台信息不能为空，需要调用+TPConfigurationPlatforms 或者 +TPSharePlatformDelegate:" reason:@"平台信息为调用各个平台分享使用" userInfo:nil];
        }
    }
    return _platforms;
}
@end
