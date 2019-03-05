//
//  TPShareDefine.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPShareBaseModel.h"
#import "TPShareCustomeActionProtocol.h"



@interface TPShareUIAPI : NSObject
+ (void)showCustomeUI:(NSArray <__kindof TPShareBaseModel *>*)models delegate:(id <TPShareCustomeActionProtocol>)delegate;
@end

