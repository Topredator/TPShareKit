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

#import "TPUIKitDefine.h"
#import "TPSimButton.h"
#import "TPToast.h"
#import "TPToastImageView.h"

FOUNDATION_EXPORT double TPUIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char TPUIKitVersionString[];
