//
//  UMDetailLogCell.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/23.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * UMDetailLogCell的数据模型
 */
@interface UMDetailLogCellData : NSObject

@property(nonatomic,copy)NSString* version;
@property(nonatomic,copy)NSString* updateTime;
@property(nonatomic,copy)NSString* updateLog;

@end

@interface UMDetailLogCell : UITableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellData:(UMDetailLogCellData*_Nullable)cellData;

@property(nonatomic,strong)UMDetailLogCellData* _Nullable cellData;

@property(nonatomic,strong)UILabel* _Nullable versionLabel;
@property(nonatomic,strong)UILabel* _Nullable updateTimeLabel;

@property(nonatomic,strong)UILabel* _Nullable separatorLabel;

@property(nonatomic,strong)UILabel* _Nullable updateLogLabel;


-(CGFloat) heightForDetailLogCell;
@end

NS_ASSUME_NONNULL_END
