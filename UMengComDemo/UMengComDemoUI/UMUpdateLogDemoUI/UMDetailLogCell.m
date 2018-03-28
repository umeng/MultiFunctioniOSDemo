//
//  UMDetailLogCell.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/23.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMDetailLogCell.h"

#import "UMengComUtility.h"



@implementation UMDetailLogCellData



@end

@interface UMDetailLogCell ()

-(void) createSubViews;
@end

@implementation UMDetailLogCell


#pragma mark - overide from UITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellData:(UMDetailLogCellData*)cellData
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellData = cellData;
        [self createSubViews];
        [self initialProperty];
    }
    return self;
}



#pragma mark - private method

-(void) createSubViews
{
    self.versionLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.versionLabel];
    
    self.updateTimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.updateTimeLabel];
    
    self.updateLogLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.updateLogLabel];
    self.updateLogLabel.numberOfLines = 0;
    
    self.separatorLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.separatorLabel];
}

-(void) initialProperty
{
    self.versionLabel.font = [UIFont systemFontOfSize:14];
    self.versionLabel.textColor = UIColorFromRGBHex(0x666666);
    
    self.updateTimeLabel.font = [UIFont systemFontOfSize:12];
    self.updateTimeLabel.textColor = UIColorFromRGBHex(0x999999);
    
    self.updateLogLabel.font = [UIFont systemFontOfSize:12];
    self.updateLogLabel.textColor = UIColorFromRGBHex(0x666666);
    
    self.separatorLabel.backgroundColor = UIColorFromRGBHex(0xEEEEEE);
}


#pragma mark - public method

-(CGFloat) heightForDetailLogCell
{
    if (!self.cellData) {
        return 0;
    }
    
   CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    CGFloat totalHeight = 0;
    
    totalHeight += 16;
    
    self.versionLabel.text = self.cellData.version;
    self.updateTimeLabel.text = self.cellData.updateTime;
    self.updateLogLabel.text = self.cellData.updateLog;
    
    //计算versionLabel的rect
    CGRect versionLabelRect =  [self.versionLabel textRectForBounds:screenBounds limitedToNumberOfLines:0];
    self.versionLabel.frame = CGRectMake(16, 16, versionLabelRect.size.width + 16, versionLabelRect.size.height);
    
    
    //计算updateTimeLabel的rect
    CGRect updateTimeLabelRect = [self.updateTimeLabel textRectForBounds:screenBounds limitedToNumberOfLines:0];
    
    self.updateTimeLabel.frame = CGRectMake(screenBounds.size.width -16 - updateTimeLabelRect.size.width,17,updateTimeLabelRect.size.width,updateTimeLabelRect.size.height);
    
    
    totalHeight += versionLabelRect.size.height;
    
    totalHeight += 4;
    
    self.separatorLabel.frame = CGRectMake(16, totalHeight, screenBounds.size.width -16, 1);
    totalHeight += 1;
    
    totalHeight += 4;
    
    
    
    //计算updateTimeLabel的rect
    CGRect updateLogLabelRect = [self.updateLogLabel textRectForBounds:screenBounds limitedToNumberOfLines:0];
    
    self.updateLogLabel.frame = CGRectMake(16, totalHeight, screenBounds.size.width -16, updateLogLabelRect.size.height);
    
    totalHeight += updateLogLabelRect.size.height;
    
    totalHeight += 16;

    
    
    self.contentView.frame = CGRectMake(0,0,screenBounds.size.width,totalHeight);
    
    return totalHeight;
}

@end
