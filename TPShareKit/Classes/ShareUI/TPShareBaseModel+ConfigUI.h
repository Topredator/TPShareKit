//
//  TPShareBaseModel+ConfigUI.h
//  TPShareKit
//
//  Created by Topredator on 2019/3/5.
//

#import "TPShareBaseModel.h"

@interface TPShareBaseModel (ConfigUI)
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imageName;
- (void)configTitleName:(NSString *)titleName imageName:(NSString *)imageName;
@end
