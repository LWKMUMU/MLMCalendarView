//
//  MLCalendarView.h
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/26.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCalendarView : UIView

@property (nonatomic,assign)BOOL multiSelect;//是否多选 默认NO

@property (nonatomic,strong)UIColor * mlColor;//主题颜色 默认 深红色[UIColor colorWithRed:255/255.0 green:57/255.0 blue:84/255.0 alpha:1.0]

@property (nonatomic,assign)NSInteger maxTotal;//最多可选天数，只有当multiSelect==YES时有效 默认66天

- (void)constructionUI;//开始布局

/*
 *取消回调
 */
@property (nonatomic,copy) void(^cancelBlock)(void);

/*
 *multiSelect == YES 回调
 *beginDate 起始日期
 *endDate 结束日期
 *total 总天数
 */
@property (nonatomic,copy) void(^multiSelectBlock)(NSString * beginDate,NSString * endDate,NSInteger total);

/*
 *multiSelect == NO 回调
 *date 日期
 */
@property (nonatomic,copy) void(^selectBlock)(NSString * date);

@end
