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
#define ML153COLOR [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
#define MLRESTCOLOR [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]
#define MLFONT_PF_SC_Regular @"PingFangSC-Regular"
#define MLFONT_PF_SC_Medium @"PingFangSC-Medium"

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆节",@"儿童节",@"圣诞",@"七夕",@"端午节",@"清明节",@"元宵节",@"重阳节",@"腊八节",@"小年",@"建军节",@"妇女节",@"植树节",@"青年节",@"愚人节",@"元旦"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]
@interface MLCalendarCollectionViewCell()

@property (nonatomic,strong,readwrite)UIView * backView;

@property (nonatomic,strong,readwrite)UILabel * label;

@property (nonatomic,strong)UILabel * lunarLabel;//农历
@end

@implementation MLCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
        
        if (subView.tag == 100){
            
            [subView removeFromSuperview];
        }
    }
    self.backView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = self.bounds.size.width /2.f;
    self.backView.layer.masksToBounds = YES;
    self.backView.tag = 100;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.backView.bounds.size.height - 35.0)/2.0, self.backView.bounds.size.width, 21.0)];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.textColor = MLSTATENORMALCOLOR;
    
    self.label.font = [UIFont fontWithName:MLFONT_PF_SC_Regular size:17];
    self.label.tag = 200;
    
    self.lunarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label.frame), self.backView.bounds.size.width, 15.0 )];
    
    self.lunarLabel.textAlignment = NSTextAlignmentCenter;
    
    self.lunarLabel.textColor = ML153COLOR;
    
    self.lunarLabel.font = [UIFont fontWithName:MLFONT_PF_SC_Regular size:10];
    
    self.lunarLabel.tag = 300;
    
    [self.contentView addSubview:self.backView  ];
    
    [self.backView addSubview:self.label];
    [self.backView addSubview:self.lunarLabel];
    
}

- (void)settingModel:(MLCalendarModel *)model forIndexPath:(NSIndexPath *)indexPath{

    //第一个显示的从周几开始
    
    if (model.hiddenLunar){
        //隐藏农历日期
        self.lunarLabel.hidden = YES;
        self.label.frame = CGRectMake(0, 0, self.backView.bounds.size.width, self.backView.bounds.size.height);
        
        
    }
    if (indexPath.row < model.firstDay_WeekDay - 1){
        self.model = nil;
        self.backView.hidden = YES;
        
    }else{
        
        self.backView.hidden = NO;
        self.model = model;
        self.label.text = [NSString stringWithFormat:@"%ld",indexPath.row - model.firstDay_WeekDay + 2];
        self.day = [self.label.text integerValue];
        
        NSDate * date = [self dateFromString:[NSString stringWithFormat:@"%@-%@-%ld",model.year,model.month,self.day]];
        
        NSString * lunar = [self chineseCalendarOfDate:date];
        
        self.lunarLabel.text = lunar;
        
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
            self.lunarLabel.textColor = [UIColor whiteColor];
        }else{
            if ( index == 1 || index == 2 ){
                
                self.label.textColor = MLRESTCOLOR;
                self.lunarLabel.textColor = MLRESTCOLOR;
            }else{
                self.label.textColor = MLSTATENORMALCOLOR;
                self.lunarLabel.textColor = ML153COLOR;
            }
            self.backView.backgroundColor = [UIColor whiteColor];
        }

    }
}

- (NSDate *)dateFromString:(NSString *)string
{
    NSString *dateString = string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSCalendar *normalDate = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *Datecomponents = [normalDate components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSString * _day = @"";
    
    if (components.day == 1 ) {
        _day = ChineseMonths[components.month - 1];
        
    } else {
        
        _day = ChineseDays[components.day - 1];
    }
    //农历
    if (components.day == 1 && components.month == 1) {
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[1]];  //春节
    }else if (components.month == 1 && components.day == 15){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[10]]; //元宵节
    }else if(components.month == 8 && components.day == 15){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[2]];  //中秋
    }else if(components.month == 7 && components.day == 7){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[7]];  //七夕
    }else if(components.month == 5 && components.day == 5){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[8]];  //端午
    }else if(components.month == 9 && components.day == 9){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[11]]; //重阳
    }else if(components.month == 12 && components.day == 8){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[12]]; //腊八
    }else if(components.month == 12 && components.day == 23){
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[13]]; //小年
    }
    //阳历
    if (Datecomponents.month == 6 && Datecomponents.day == 1) {       //儿童节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[5]];
    }else if(Datecomponents.month == 10 && Datecomponents.day == 1){  //国庆节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[4]];
    }else if(Datecomponents.month == 5 && Datecomponents.day == 1){   //劳动节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[3]];
    }else if(Datecomponents.month == 12 && Datecomponents.day == 25){ //圣诞节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[6]];
    }else if (Datecomponents.month == 4 && Datecomponents.day == 5){  //清明节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[9]];
    }else if (Datecomponents.month == 8 && Datecomponents.day == 1){  //建军节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[14]];
    }else if (Datecomponents.month == 3 && Datecomponents.day == 8){  //妇女节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[15]];
    }else if (Datecomponents.month == 3 && Datecomponents.day == 12){ //植树节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[16]];
    }else if (Datecomponents.month == 5 && Datecomponents.day == 4){  //青年节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[17]];
    }else if (Datecomponents.month == 4 && Datecomponents.day == 1){  //愚人节
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[18]];
    }else if (Datecomponents.month == 1 && Datecomponents.day == 1){  //元旦
        _day = [NSString stringWithFormat:@"%@",ChineseFestival[19]];
    }
    return _day;
}
@end
