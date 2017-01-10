//
//  LTVerticalCollectionViewCell.m
//  QuYou_iOS
//
//  Created by 罗李 on 16/12/5.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import "LTVerticalCollectionViewCell.h"
#import "UIImage+ClipARC.h"
#import "UIView+Frame.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define MARGIN 5
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface LTVerticalCollectionViewCell ()
@end
@implementation LTVerticalCollectionViewCell






- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{


}
- (void)layoutSubviews
{
    [super layoutSubviews];

}

@end
