//
//  MLCalendarViewModel.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/26.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "MLCalendarViewModel.h"

@interface MLCalendarViewModel()

@property (nonatomic,assign) NSInteger year;

@property (nonatomic,assign) NSInteger month;

@end

@implementation MLCalendarViewModel


#pragma mark -  获取日期数据 NSDateComponents |ML|
- (void)getCalendarDataArray:(void(^)(NSMutableArray * array,NSInteger monthIndex,NSInteger dayIndex))calendarData {
    
    NSMutableArray * calendarArray = [NSMutableArray new];
    
    self.month = 0;
    //获取当前日期年份
    NSInteger currentYear = year([NSDate date]);
    
    NSInteger currentMonth = month([NSDate date]);
    
    NSInteger currentDay = day([NSDate date]);
    
    NSInteger currentMonthOfDataArray = 1;
    
    NSLog(@"当前年份:%ld",currentYear);
    
    //数据获取范围 当前年份前后各10年的日期数据
    
    self.year = currentYear - 10;
    
    for (NSInteger i = 0 ; i < 240; i ++){
        
        MLCalendarModel * model = [MLCalendarModel new];
        
        NSDate * date = [self setNextMonthWithDay];
        
        model.days = totaldaysInMonth(date);
        
        model.firstDay_WeekDay = firstWeekdayInThisMonth(date);
        
        model.date = [NSString stringWithFormat:@"%ld-%ld",self.year,self.month];
        
        model.year = [NSString stringWithFormat:@"%ld",self.year];
        
        model.month = [NSString stringWithFormat:@"%ld",self.month];
        
        //首次高亮显示位置
        if (self.year == currentYear && self.month == currentMonth){
            
            currentMonthOfDataArray = i;
            
            model.highlightedArray = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"%ld",currentDay]]];
        }
        [calendarArray addObject:model];

    }
    
//    NSLog(@"数据源个数:  %ld",calendarArray.count);
    
    calendarData(calendarArray,currentMonthOfDataArray,currentDay);
    
}


#pragma mark -  返回下个月第一天的date对象 |ML|
- (NSDate *)setNextMonthWithDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = nil;
    if (self.month != 12) {
        
        self.month += 1;
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",self.year,self.month,2]];
        
    }else{
        
        self.year += 1;
        self.month = 1;
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",self.year , self.month, 2]];
    }
    return date;
}

#pragma mark -- 获取日
NSInteger day(NSDate * date){
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.day;
}

NSInteger month(NSDate * date){
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.month;
}

NSInteger year(NSDate * date){
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.year;
    
}

NSInteger firstWeekdayInThisMonth(NSDate * date){
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday  ;
}

NSInteger totaldaysInMonth(NSDate * date){
    
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

NSInteger compareDate(NSString * beginDate,NSString * endDate){
    
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:beginDate];
    dtb = [dateformater dateFromString:endDate];
    NSComparisonResult result = [dta compare:dtb];
    
    if (result == NSOrderedSame){
        aa = 0;
    }else if (result==NSOrderedAscending){
        aa = 1;
    }else if (result==NSOrderedDescending){
        aa = -1;
    }
    
    return aa;
}

@end
