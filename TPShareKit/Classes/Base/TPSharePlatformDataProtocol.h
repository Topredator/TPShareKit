//
//  TPSharePlatformDataProtocol.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>




@protocol TPSharePlatformDataProtocol <NSObject>
/// 获取需要分享的信息
- (id)TPFetchShareInfoFromModel;

@end

