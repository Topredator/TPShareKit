//
//  TPShareBaseModel.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareBaseModel.h"

@implementation TPShareBaseModel
#pragma mark ==================  NSCopying   ==================
- (id)copyWithZone:(NSZone *)zone {
    TPShareBaseModel *model = [[[self class] allocWithZone:zone] init];
    model.shareTitle = _shareTitle;
    model.shareUrl = _shareUrl;
    model.shareImage = _shareImage;
    model.shareContent = _shareContent;
    model.contentType = self.contentType;
    return model;
}
- (TPShareBaseChain)title {
    return ^ (id title) {
        if ([title isKindOfClass:NSString.class]) {
            self.shareTitle = (NSString *)title;
        }
        return self;
    };
}
- (TPShareBaseChain)url {
    return ^ (id url) {
        if ([url isKindOfClass:NSString.class]) {
            self.shareUrl = (NSString *)url;
        }
        return self;
    };
}
- (TPShareBaseChain)content {
    return ^ (id content) {
        if ([content isKindOfClass:NSString.class]) {
            self.shareContent = (NSString *)content;
        }
        return self;
    };
}
- (TPShareBaseChain)image {
    return ^ (id image) {
        if (image && image != [NSNull null]) {
            self.shareImage = image;
        }
        return self;
    };
}
- (TPShareBaseChain)shareContentType {
    return ^ (id shareContentType) {
        if ([shareContentType respondsToSelector:@selector(integerValue)]) {
            self.contentType = [shareContentType integerValue];
        }
        return self;
    };
}
@end
