# MLMCalendarView

#### 项目介绍


一般iOS系统中大多使用滚轮式日期选择 封装起来也比较简单 直接使用系统的就行
但有时我们需要根据产品的需求 要在项目中使用安卓样式日期选择器

为此封装了一个小的控件 ,使用时直接一句代码搞定，日期可单选可多选，可以变更主题颜色（仿iOS日历app样式）

仿iOS日历控件，支持日期单选和多选 支持自定义颜色


#### 安装教程

1. CocoaPods安装：
         Podfile文件 输入 
         pod 'MLMCalendarView','0.0.8'
         //如不是最新版本，请更新本地pod索引库
2. 手动安装
        下载该项目
        把文件夹中的“MLCalendar”文件夹add到自己项目中即可


#### 使用说明

1.  引入头文件  #import "MLCalendar.h"

2. 
[[MLCalendarManager shareManager] showCalendarViewMaxTotal:4 mainColor:[UIColor redColor] calendarBlock:^(NSString * _Nonnull beginDate, NSString * _Nonnull endDate, NSInteger total) {

//（单选时起始日期和结束日期一致，总天数为1）
NSLog(@"%@ --- %@ === %ld",beginDate,endDate,total);

}];

