//
//  TPSimButton.m
//  Pods-TPUIKit_Example
//
//  Created by Topredator on 2019/2/21.
//

#import "TPSimButton.h"

/// 默认距两边的距离
static CGFloat kBtnGap = 5;

@implementation TPSimButton

- (void)setExtInteractEdge:(NSInteger)extInteractEdge {
    _extInteractEdge = extInteractEdge;
    if (UIEdgeInsetsEqualToEdgeInsets(_extInteractInsets, UIEdgeInsetsZero)) {
        self.extInteractInsets = UIEdgeInsetsMake(extInteractEdge, extInteractEdge, extInteractEdge, extInteractEdge);
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(CGRectMake(self.bounds.origin.x - self.extInteractInsets.left, self.bounds.origin.y - self.extInteractInsets.top, self.bounds.size.width + self.extInteractInsets.left + self.extInteractInsets.right, self.bounds.size.height + self.extInteractInsets.top + self.extInteractInsets.bottom), point);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (_iconPosition != TPSimButtonIconPositionDefault) {
        [self.titleLabel sizeToFit];
        
        // icon在文案 左或者右
        if (_iconPosition == TPSimButtonIconPositionLeft || _iconPosition == TPSimButtonIconPositionRight) {
            // width
            CGRect titleLabelFrame = self.titleLabel.frame;
            titleLabelFrame.size.width = MIN(self.frame.size.width - _iconTextMargin - kBtnGap - self.imageView.frame.size.width, self.titleLabel.frame.size.width);
            self.titleLabel.frame = titleLabelFrame;
        } else {
            // width
            CGRect titleLabelFrame = self.titleLabel.frame;
            titleLabelFrame.size.width = MIN(self.frame.size.width - kBtnGap, self.titleLabel.frame.size.width);
            self.titleLabel.frame = titleLabelFrame;
        }
        
        if (_iconPosition == TPSimButtonIconPositionLeft) {
            
            CGFloat width = self.imageView.frame.size.width + self.titleLabel.frame.size.width + _iconTextMargin;
            // right
            CGFloat right = self.frame.size.width / 2 + width / 2;
            CGRect titleLabelFrame = self.titleLabel.frame;
            titleLabelFrame.origin.x = right - titleLabelFrame.size.width;
            self.titleLabel.frame = titleLabelFrame;
            // left
            CGFloat left = self.frame.size.width / 2 - width / 2;
            CGRect imageViewFrame = self.imageView.frame;
            imageViewFrame.origin.x = left;
            self.imageView.frame = imageViewFrame;
            
        } else if (_iconPosition == TPSimButtonIconPositionRight) {
            CGFloat width = self.imageView.frame.size.width + self.titleLabel.frame.size.width + _iconTextMargin;
            // right
            CGRect frame = self.frame;
            CGFloat right = frame.size.width / 2 + width / 2;
            CGRect imageViewFrame = self.imageView.frame;
            imageViewFrame.origin.x = right - imageViewFrame.size.width;
            self.imageView.frame = imageViewFrame;
            // left
            CGFloat left = frame.size.width / 2 - width / 2;
            CGRect titleLabelFrame = self.titleLabel.frame;
            titleLabelFrame.origin.x = left;
            self.titleLabel.frame = titleLabelFrame;
            
        } else if (_iconPosition == TPSimButtonIconPositionCenter) {
            // centerX
            CGRect frame = self.frame;
            CGFloat centerX = frame.size.width / 2;
            CGPoint imageViewCenter = self.imageView.center;
            imageViewCenter = CGPointMake(centerX, imageViewCenter.y);
            self.imageView.center = imageViewCenter;
            // centerX
            CGPoint titleLabelCenter = self.titleLabel.center;
            titleLabelCenter = CGPointMake(centerX, titleLabelCenter.y);
            self.titleLabel.center = titleLabelCenter;
            
        } else if (_iconPosition == TPSimButtonIconPositionTop) {
            CGRect titleLabelFrame = self.titleLabel.frame;
            CGRect imageViewFrame = self.imageView.frame;
            CGFloat height = imageViewFrame.size.height + titleLabelFrame.size.height + _iconTextMargin;
            // top
            CGRect frame = self.frame;
            CGFloat top = frame.size.height / 2 - height / 2;
            imageViewFrame.origin.y = top;
            self.imageView.frame = imageViewFrame;
            // bottom
            CGFloat bottom = frame.size.height / 2 + height / 2;
            titleLabelFrame.origin.y = bottom - titleLabelFrame.size.height;
            self.titleLabel.frame = titleLabelFrame;
            // centerX
            CGFloat centerX = frame.size.width / 2;
            CGPoint imageViewCenter = self.imageView.center;
            imageViewCenter = CGPointMake(centerX, imageViewCenter.y);
            self.imageView.center = imageViewCenter;
            
            CGPoint titleLabelCenter = self.titleLabel.center;
            titleLabelCenter = CGPointMake(centerX, titleLabelCenter.y);
            self.titleLabel.center = titleLabelCenter;
            
        } else if (_iconPosition == TPSimButtonIconPositionBottom) {
            CGRect titleLabelFrame = self.titleLabel.frame;
            CGRect imageViewFrame = self.imageView.frame;
            CGFloat height = imageViewFrame.size.height + titleLabelFrame.size.height + _iconTextMargin;
            // bottom
            CGRect frame = self.frame;
            CGFloat bottom = frame.size.height / 2 + height / 2;
            imageViewFrame.origin.y = bottom - imageViewFrame.size.height;
            self.imageView.frame = imageViewFrame;
            //  top
            CGFloat top = frame.size.height / 2 - height / 2;
            titleLabelFrame.origin.y = top;
            self.titleLabel.frame = frame;
            //  centerX
            CGFloat centerX = frame.size.width / 2;
            CGPoint imageViewCenter = self.imageView.center;
            imageViewCenter = CGPointMake(centerX, imageViewCenter.y);
            self.imageView.center = imageViewCenter;
            
            CGPoint titleLabelCenter = self.titleLabel.center;
            titleLabelCenter = CGPointMake(centerX, titleLabelCenter.y);
            self.titleLabel.center = titleLabelCenter;
        }
    }
}
- (void)sizeToFit {
    if (_iconPosition != TPSimButtonIconPositionDefault) {
        [self.titleLabel sizeToFit];
        
        UIImage *image = self.currentImage;
        CGFloat width = 0, height = 0;
        
        CGFloat titleWidth = self.titleLabel.frame.size.width, titleHeight = self.titleLabel.frame.size.height;
        
        if (_iconPosition == TPSimButtonIconPositionLeft || _iconPosition == TPSimButtonIconPositionRight){
            width = titleWidth + image.size.width + _iconTextMargin + kBtnGap;
            height = MAX(titleHeight, image.size.height);
        } else if (_iconPosition == TPSimButtonIconPositionTop || _iconPosition == TPSimButtonIconPositionBottom) {
            height = titleHeight + image.size.height + _iconTextMargin;
            width = MAX(titleWidth, image.size.width) + kBtnGap;
        } else if (_iconPosition == TPSimButtonIconPositionCenter) {
            width = MAX(titleWidth, image.size.width) + kBtnGap;
            height = MAX(titleHeight, image.size.height) + kBtnGap;
        }
        // size
        CGRect frame = self.frame;
        frame.size = CGSizeMake(ceil(width), ceil(height));
        self.frame = frame;
    } else {
        [super sizeToFit];
    }
}
- (void)setIconTextMargin:(CGFloat)iconTextMargin {
    if (_iconTextMargin != iconTextMargin) {
        _iconTextMargin = iconTextMargin;
        if (_iconPosition == TPSimButtonIconPositionLeft || _iconPosition == TPSimButtonIconPositionRight){
            [self setContentEdgeInsets:UIEdgeInsetsMake(0, _iconTextMargin/2, 0, _iconTextMargin/2)];
        }
        else if (_iconPosition == TPSimButtonIconPositionTop || _iconPosition == TPSimButtonIconPositionBottom){
            [self setContentEdgeInsets:UIEdgeInsetsMake(_iconTextMargin/2, 0, _iconTextMargin/2, 0)];
        }
    }
    [self invalidateIntrinsicContentSize];
}
- (CGSize)intrinsicContentSize {
    CGSize labelSize = self.titleLabel.intrinsicContentSize;
    CGSize imageSize = self.imageView.intrinsicContentSize;
    // iOS9以下
    if (!([[UIDevice currentDevice].systemVersion compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)) {
        imageSize = self.currentImage.size;
    }
    CGFloat width = 0, height = 0;
    if (_iconPosition == TPSimButtonIconPositionLeft || _iconPosition == TPSimButtonIconPositionRight){
        width = labelSize.width + imageSize.width + _iconTextMargin + kBtnGap;
        height = MAX(labelSize.height, imageSize.height);
    } else if (_iconPosition == TPSimButtonIconPositionTop || _iconPosition == TPSimButtonIconPositionBottom) {
        height = labelSize.height + imageSize.height + _iconTextMargin;
        width = MAX(labelSize.width, imageSize.width) + kBtnGap;
    } else if (_iconPosition == TPSimButtonIconPositionCenter) {
        width = MAX(labelSize.width, imageSize.width) + kBtnGap;
        height = MAX(labelSize.height, imageSize.height) + kBtnGap;
    }
    return CGSizeMake(ceil(width), ceil(height));
}

@end
