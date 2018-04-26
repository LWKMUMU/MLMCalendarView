//
//  MLCalendarCollectionViewCell.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLCalendarModel.h"

@protocol MLCalendarCollectionViewCellDelegate<NSObject>

//单次 点击 回调
- (void)CalendarCellSelected:(id)cell;
@end

@interface MLCalendarCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong) UIColor * selectedColor;

@property (nonatomic,copy) id <MLCalendarCollectionViewCellDelegate>delegate;
@property (nonatomic,strong)MLCalendarModel * model;

@property (nonatomic,assign)NSInteger day;//几号 model 里只包含年月信息 不包含几号信息
- (void)settingModel:(MLCalendarModel *)model forIndexPath:(NSIndexPath *)indexPath;
@end
