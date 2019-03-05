//
//  TPShareDefine.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import <Foundation/Foundation.h>
#import "TPShareBaseModel.h"
#import "TPShareCustomeActionProtocol.h"

UIImage *TPShareImage(NSString *imageName);

@interface TPShareDefine : NSObject
+ (void)showCustomeUI:(NSArray <__kindof TPShareBaseModel *>*)models delegate:(id <TPShareCustomeActionProtocol>)delegate;
@end

