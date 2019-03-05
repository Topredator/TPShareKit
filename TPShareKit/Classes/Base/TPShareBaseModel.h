//
//  TPShareBaseModel.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPShareEnumeration.h"

@class TPShareBaseModel;

typedef TPShareBaseModel *(^TPShareBaseChain)(id);

@interface TPShareBaseModel : NSObject <NSCopying>
/// 标题
@property (nonatomic, copy) NSString *shareTitle;
/// 链接地址
@property (nonatomic, copy) NSString *shareUrl;
/// 内容
@property (nonatomic, copy) NSString *shareContent;
/// 图标
@property (nonatomic, strong) id shareImage;
/// 分享类型
@property (nonatomic, assign) TPShareContentType contentType;

- (TPShareBaseChain)title;
- (TPShareBaseChain)url;
- (TPShareBaseChain)content;
- (TPShareBaseChain)image;
- (TPShareBaseChain)shareContentType;
@end


