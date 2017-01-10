//
//  LTLiveCollectionViewCell.m
//  QuYou_iOS
//
//  Created by 罗李 on 16/11/26.
//  Copyright © 2016年 LongTengTechnologyCompany. All rights reserved.
//

#import "LTLiveCollectionViewCell.h"

#import "LTVerticalCollectionViewCell.h"
#import "UIImage+ClipARC.h"
#define SCREENSCALe 136.0/188.0
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface LTLiveCollectionViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *verticalCollectionView;
@end


@implementation LTLiveCollectionViewCell



- (UICollectionView *)verticalCollectionView
{
    if (!_verticalCollectionView) {
        UICollectionViewFlowLayout *verticalLayout = [UICollectionViewFlowLayout new];
        verticalLayout.minimumLineSpacing = 5;
        verticalLayout.minimumInteritemSpacing = 0;
        verticalLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        verticalLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 10, SCREEN_WIDTH / 2 * SCREENSCALe);
        CGRect horizontalFrame = self.contentView.bounds;
        _verticalCollectionView = [[UICollectionView alloc]initWithFrame:horizontalFrame collectionViewLayout:verticalLayout];
    }
    return _verticalCollectionView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

static NSString *identifier = @"verticalCell";
- (void)setupUI
{
    self.verticalCollectionView.delegate = self;
    self.verticalCollectionView.dataSource = self;
    self.verticalCollectionView.showsHorizontalScrollIndicator = NO;
    self.verticalCollectionView.backgroundColor = RGB(247, 248, 250);
    self.verticalCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    //  添加collectionView
    [self.contentView addSubview:self.verticalCollectionView];
    //  注册
    [self.verticalCollectionView registerClass:[LTVerticalCollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTVerticalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
