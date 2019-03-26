//
//  MLCalendarModel.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLCalendarDayModel : NSObject

@property (nonatomic,assign)NSInteger day;//公历日

@property (nonatomic,copy)NSString * lunarDay;//农历日

@property (nonatomic,copy)NSString * holidayName;//节日

@property (nonatomic,copy)NSString * lunarDate;//农历日期

@property (nonatomic,copy)NSString * date;//公历日期


@end

@interface MLCalendarModel : NSObject

@property (nonatomic,copy)NSString * date;//日期

@property (nonatomic,copy)NSString * year;//年

@property (nonatomic,copy)NSString * month;//月

@property (nonatomic,assign)NSInteger days;//天数

@property (nonatomic,assign)NSInteger firstDay_WeekDay;//第一天是周几

@property (nonatomic,assign)NSInteger highlightedAtIndex;//高亮显示

@property (nonatomic,strong)NSMutableArray * highlightedArray;//高亮显示的集合

@property (nonatomic,assign)BOOL hiddenLunar;//是否隐藏农历日期显示 默认显示

@end

@interface MLCalendarHighlightedModel : NSObject

@property (nonatomic,assign)NSInteger month;

@property (nonatomic,assign)NSInteger day;

@end
