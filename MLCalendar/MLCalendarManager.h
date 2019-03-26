//
//  MLCalendarManager.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2019/3/22.
//  Copyright © 2019 无敌小蚂蚱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCalendarView.h"

NS_ASSUME_NONNULL_BEGIN


@interface MLCalendarManager : NSObject

+ (MLCalendarManager *)shareManager;

/*
 显示view
 *maxTotal 可选择的天数限制
 *color 主题颜色
 *hiddenLunar 隐藏农历日期
 *block 确定回调
 */
- (void)showCalendarViewMaxTotal:(NSInteger)maxTotal
                       mainColor:(UIColor *)color
                     hiddenLunar:(BOOL)hiddenLunar
                   calendarBlock:(void(^)(NSString *beginDate, NSString *endDate, NSInteger total))block;

@end

NS_ASSUME_NONNULL_END
