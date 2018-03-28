//
//  UMSegmentViewCell.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMSegmentViewCell.h"
#import "UMengComUtility.h"

@interface UMSegmentViewCell ()

@property (nonatomic, strong) UIColor *tintColor;

@end

@implementation UMSegmentViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //http://www.it610.com/article/1124263.htm
//        self.contentView.frame = self.bounds;
//        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundColor = [UIColor clearColor];
        _bottomLineWidth = 3.0f;
        
        _tintColor = UIColorFromRGBHex(0x2196F3);
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(frame),
                                           CGRectGetHeight(frame));
    }
    return self;
}

- (void)setIsSeleted:(BOOL)isSeleted
{
    _isSeleted = isSeleted;
    if (_isSeleted) {
        _titleLabel.textColor = _tintColor;
        
    }else
    {
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    [self setNeedsDisplay];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = _tintColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)drawRect:(CGRect)rect
{
    if (_isSeleted) {
        UIColor *circleColor = _tintColor;
        
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        CGFloat y = CGRectGetHeight(rect) - _bottomLineWidth;
        [linePath moveToPoint:CGPointMake(CGRectGetMinX(_titleLabel.frame) + 4, y)];
        [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(_titleLabel.frame) - 4, y)];
        linePath.lineWidth = _bottomLineWidth;
        [circleColor setStroke];
        [linePath stroke];
    }
}

@end
