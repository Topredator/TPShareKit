//
//  TPSharePlatformProtocol.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPSharePlatformModel.h"


@protocol TPSharePlatformProtocol <NSObject>
/// 获取平台信息，用于注册
- (NSArray <TPSharePlatformModel *> *)TPFetchPlatforms;
@optional
/// 自定义视图分享的根视图
- (UIViewController *)sharedRootViewController;
@end


