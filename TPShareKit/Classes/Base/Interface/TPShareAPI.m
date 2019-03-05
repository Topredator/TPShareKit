//
//  TPShareAPI.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareAPI.h"
#import "TPShareManager.h"
#import "TPShareDefine.h"

@implementation TPShareAPI
+ (void)TPConfigurationPlatforms:(NSArray <TPSharePlatformModel *> *)platforms {
    [TPShareManager.shareInstance setPlatforms:platforms];
}
+ (void)TPSharePlatformDelegate:(id <TPSharePlatformProtocol>)delegate {
    [TPShareManager.shareInstance setPlatformDelegate:delegate];
}
+ (void)TPShowCustomeUI:(NSArray <__kindof TPShareBaseModel *>*)models delegate:(id <TPShareCustomeActionProtocol>)delegate {
    [TPShareDefine showCustomeUI:models delegate:delegate];
}
@end
