//
//  ViewController.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "ViewController.h"

#import "MLCalendarManager.h"


@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 35.0)];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    btn.backgroundColor =[UIColor orangeColor ];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnAction{
    
    [[MLCalendarManager shareManager] showCalendarViewMaxTotal:4 mainColor:[UIColor orangeColor] calendarBlock:^(NSString * _Nonnull beginDate, NSString * _Nonnull endDate, NSInteger total) {
      
        NSLog(@"%@--%@ = %ld天",beginDate,endDate,total);
        
    }];
}

@end
