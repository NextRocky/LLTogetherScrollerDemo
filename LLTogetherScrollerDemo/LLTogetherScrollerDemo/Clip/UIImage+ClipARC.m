//
//  UIImage+ClipARC.m
//  weiboOC
//
//  Created by 罗李 on 16/11/15.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import "UIImage+ClipARC.h"

@implementation UIImage (ClipARC)
#pragma mark - 压缩成正方形
- (UIImage *)newImageSizeWithNewWith:(CGFloat)width;
{
    CGSize newContext = CGSizeMake(width, width);
    UIGraphicsBeginImageContext(newContext);
    [self drawInRect:CGRectMake(0, 0, newContext.width, newContext.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)newImageSizeWithNewSize:(CGSize)size
{
    CGSize newContext = size;
    UIGraphicsBeginImageContext(newContext);
    [self drawInRect:CGRectMake(0, 0, newContext.width, newContext.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 带圆环的头像(有问题)
- (UIImage *)drawLoopImage
{
    CGFloat margin = 5;
    CGSize imageContext = CGSizeMake(self.size.width + margin * 2, self.size.height + margin *2);
    UIGraphicsBeginImageContextWithOptions(imageContext, NO, 0.0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(imageContext.width * 0.5, imageContext.height * 0.5);
    
    CGFloat radius = (MIN(imageContext.width, imageContext.height) - margin) * 0.5;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CGContextSetLineWidth(ref, margin);
    
    [[UIColor redColor] set];
    
    CGContextAddPath(ref, bezierPath.CGPath);
    
    CGContextDrawPath(ref, kCGPathStroke);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - margin / 2 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    CGContextAddPath(ref, path.CGPath);
    
    CGContextClip(ref);
    
    [self drawAtPoint:CGPointMake(margin, margin)];
    
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clipImage;
}
#pragma mark - 圆形图片
- (UIImage *)drawCircleImage
{
    CGSize contextSize = CGSizeMake(self.size.width, self.size.width);

    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGPoint centerPoint = CGPointMake(self.size.width / 2, self.size.height / 2);
    CGFloat len = self.size.width > self.size.height ? self.size.height : self.size.width;
    CGFloat radius = len / 2;

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle: M_PI * 2 clockwise:YES];
    CGContextAddPath(ref, circlePath.CGPath);
    CGContextClip(ref);
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();

    return image;
}
#pragma mark - 圆角图片
- (UIImage *)circleCornerWithRadiu:(CGFloat)radius
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:radius];
    CGContextAddPath(ref, bezierPath.CGPath);
    CGContextClip(ref);
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark- 带下划线图片
+ (UIImage *)lineImageWithSize:(CGSize )size andLineColor:(UIColor *)rgb
{

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, size.height)];
    [linePath addLineToPoint:CGPointMake(size.width, size.height)];
    [rgb set];
    
    CGContextAddPath(ref, linePath.CGPath);
    CGContextStrokePath(ref);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}
+ (UIImage *)colorImageWithHeight:(CGSize)size andRadius:(CGFloat)radius andColor:(UIColor *)rgb
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    [rgb set];
    CGContextAddPath(ref, bezierPath.CGPath);
    CGContextFillPath(ref);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}
@end
