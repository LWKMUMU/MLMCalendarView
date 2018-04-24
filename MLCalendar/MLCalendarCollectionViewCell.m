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
@implementation MLCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backView.layer.cornerRadius = (self.bounds.size.width - 6.f)/2.f;

}
- (void)settingModel:(MLCalendarModel *)model forIndexPath:(NSIndexPath *)indexPath{

    //第一个显示的从周几开始
    
    if (indexPath.row < model.firstDay_WeekDay - 1){
        self.model = nil;
        self.lineLabel.hidden = YES;
        self.backView.hidden = YES;
        
    }else{
        
        self.lineLabel.hidden = NO;
        self.backView.hidden = NO;
        self.model = model;
        self.label.text = [NSString stringWithFormat:@"%ld",indexPath.row - model.firstDay_WeekDay + 2];
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
            self.currentLabel.textColor = [UIColor whiteColor];
        }else{
            if ( index == 1 || index == 2 ){
                
                self.label.textColor = MLRESTCOLOR;
            }else{
                self.label.textColor = MLSTATENORMALCOLOR;
            }
            self.currentLabel.textColor = MLRESTCOLOR;
            self.backView.backgroundColor = [UIColor whiteColor];
        }

    }
}
@end
