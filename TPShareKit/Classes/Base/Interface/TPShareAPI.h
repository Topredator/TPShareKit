//
//  TPShareAPI.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPSharePlatformModel.h"
#import "TPSharePlatformProtocol.h"
#import "TPShareBaseModel.h"
#import "TPShareCustomeActionProtocol.h"
@interface TPShareAPI : NSObject

+ (void)TPConfigurationPlatforms:(NSArray <TPSharePlatformModel *> *)platforms;
+ (void)TPSharePlatformDelegate:(id <TPSharePlatformProtocol>)delegate;
+ (void)TPShowCustomeUI:(NSArray <__kindof TPShareBaseModel *>*)models delegate:(id <TPShareCustomeActionProtocol>)delegate;
@end
