//
//  UMFlipCollectionView.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMFlipCollectionViewDelegate <NSObject>
/**
 滑动回调
 @param index 对应的下标（从1开始）
 */
- (void)flipToIndex:(NSInteger)index;
@end

/**
 *  类似今日头条的内容view
 */
@interface UMFlipCollectionView : UIView


/**
 存放对应的内容控制器
 */
@property (nonatomic, strong)NSMutableArray <UIViewController *>*dataArray;

/**
 delegate
 */
@property (nonatomic, weak) id<UMFlipCollectionViewDelegate> delegate;



/**
 初始化方法
 
 @param frame frame
 @param contentArray 视图控制器数组
 @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray <UIViewController *>*)contentArray;
/**
 手动选中某个页面
 
 @param index 默认为1（即从1开始）
 */
-(void)selectIndex:(NSInteger)index;

@end
