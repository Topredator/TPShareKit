#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TPShareKit.h"
#import "TPShareAPI.h"
#import "TPShareAction.h"
#import "TPShareBaseModel.h"
#import "TPShareCustomeActionProtocol.h"
#import "TPShareEnumeration.h"
#import "TPShareManager+Platforms.h"
#import "TPShareManager.h"
#import "TPSharePlatformDataProtocol.h"
#import "TPSharePlatformModel.h"
#import "TPSharePlatformProtocol.h"
#import "TPShareBaseModel+ConfigUI.h"
#import "TPShareCustomeVC+ShareSDK.h"
#import "TPShareCustomeVC.h"
#import "TPShareCustomView.h"
#import "TPShareDefine.h"

FOUNDATION_EXPORT double TPShareKitVersionNumber;
FOUNDATION_EXPORT const unsigned char TPShareKitVersionString[];

