//
//  TPShareCustomeVC.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <UIKit/UIKit.h>

#import "TPShareCustomeActionProtocol.h"

@interface TPShareCustomeVC : UIViewController
/// 数据源
@property (nonatomic, strong) NSMutableArray <TPShareBaseModel *>*modelList;
@property (nonatomic, weak) id <TPShareCustomeActionProtocol> delegate;
//- (instancetype)initWithDataSource:(NSArray <TPShareBaseModel *> *)dataSource;
//- (instancetype)init NS_UNAVAILABLE;
/// 展示
- (void)show;
@end


