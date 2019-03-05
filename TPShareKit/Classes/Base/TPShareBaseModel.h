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
/// 分享的渠道，如QQ/QQSpace/Wechat/Friends/CopyLink 等
@property (nonatomic, assign) TPShareModelChannel modelChannel;
- (TPShareBaseChain)title;
- (TPShareBaseChain)url;
- (TPShareBaseChain)content;
- (TPShareBaseChain)image;
- (TPShareBaseChain)channel;
- (TPShareBaseChain)shareContentType;
@end

// 分享链接
NS_INLINE __kindof TPShareBaseModel *TPShareLinkModel(NSString *title, NSString *url, NSString *content, id image, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].title(title).url(url).content(content).image(image).channel(@(chanel));
}
// 分享text
NS_INLINE  TPShareBaseModel *XHXShareTextModel(NSString *content, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].content(content).channel(@(chanel)).shareContentType(@(TPShareContentTypeText));
}
// 分享image
NS_INLINE  TPShareBaseModel *XHXShareImageModel(id image, TPShareModelChannel chanel) {
    return [TPShareBaseModel new].image(image).channel(@(chanel)).shareContentType(@(TPShareContentTypeImage));
}
