//
//  MLCalendarCollectionViewCell.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/24.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "MLCalendarCollectionViewCell.h"
#import "MLCalendarViewModel.h"
#define MLSTATENORMALCOLOR [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define MLRESTCOLOR [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]

@interface MLCalendarCollectionViewCell()

@property (nonatomic,strong,readwrite)UIView * backView;

@property (nonatomic,strong,readwrite)UILabel * label;

@end

@implementation MLCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self baseUI];
    }
    return self;
}

- (void)baseUI{
    
    for (UIView * subView in self.contentView.subviews){
        
        if (subView.tag == 100 || subView.tag == 200){
            
            [subView removeFromSuperview];
        }
    }
    self.backView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = self.bounds.size.width /2.f;
    self.backView.layer.masksToBounds = YES;
    self.backView.tag = 100;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.backView.bounds.size.width, self.backView.bounds.size.height)];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.textColor = MLSTATENORMALCOLOR;
    
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.tag = 200;
    
    [self.contentView addSubview:self.backView  ];
    
    [self.backView addSubview:self.label];
    
}

- (void)settingModel:(MLCalendarModel *)model forIndexPath:(NSIndexPath *)indexPath{

    //第一个显示的从周几开始
    
    if (indexPath.row < model.firstDay_WeekDay - 1){
        self.model = nil;
        self.backView.hidden = YES;
        
    }else{
        
        self.backView.hidden = NO;
        self.model = model;
        self.label.text = [NSString stringWithFormat:@"%d",indexPath.row - model.firstDay_WeekDay + 2];
        self.day = [self.label.text integerValue];
        
        NSInteger index = (self.day + model.firstDay_WeekDay)%7;
        
        BOOL highlighted = NO;
        for (NSString * highlightedIndexStr in self.model.highlightedArray){
            
            NSInteger highlightedIndex = [highlightedIndexStr integerValue];
            
            if (self.day == highlightedIndex){
                
                highlighted = YES;
                break;
            }
        }
        if (highlighted){
            
            self.backView.backgroundColor = self.selectedColor;
            self.label.textColor = [UIColor whiteColor];
            
        }else{
            if ( index == 1 || index == 2 ){
                
                self.label.textColor = MLRESTCOLOR;
            }else{
                self.label.textColor = MLSTATENORMALCOLOR;
            }
            self.backView.backgroundColor = [UIColor whiteColor];
        }

    }
}
@end
