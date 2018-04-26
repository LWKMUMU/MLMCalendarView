//
//  MLCalendarWeekDayView.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "MLCalendarWeekDayView.h"
#define MLSTATENORMALCOLOR [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define MLRESTCOLOR [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]
@interface MLCalendarWeekDayView()

@property (nonatomic,strong)NSArray * weekDayArray;

@end

@implementation MLCalendarWeekDayView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self baseUI];
    }
    
    return self;
}
- (void)baseUI{
    
    self.weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    CGFloat width = self.bounds.size.width/self.weekDayArray.count;
    
    for (int i = 0; i < self.weekDayArray.count; i ++){
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(width * i, 0, width, 45.f)];
        
        label.text = self.weekDayArray[i];
        
        
        if (i == 0 || i == 6){
            
            label.textColor = MLRESTCOLOR;

        }else{
            
            label.textColor = MLSTATENORMALCOLOR;
        }
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:label];
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
