//
//  MLCalendarViewModel.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/26.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCalendarModel.h"


@interface MLCalendarViewModel : NSObject

#pragma mark -- 获取当前月共有多少天
extern NSInteger day(NSDate * date);

#pragma mark -- 获取当前月共有多少天
extern NSInteger month(NSDate * date);

#pragma mark -- 获取当前月共有多少天
extern NSInteger year(NSDate * date);

#pragma mark -- 获取当前月共有多少天
extern NSInteger firstWeekdayInThisMonth(NSDate * date);

#pragma mark -- 获取当前月共有多少天
extern NSInteger totaldaysInMonth(NSDate * date);

#pragma mark -  获取日期数据 NSDateComponents monthIndex 月在数据源中的位置 高亮日在月中的位置|ML|
- (void)getCalendarDataArray:(void(^)(NSMutableArray * array,NSInteger monthIndex,NSInteger dayIndex))calendarData;

NSInteger compareDate(NSString * beginDate,NSString * endDate);
@end
