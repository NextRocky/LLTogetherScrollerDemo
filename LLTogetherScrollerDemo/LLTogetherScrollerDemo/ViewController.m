//
//  ViewController.m
//  LLTogetherScrollerDemo
//
//  Created by 罗李 on 17/1/10.
//  Copyright © 2017年 罗李. All rights reserved.
//

#import "ViewController.h"
#import "LLTogetherScroller.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    LLTogetherScroller *together = [[LLTogetherScroller alloc]initWithFrame:frame];
    together.dataSource = @[
                            @"热们",
                            @"附近",
                            @"人气",
                            @"最新",
                            @"运动户外",
                            @"商业"
                            ];
    [self.view addSubview:together];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
