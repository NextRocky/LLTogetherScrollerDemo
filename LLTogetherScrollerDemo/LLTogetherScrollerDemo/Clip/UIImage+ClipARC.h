//
//  UIImage+ClipARC.h
//  weiboOC
//
//  Created by 罗李 on 16/11/15.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipARC)

- (UIImage *)newImageSizeWithNewWith:(CGFloat)width;
- (UIImage *)drawLoopImage;
- (UIImage *)drawCircleImage;
- (UIImage *)circleCornerWithRadiu:(CGFloat)radius;
+ (UIImage *)lineImageWithSize:(CGSize )size andLineColor:(UIColor *)rgb;
+ (UIImage *)colorImageWithHeight:(CGSize)size andRadius:(CGFloat)radius andColor:(UIColor *)rgb;
@end
