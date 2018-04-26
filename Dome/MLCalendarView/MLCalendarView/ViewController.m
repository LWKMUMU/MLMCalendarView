//
//  ViewController.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "ViewController.h"


#import "MLCalendarView.h"


@interface ViewController ()

@property (nonatomic,strong)MLCalendarView * calendarView;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendarView = [[MLCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    
    self.calendarView.backgroundColor = [UIColor whiteColor];
    
    self.calendarView.multiSelect = YES;
    
    self.calendarView.maxTotal = 2;
    
    [self.calendarView constructionUI];
    
    __weak typeof(self) weakSelf = self;
    
    self.calendarView.cancelBlock = ^{
      
        [weakSelf.calendarView removeFromSuperview];
    };
    
    self.calendarView.selectBlock = ^(NSString *date) {
        
        
    };
    self.calendarView.multiSelectBlock = ^(NSString *beginDate, NSString *endDate, NSInteger total) {
        
        
    };
    
    [self.view addSubview:self.calendarView];
    
}



@end
