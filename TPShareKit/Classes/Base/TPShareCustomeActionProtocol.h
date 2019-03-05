//
//  TPShareCustomeActionProtocol.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>

#import "TPShareBaseModel.h"
@protocol TPShareCustomeActionProtocol <NSObject>
@optional
/// 选中的item，为埋点预留接口
- (void)TPDidSelectedShareModel:(__kindof TPShareBaseModel *)model;
/// 分享成功
- (void)TPSharedSuccess:(TPShareBaseModel *)model;
/// 分享失败
- (void)TPSharedFail:(TPShareBaseModel *)model;
- (void)TPDismiss;
@end


