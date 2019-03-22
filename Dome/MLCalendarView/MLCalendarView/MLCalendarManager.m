//
//  MLCalendarManager.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2019/3/22.
//  Copyright © 2019 无敌小蚂蚱. All rights reserved.
//

#import "MLCalendarManager.h"

@interface MLCalendarManager()

@property (nonatomic,strong)MLCalendarView * calendarView;
@property (nonatomic,strong)UIView * topView;


@end
@implementation MLCalendarManager

+ (MLCalendarManager *)shareManager {
    
    static MLCalendarManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (void)showCalendarViewMaxTotal:(NSInteger)maxTotal mainColor:(UIColor *)color calendarBlock:(void(^)(NSString *beginDate, NSString *endDate, NSInteger total))block{
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MLMainScreenOfWidth, 100.0)];
    self.topView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCalendarView)];
    [self.topView addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.topView];

    self.calendarView = [[MLCalendarView alloc] initWithFrame:CGRectMake(0, MLMainScreenOfHeight, MLMainScreenOfWidth, MLMainScreenOfHeight - 100)];
    
    self.calendarView.backgroundColor = [UIColor whiteColor];
    
    self.calendarView.multiSelect = (maxTotal == 1)?NO:YES;
    
    self.calendarView.maxTotal = maxTotal;
    
    self.calendarView.mlColor = color?color:MLColor;
    
    [self.calendarView constructionUI];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.calendarView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.calendarView.frame = CGRectMake(0, 100, MLMainScreenOfWidth, MLMainScreenOfHeight - 100);
        
    } completion:^(BOOL finished) {
        self.topView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
    }];
    
    __weak typeof(self) weakSelf = self;
    
    self.calendarView.cancelBlock = ^{
        
        [weakSelf removeCalendarView];
    };
    
    self.calendarView.selectBlock = ^(NSString *date) {
        
        block(date,date,1);
        
        [weakSelf removeCalendarView];
    };
    
    self.calendarView.multiSelectBlock = ^(NSString *beginDate, NSString *endDate, NSInteger total) {
        
        
        block(beginDate,endDate,total);
        
        [weakSelf removeCalendarView];
    };
    
}
- (void)removeCalendarView{
    
    self.topView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        
       self.calendarView.frame = CGRectMake(0, MLMainScreenOfHeight, MLMainScreenOfWidth, MLMainScreenOfHeight - 100);
    } completion:^(BOOL finished) {
        
        self.topView.backgroundColor = [UIColor clearColor];
        [self.topView removeFromSuperview];
        [self.calendarView removeFromSuperview];
    }];
}

    
@end
