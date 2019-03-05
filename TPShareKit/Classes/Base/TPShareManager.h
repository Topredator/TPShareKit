//
//  TPShareManager.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPSharePlatformProtocol.h"
#import "TPSharePlatformModel.h"
#import "TPShareBaseModel.h"
@interface TPShareManager : NSObject
@property (nonatomic, weak) id <TPSharePlatformProtocol> platformDelegate;
@property (nonatomic, copy) NSArray <TPSharePlatformModel *>*platforms;

+ (instancetype)shareInstance;
@end


