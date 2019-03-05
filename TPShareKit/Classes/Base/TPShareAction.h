//
//  TPShareAction.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPShareBaseModel.h"
#import "TPSharePlatformDataProtocol.h"

@interface TPShareAction : NSObject <TPSharePlatformDataProtocol>
@property (nonatomic, readwrite, strong) TPShareBaseModel *shareModel;
+ (instancetype)actionWithShareModel:(__kindof TPShareBaseModel *)shareModel;
- (instancetype)initWithShareModel:(__kindof TPShareBaseModel *)shareModel;
- (instancetype)init NS_UNAVAILABLE;
/// 开始分享
- (void)TPShareToThirdPlatformResult:(void (^)(TPShareResultState state))block;
@end


