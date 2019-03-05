//
//  TPShareCustomView.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <UIKit/UIKit.h>

@class TPShareBaseModel;
@interface TPShareCustomView : UIView
/// 是否已经结束动画, 如果动画不结束就进行别的操作会出现frame的bug
@property (nonatomic, assign, readonly) BOOL endAnimation;
@property (nonatomic, copy, readonly) NSArray <TPShareBaseModel *>*itemsArray;
/// 选中的item
@property (nonatomic, copy) void (^selectedAction)(NSInteger index);
/// 取消（UI消失）
@property (nonatomic, copy) void (^dismissAction)(void);

/// 展示
- (void)show:(NSArray <TPShareBaseModel *>*)items;
/// 销毁
- (void)destroy:(void (^)(void))block;
@end

