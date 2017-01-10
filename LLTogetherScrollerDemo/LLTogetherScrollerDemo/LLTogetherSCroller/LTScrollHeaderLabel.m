//
//  LTScrollHeaderLabel.m
//  QuYou_iOS
//
//  Created by 罗李 on 16/11/28.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import "LTScrollHeaderLabel.h"
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@implementation LTScrollHeaderLabel

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text
{
    if (self = [super initWithFrame:frame]) {
        self.text = text;
        self.textColor = RGB(105, 105, 105);
        self.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}
- (void)setScale:(float)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:(105 + 26 * scale) / 255.0 green:(105 + 65 * scale) / 255.0 blue:(105 + 66  * scale) / 255.0 alpha:1];

    self.transform = CGAffineTransformMakeScale(0.8 + (1 - 0.9) *scale , 0.8 + (1 - 0.9) *scale);
}
@end
