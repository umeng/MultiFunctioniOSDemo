//
//  UMSegmentViewCell.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  UMSegmentViewCell
 */
@interface UMSegmentViewCell : UICollectionViewCell

/**
 *  标签label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  当前是否被选中
 */
@property (nonatomic, assign) BOOL isSeleted;

/**
 *  选中后下划线高度
 */
@property (nonatomic, assign) CGFloat bottomLineWidth;

@end
