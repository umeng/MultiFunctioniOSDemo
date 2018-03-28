//
//  UMSegmentView.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMSegmentView.h"

#import "UMSegmentViewCell.h"
#import "UMCollectionViewFlowLayout.h"
#import "UMengComUtility.h"

//复用cell的标识
#define kUMSegmentViewCellIdeitifier @"UMSegmentViewCellIdeitifier"

//选中的文字颜色
#define kUMRedColor [[UIColor orangeColor] colorWithAlphaComponent:0.99]

//最大可见个数
#define kUMMaxVisibleCount 3

@interface UMSegmentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) UMCollectionViewFlowLayout* layout;

@property(nonatomic,strong)NSLayoutConstraint * constraintW;
@property(nonatomic,strong)NSLayoutConstraint * constraintH;
@property(nonatomic,strong)NSLayoutConstraint * constraintCenterX;
@property(nonatomic,strong)NSLayoutConstraint * constraintCenterY;


- (void)initialProperty;

-(void)createCollectionView;

-(void)updateView;
@end

@implementation UMSegmentView


#pragma mark -  overide method
- (instancetype)init
{
    if (self = [super init]) {
        [self initialProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialProperty];
    }
    return self;
}


#pragma mark - public method

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialProperty];
    }
    return self;
}


#pragma mark - Setter
- (void)setItems:(NSArray *)items
{
    _items = items;
    [self updateView];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    [self updateView];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    [self updateView];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self updateView];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    _selectedSegmentIndex = selectedSegmentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self updateView];
}

- (void)selectIndex:(NSInteger)index
{
    if (index < 0 || index >= _items.count) {
        NSLog(@"invalid index :%ld",(long)index);
        return;
    }
    self.selectedSegmentIndex = index;
}

#pragma mark - private method
- (void)initialProperty
{
    [self createCollectionView];
    
    _titleFont = [UIFont systemFontOfSize:15];
    _titleNormalColor = [UIColor blackColor];
    _titleSelectColor = UIColorFromRGBHex(0x2196F3);
    _selectedSegmentIndex = 0;
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor =  [UIColor clearColor];
    
    // 设置约束
    //创建宽度约束
    self.constraintW =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    //创建高度约束
    self.constraintH = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    //水平居中约束
    self.constraintCenterX =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //竖直居中
    self.constraintCenterY =  [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addSubview:self.collectionView];
    [self addConstraints:@[self.constraintW,self.constraintH,self.constraintCenterX, self.constraintCenterY]];
}

-(void)createCollectionView
{
    self.layout =  [[UMCollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake(20, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UMSegmentViewCell class] forCellWithReuseIdentifier:kUMSegmentViewCellIdeitifier];
    [self addSubview:self.collectionView];
}

-(void)updateView{
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UMSegmentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUMSegmentViewCellIdeitifier forIndexPath:indexPath];
    cell.titleLabel.font = self.titleFont;
    cell.isSeleted = (indexPath.row == _selectedSegmentIndex ? YES : NO);
    cell.titleLabel.textColor = cell.isSeleted ? self.titleSelectColor : self.titleNormalColor;
    
    NSString *str = [_items objectAtIndex:indexPath.row];
    if (str) {
        cell.titleLabel.text = [_items objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize viewSize = self.bounds.size;
    return  CGSizeMake(viewSize.width/kUMMaxVisibleCount, viewSize.height);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.selectedSegmentIndex = indexPath.row;
    [collectionView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSegmentAtIndex:)]) {
        
        [self.delegate changeSegmentAtIndex:indexPath.row];
    }
}



@end
