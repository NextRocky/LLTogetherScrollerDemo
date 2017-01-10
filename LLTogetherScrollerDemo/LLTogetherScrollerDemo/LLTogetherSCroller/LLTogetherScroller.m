//
//  LLTogetherScroller.m
//  LLTogetherScrollerDemo
//
//  Created by 罗李 on 17/1/10.
//  Copyright © 2017年 罗李. All rights reserved.
//

#import "LLTogetherScroller.h"
#import "LTLiveCollectionViewCell.h"
#import "LTScrollHeaderLabel.h"
#import "UIImage+ClipARC.h"
#import "UIView+Frame.h"
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define LTLog(...) NSLog(__VA_ARGS__)
#define HEADERVIEW 88
#define NAVHEIGHT 64
#define MARGIN 5
static NSString *key = @"collectionCell";
@interface LLTogetherScroller ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITabBarDelegate>
@property (nonatomic, strong) UIScrollView *scrollHeader;

//  数据源
@property (nonatomic, strong) NSArray *titleArr;
//  导航条
@property (nonatomic, strong) UIView *navLayer;
//  collectionView
@property (nonatomic, strong) UICollectionView *liveCollection;
//  自定义label 集合
@property (nonatomic, strong) NSMutableArray *labelMuArr;
//  记录当前滚动的位置
@property (nonatomic,assign) CGFloat moveOffset;
//  记录当前的 index
@property (nonatomic,assign) NSInteger currentLabelIndex;
//  字体大小
@property (nonatomic, strong) UIFont *currenFont;
@end

@implementation LLTogetherScroller
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    self.titleArr = dataSource;
    [self headerView];
}

- (NSMutableArray *)labelMuArr
{
    if (!_labelMuArr) {
        
        _labelMuArr = [NSMutableArray arrayWithCapacity:self.titleArr.count];
    }
    return _labelMuArr;
}
-(UICollectionView *)liveCollection
{
    if (!_liveCollection) {
        
        CGFloat liveCollX = 0;
        CGFloat liveCollY = CGRectGetMaxY(self.scrollHeader.frame);
        CGFloat liveCollW = SCREEN_WIDTH;
        CGFloat liveCollH = self.Height - liveCollY;
        UICollectionViewFlowLayout *liveFlowLayout = [UICollectionViewFlowLayout new];
        liveFlowLayout.minimumLineSpacing = 0;
        liveFlowLayout.minimumInteritemSpacing = 0;
        liveFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        liveFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH , liveCollH);
        
        _liveCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(liveCollX, liveCollY, liveCollW, liveCollH) collectionViewLayout:liveFlowLayout];

        [self addSubview:_liveCollection];
    }
    return _liveCollection;
}

- (UIView *)navLayer
{
    if (!_navLayer) {
        
        _navLayer = [UIView new];
        _navLayer.backgroundColor = RGB(131, 180, 171);
    }
    return _navLayer;
}

-(UIScrollView *)scrollHeader
{
    if (!_scrollHeader) {
        
        _scrollHeader = [UIScrollView new];
        _scrollHeader.bounces = NO;
        _scrollHeader.delegate = self;
        _scrollHeader.pagingEnabled = NO;
        _scrollHeader.contentSize = CGSizeMake(SCREEN_WIDTH, HEADERVIEW / 2);
        _scrollHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW / 2);
        _scrollHeader.backgroundColor = [UIColor whiteColor];
    }
    return _scrollHeader;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollHeader];

        [self setupUI];
    }
    return self;
}


- (void)setupUI
{

    self.liveCollection.bounces = NO;
    self.liveCollection.pagingEnabled = YES;
    self.liveCollection.showsVerticalScrollIndicator = NO;
    self.liveCollection.delegate = self;
    self.liveCollection.dataSource = self;
    [self.liveCollection registerClass:[LTLiveCollectionViewCell class] forCellWithReuseIdentifier:key];
}

- (void)headerView
{
    
    
    CGFloat titleH = 42;
    CGFloat titleY = 0;
    CGFloat titleX = MARGIN;
    for (NSInteger i=0; i< self.titleArr.count; i++) {
        
        CGFloat titleW = [self stringSizeWithString:self.titleArr[i]];
        if (i > 0) {
            titleX += ([self stringSizeWithString:self.titleArr[i - 1]] + MARGIN);
        }
        
        CGRect LabelFrame = CGRectMake(titleX, titleY, titleW, titleH);
        LTScrollHeaderLabel *titleLabel = [[LTScrollHeaderLabel alloc] initWithFrame:LabelFrame andText:self.titleArr[i]];
        titleLabel.tag = i;
        titleLabel.font = self.currenFont;
        titleLabel.text = self.titleArr[i];
        titleLabel.userInteractionEnabled = YES;
        if (i == 0) {
            titleLabel.scale = 1.0;
        }else{
            titleLabel.scale = 0.0;
        }
        //  添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollHeaderLabelClicked:)];
        [titleLabel addGestureRecognizer:tap];
        [self.labelMuArr addObject:titleLabel];
        [self.scrollHeader addSubview:titleLabel];
    };
    
    self.navLayer.frame = CGRectMake(MARGIN, titleH, [self stringSizeWithString:self.titleArr[1]], 2);
    
    [self.scrollHeader addSubview:self.navLayer];
}
#pragma mark- 手势事件
- (void)scrollHeaderLabelClicked:(UITapGestureRecognizer *)gesture
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:gesture.view.tag inSection:0];
    [self.liveCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}



- (void)choiceAreaButton:(UIButton *)sender
{
    
}

#pragma mark - stringLenth
- (CGFloat)stringSizeWithString:(NSString *)str
{
    CGFloat stringWidth = (SCREEN_WIDTH - (self.titleArr.count + 1) * MARGIN ) / (self.titleArr.count + 1);
    
    NSMutableArray *fontMuArr = [NSMutableArray array];
    NSArray *arr = @[ @10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26];
    for (NSInteger i = 0; i<arr.count; i++) {
        CGSize stringSize = [@"字体" sizeWithAttributes:@{
                                                        NSFontAttributeName:[UIFont systemFontOfSize:[arr[i] floatValue ] - 1]
                                                        }];
        if (stringSize.width <= stringWidth && stringSize.width >= stringWidth - 5) {
            [fontMuArr addObject:[UIFont systemFontOfSize:[arr[i] floatValue] - 1]];
            self.currenFont = fontMuArr.lastObject;
            return stringWidth * str.length / 2;
        }
    }
    return stringWidth;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:key forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:NSClassFromString(@"UICollectionView")]) {
        CGFloat moveOffset = scrollView.contentOffset.x / SCREEN_WIDTH;
        NSInteger moveIndex = moveOffset;
        CGFloat leftScale = moveOffset - moveIndex;
        CGFloat rightScale = 1 - leftScale;
        //  颜色渐变效果
        if (moveIndex < self.labelMuArr.count - 1 ) {
            LTScrollHeaderLabel *nextLabel = self.labelMuArr[moveIndex + 1];
            nextLabel.scale = leftScale;
            LTScrollHeaderLabel *currentLabel = self.labelMuArr[moveIndex];
            currentLabel.scale = rightScale;
        }
        //
        if (moveIndex < self.titleArr.count  && moveIndex >= 0) {
            CGRect navLayerFrame;
            LTScrollHeaderLabel *currentLabel = self.labelMuArr[moveIndex];
            LTScrollHeaderLabel *nextLabel;
            if (moveIndex < self.titleArr.count - 1) {
                nextLabel = self.labelMuArr[moveIndex + 1];
            }
            CGFloat currentLabelWidth = currentLabel.frame.size.width;
            CGFloat nextLabelWidth = nextLabel.frame.size.width;
            CGFloat distance = nextLabel.frame.origin.x - currentLabel.frame.origin.x;
            navLayerFrame.origin.y = self.navLayer.frame.origin.y;
            navLayerFrame.size.height = self.navLayer.frame.size.height;
            //  往左滑动
            if (moveOffset > self.moveOffset) {
                navLayerFrame.origin.x = currentLabel.frame.origin.x;
                navLayerFrame.size.width = currentLabelWidth + (nextLabelWidth - currentLabelWidth) * leftScale;
                navLayerFrame.origin.x += distance *leftScale;
            }
            //  右滑动
            if (moveOffset < self.moveOffset) {
                navLayerFrame.origin.x = nextLabel.frame.origin.x ;
                navLayerFrame.size.width = nextLabelWidth + (currentLabelWidth - nextLabelWidth) * rightScale;
                navLayerFrame.origin.x -= distance * rightScale;
            }
            //  animation
            [UIView animateWithDuration:0.1 animations:^{
                self.navLayer.frame = navLayerFrame;
            }];
            //  记录移动位置
            self.moveOffset = moveOffset;
        }
        
    }
}

//#pragma mark - UITabBarDelegate
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    switch (item.tag) {
//        case 0:
//            LTLog(@"home");
//            break;
//        case 1:{
//            LTLog(@"player");
//            LTMyLiveRoomViewController *liveRoom = [LTMyLiveRoomViewController new];
//            [liveRoom setDismissBlock:^{
//                self.view.hidden = NO;
//            }];
//            [self presentViewController:liveRoom animated:YES completion:^{
//                self.view.hidden = YES;
//            }];
//            break;
//        }
//        case 2:
//            LTLog(@"mineHome");
//            [self.navigationController pushViewController:[LTLiveMineHomeController new] animated:YES];
//            break;
//        default:
//            break;
//    }
//}



@end
