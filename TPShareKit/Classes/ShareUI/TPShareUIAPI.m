//
//  TPShareDefine.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareUIAPI.h"
#import "TPShareManager.h"
#import "TPShareCustomeVC.h"
#import "TPShareCustomeVC+ShareSDK.h"


@implementation TPShareUIAPI
+ (void)showCustomeUI:(NSArray <__kindof TPShareBaseModel *>*)models delegate:(id <TPShareCustomeActionProtocol>)delegate {
    if (![TPShareManager shareInstance].platformDelegate) return;
    /// 模态的根视图
    UIViewController *viewContoller = [[TPShareManager shareInstance].platformDelegate sharedRootViewController];
    /// 分享控制器
    TPShareCustomeVC *shareVC = [[TPShareCustomeVC alloc] init];
    [shareVC tpFetchVerificationDataSource:models];
    shareVC.delegate = delegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewContoller presentViewController:shareVC animated:NO completion:^{
            [shareVC show];
        }];
    });
}
@end
