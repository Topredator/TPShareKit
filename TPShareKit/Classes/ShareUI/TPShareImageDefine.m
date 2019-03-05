//
//  TPShareImageDefine.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareImageDefine.h"

UIImage *TPShareImage(NSString *imageName) {
    NSBundle *bundle = [NSBundle bundleForClass:[TPShareImageDefine class]];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}
@implementation TPShareImageDefine
@end
