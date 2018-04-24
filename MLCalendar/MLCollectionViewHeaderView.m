//
//  MLCollectionViewHeaderView.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "MLCollectionViewHeaderView.h"

@interface MLCollectionViewHeaderView()


@end

@implementation MLCollectionViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self baseUI];
    }
    return self;
}
- (void)baseUI{
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    self.label.text = @"";
    
    self.label.textColor = [UIColor blackColor];
    
    self.label.textAlignment = NSTextAlignmentCenter ;
    
    [self addSubview:self.label];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
