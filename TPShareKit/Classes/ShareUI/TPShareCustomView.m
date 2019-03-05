//
//  TPShareCustomView.m
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareCustomView.h"
#import "TPShareBaseModel.h"
#import "TPShareBaseModel+ConfigUI.h"
#import <TPUIKit/TPSimButton.h>
#import <pop/POP.h>
#import <Masonry/Masonry.h>
#import "TPShareDefine.h"

@interface TPShareCustomView ()
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *bgScroll;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleBtn;
@end


@implementation TPShareCustomView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}
- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(22);
    }];
    [self addSubview:self.bgScroll];
    [_bgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleView.mas_bottom).offset(0);
        make.height.mas_equalTo(135);
    }];
    [self addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.bgScroll.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self addSubview:self.cancleBtn];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
}
/// 展示
- (void)show:(NSArray <TPShareBaseModel *>*)items {
    if (!items.count) return;
    _itemsArray = items;
    /// 清理所有子视图
    [self.bgScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 5, height = 135;
    for (NSInteger i = 0; i < items.count; i++) {
        TPShareBaseModel *share = items[i];
        [self configTitleAndImageWithShareModel:share];
        TPSimButton *btn = [[TPSimButton alloc] init];
        btn.iconTextMargin = 10;
        btn.iconPosition = TPSimButtonIconPositionTop;
        [btn setTitle:share.titleName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
        [btn setImage:TPShareImage(share.imageName) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.frame = CGRectMake(width * i, 200, width, height);
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [self.bgScroll addSubview:btn];
        [self.bgScroll setContentSize:CGSizeMake(CGRectGetMaxX(btn.frame), height)];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.springSpeed = 1;
        anim.springBounciness = 1;
        anim.beginTime = CACurrentMediaTime() + 0.05 * i;
        anim.toValue = @(self.bgScroll.center.y - 37);
        [btn pop_addAnimation:anim forKey:@"kPOPLayerPositionY"];
        if (i == items.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                self->_endAnimation = YES;
            }];
        }
    }
}
/// 销毁
- (void)destroy:(void (^)(void))block {
    NSInteger j = 0;
    for (NSInteger i = self.bgScroll.subviews.count - 1; i >= 0; i--) {
        UIView *currentView = self.bgScroll.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.beginTime = CACurrentMediaTime() + 0.05 * j;
        anim.toValue = @(CGRectGetMaxY(self.bgScroll.frame) + 20);
        anim.duration = 0.25;
        [currentView pop_addAnimation:anim forKey:nil];
        if (i == 0) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                if (block) {
                    block();
                }
            }];
        }
        j ++;
    }
}
#pragma mark ==================  private method  ==================
- (void)configTitleAndImageWithShareModel:(TPShareBaseModel *)model {
    if (model.modelChannel == TPShareModelChannelQQ) {
        [model configTitleName:@"QQ好友" imageName:@"TPShare_QQ"];
    } else if (model.modelChannel == TPShareModelChannelQQSpace) {
        [model configTitleName:@"QQ空间" imageName:@"TPShare_QQSpace"];
    } else if (model.modelChannel == TPShareModelChannelWechat) {
        [model configTitleName:@"微信好友" imageName:@"TPShare_Wechat"];
    } else if (model.modelChannel == TPShareModelChannelFriends) {
        [model configTitleName:@"朋友圈" imageName:@"TPShare_Friends"];
    } else if (model.modelChannel == TPShareModelChannelCopyLink) {
        [model configTitleName:@"复制链接" imageName:@"TPShare_CopyLink"];
    }
}
- (void)selectedBtn:(id)sender {
    if (!_endAnimation) {
        return;
    }
    if (self.selectedAction) {
        self.selectedAction(((TPSimButton *)sender).tag);
    }
}
- (void)dismiss {
    if (!_endAnimation) {
        return;
    }
    if (self.dismissAction) {
        self.dismissAction();
    }
}
#pragma mark ==================  lazy method  ==================
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *titleLbale = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLbale.text = @"分享到";
        titleLbale.font = [UIFont systemFontOfSize:16];
        titleLbale.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        [_titleView addSubview:titleLbale];
        __weak typeof(self) weakSelf = self;
        [titleLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            make.centerX.equalTo(strongSelf->_titleView.mas_centerX);
            make.centerY.equalTo(strongSelf->_titleView.mas_centerY);
        }];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        line1.backgroundColor = [UIColor colorWithRed:216 / 255.0 green:216 / 255.0 blue:216 / 255.0 alpha:1];
        [_titleView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            make.size.mas_equalTo(CGSizeMake(24, 1));
            make.centerY.equalTo(strongSelf->_titleView.mas_centerY);
            make.right.equalTo(titleLbale.mas_left).offset(-15);
        }];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        line2.backgroundColor = [UIColor colorWithRed:216 / 255.0 green:216 / 255.0 blue:216 / 255.0 alpha:1];
        [_titleView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            make.size.mas_equalTo(CGSizeMake(24, 1));
            make.centerY.equalTo(strongSelf->_titleView.mas_centerY);
            make.left.equalTo(titleLbale.mas_right).offset(15);
        }];
    }
    return _titleView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
    }
    return _lineView;
}
- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancleBtn setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (UIScrollView *)bgScroll {
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _bgScroll.showsVerticalScrollIndicator = NO;
        _bgScroll.showsHorizontalScrollIndicator = NO;
    }
    return _bgScroll;
}
@end
