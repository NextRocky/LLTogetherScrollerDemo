//
//  LTScrollHeaderLabel.h
//  QuYou_iOS
//
//  Created by 罗李 on 16/11/28.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTScrollHeaderLabel : UILabel

@property (nonatomic,assign) float scale;

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text;
@end
