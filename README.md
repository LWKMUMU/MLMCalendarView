#### MLMCalendarView 一句代码搞定日历日期选择 
                  
##### 预览图
    可单选亦可多选 ，带农历日期显示
![image text](https://github.com/LWKMUMU/MLMCalendarView/blob/master/效果图.jpg)

#### 项目介绍
                  有时我们需要根据产品的需求 要在项目中使用安卓样式日期选择器
                  为此封装了一个小的控件 ,使用时直接一句代码搞定，日期可单选可多选，可以变更主题颜色
                  仿iOS日历app，支持日期 单选 和 多选 支持自定义颜色,后期陆续会添加其它功能
                  

#### 安装教程

##### 1. CocoaPods安装：
        Podfile文件 输入 
         
        pod 'MLMCalendarView','1.0.1'
 //如不是最新版本，请更新本地pod索引库
 
###### 2. 手动安装

        下载该项目
        把文件夹中的“MLCalendar”文件夹add到自己项目中即可

#### 使用说明

##### 1.  引入头文件  #import "MLCalendar.h"
``` Object-C
#import "MLCalendar.h"
 
//方式1（推荐）
/*
MaxTotal 最多可选的天数  单选 = 1
mainColor 主题颜色
calendarBlock 确定回调

*/

[[MLCalendarManager shareManager] showCalendarViewMaxTotal:4 mainColor:[UIColor redColor] calendarBlock:^(NSString * _Nonnull beginDate, NSString * _Nonnull endDate, NSInteger total) {

         //（单选时起始日期和结束日期一致，总天数为1）
         NSLog(@"%@ --- %@ === %ld",beginDate,endDate,total);

}];

//方式2
/*
创建 MLCalendarView
*/
@property (nonatomic,strong)MLCalendarView * calendarView;


self.calendarView = [[MLCalendarView alloc] initWithFrame:CGRectMake(0, 100, MLMainScreenOfWidth,            MLMainScreenOfHeight - 100)];
    
    self.calendarView.backgroundColor = [UIColor whiteColor];
    
    self.calendarView.multiSelect = YES;//是否多选
    
    self.calendarView.maxTotal = maxTotal;//可选择总天数
    
    self.calendarView.mlColor = [UIColor redColor];//主题颜色
    
    self.calendarView.hiddenLunar = No;//是否显示农历日期
    
    [self.calendarView constructionUI];//构建
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.calendarView];//添加到superView
    
    __weak typeof(self) weakSelf = self;
    
    //取消回调
    self.calendarView.cancelBlock = ^{
        
        [weakSelf removeCalendarView];
    };
    //单选回调
    self.calendarView.selectBlock = ^(NSString *date) {
        
        NSLog(@"%@",datel);
        
        [weakSelf removeCalendarView];
    };
    //多选回调
    self.calendarView.multiSelectBlock = ^(NSString *beginDate, NSString *endDate, NSInteger total) {
        
        NSLog(@"%@ --- %@ === %ld",beginDate,endDate,total);
        [weakSelf removeCalendarView];
    };
```


                  感谢您的来访 
                  如有好的建议或者需求可随时联系我 我会及时认真对待 三克油
                  鼠标动一动 star star star ！！！重要的事情说三遍 
