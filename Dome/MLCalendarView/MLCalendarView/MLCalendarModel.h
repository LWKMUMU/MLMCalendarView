//
//  MLCalendarModel.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLCalendarModel : NSObject

@property (nonatomic,strong)NSString * date;//日期

@property (nonatomic,strong)NSString * year;//年

@property (nonatomic,strong)NSString * month;//月

@property (nonatomic,assign)NSInteger days;//天数

@property (nonatomic,assign)NSInteger firstDay_WeekDay;//第一天是周几

@property (nonatomic,assign)NSInteger highlightedAtIndex;//高亮显示

@property (nonatomic,strong)NSMutableArray * highlightedArray;//高亮显示的集合

@end

@interface MLCalendarHighlightedModel : NSObject

@property (nonatomic,assign)NSInteger month;

@property (nonatomic,assign)NSInteger day;

@end
