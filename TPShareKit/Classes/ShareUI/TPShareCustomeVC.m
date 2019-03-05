//
//  TPShareCustomeVC.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareCustomeVC.h"
#import "TPShareCustomView.h"
#import <Masonry/Masonry.h>
#import "TPShareCustomeVC+ShareSDK.h"

#define TP_iSIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

static CGFloat kShareCustomeViewHeight = 222;
static CGFloat kShareCustomeViewHeight_X = 246;

@interface TPShareCustomeVC () {
    CGFloat collectionHeight;
    NSArray <TPShareBaseModel *> *_dataSourceList;
}
@property (nonatomic, strong) TPShareCustomView *showView;
/// 背景试图
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) MASConstraint *bottomConstraint;
@end

@implementation TPShareCustomeVC
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modelList = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    // 添加背景试图
    [self.view addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.view addSubview:self.showView];
    __weak typeof(self) weakSelf = self;
    // 选中item
    self.showView.selectedAction = ^(NSInteger index) {
        TPShareBaseModel *shareModel = weakSelf.modelList[index];
        /// 开始分享
        [weakSelf tpShareToPlatformWithModel:shareModel];
        if ([weakSelf.delegate respondsToSelector:@selector(TPDidSelectedShareModel:)]) {
            [weakSelf.delegate TPDidSelectedShareModel:shareModel];
        }
    };
    // 点击取消按钮
    self.showView.dismissAction = ^{
        [weakSelf dismiss];
    };
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(TP_iSIPhoneX ? kShareCustomeViewHeight_X : kShareCustomeViewHeight);
        self.bottomConstraint = make.bottom.mas_equalTo(TP_iSIPhoneX ? kShareCustomeViewHeight_X : kShareCustomeViewHeight);
    }];
}
- (void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomConstraint.mas_equalTo(0);
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
        [self.showView show:self.modelList];
    }];
}
#pragma mark ==================  Private methods  ==================
- (void)dismiss {
    if (!self.showView.endAnimation) {
        return;
    }
    self.view.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    [self.showView destroy:^{
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.bottomConstraint.mas_equalTo(TP_iSIPhoneX ? kShareCustomeViewHeight_X : kShareCustomeViewHeight);
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [weakSelf.showView removeFromSuperview];
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            if ([weakSelf.delegate respondsToSelector:@selector(TPDismiss)]) {
                [weakSelf.delegate TPDismiss];
            }
        }];
    }];
}
#pragma mark ==================  lazy method  ==================
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
- (TPShareCustomView *)showView {
    if (!_showView) {
        _showView = [[TPShareCustomView alloc] initWithFrame:CGRectZero];
    }
    return _showView;
}
@end
