//
//  UMSegmentView.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UMSegmentViewDeletegate <NSObject>
@optional

/**
 选中下标方法
 @param segIndex 当前选中下标
 */
-(void)changeSegmentAtIndex:(NSInteger)segIndex;

@end


/**
 * 模仿今日头条的Segment
 */
@interface UMSegmentView : UIView


/**
 *  Delegate
 */
@property (nonatomic, weak) id<UMSegmentViewDeletegate> delegate;

/**
 *  标题数组
 */
@property (nonatomic, copy) NSArray <NSString *> *items;


/**
 *  未选中时的文字颜色,默认黑色
 */
@property (nonatomic,strong) UIColor *titleNormalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont *titleFont;

/**
 *  当前被选中的下标，设置默认选中下标为0
 */
@property (nonatomic,assign) NSInteger selectedSegmentIndex;

/**
 *  初始化方法
 *
 *  @param items 标题数组
 */
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

/**
 选中下标
 */
-(void)selectIndex:(NSInteger)index;


@end
