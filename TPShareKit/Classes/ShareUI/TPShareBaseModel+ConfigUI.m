//
//  TPShareBaseModel+ConfigUI.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareBaseModel+ConfigUI.h"
#import <objc/runtime.h>


static char kTPModelTitleKey;
static char kTPModelImageKey;
@implementation TPShareBaseModel (ConfigUI)
- (void)setTitleName:(NSString *)titleName {
    objc_setAssociatedObject(self, &kTPModelTitleKey, titleName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)titleName {
    return objc_getAssociatedObject(self, &kTPModelTitleKey);
}
- (void)setImageName:(NSString *)imageName {
    objc_setAssociatedObject(self, &kTPModelImageKey, imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)imageName {
    return objc_getAssociatedObject(self, &kTPModelImageKey);
}

- (void)configTitleName:(NSString *)titleName imageName:(NSString *)imageName {
    self.titleName = titleName;
    self.imageName = imageName;
}
@end
