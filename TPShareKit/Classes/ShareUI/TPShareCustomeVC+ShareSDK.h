//
//  TPShareCustomeVC+ShareSDK.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//


#import "TPShareCustomeVC.h"

@interface TPShareCustomeVC (ShareSDK)
/// 开始分享
- (void)tpShareToPlatformWithModel:(__kindof TPShareBaseModel *)model;
/**
 获取验证通过的数据源
 如果本地没有安装第三方客户端，直接过滤
 */
- (void)tpFetchVerificationDataSource:(NSArray <TPShareBaseModel *>*)models;
@end

