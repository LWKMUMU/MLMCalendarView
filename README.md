# MLMCalendarView

#### 项目介绍

仿iOS日历控件，可单选和多选 自定义颜色

#### 安装教程

1. CocoaPods安装：
         Podfile文件 输入 
         pod 'MLMCalendarView','0.0.6'
         
2. 手动安装
        下载该项目
        把文件夹中的“MLCalendar”文件夹add到自己项目中即可


#### 使用说明

1.  引入头文件  #import "MLCalendarView.h"
2. 
@interface ViewController ()

@property (nonatomic,strong)MLCalendarView * calendarView;

@end

3. 
self.calendarView = [[MLCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100)];

self.calendarView.backgroundColor = [UIColor whiteColor];

self.calendarView.multiSelect = YES;//是否多选 默认NO

self.calendarView.maxTotal = 2;//最多可以选择几天 

self.calendarView.mlColor = [UIColor orangeColor];//主题颜色 默认 深红色[UIColor colorWithRed:255/255.0 green:57/255.0 blue:84/255.0 alpha:1.0]

[self.calendarView constructionUI];

__weak typeof(self) weakSelf = self;

self.calendarView.cancelBlock = ^{

[weakSelf.calendarView removeFromSuperview];
};

//单选回调
self.calendarView.selectBlock = ^(NSString *date) {


};

//多选回调
self.calendarView.multiSelectBlock = ^(NSString *beginDate, NSString *endDate, NSInteger total) {
    //beginDate 起始日期
    //endDate 结束日期
    //total 总的天数


};

[self.view addSubview:self.calendarView];
