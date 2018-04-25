//
//  MLCalendarView.m
//  MLCalendarView
//
//  Created by 伟凯   刘 on 2018/3/26.
//  Copyright © 2018年 无敌小蚂蚱. All rights reserved.
//

#import "MLCalendarView.h"
#import "MLCalendarModel.h"
#import "MLCalendarWeekDayView.h"
#import "MLCalendarCollectionViewCell.h"
#import "MLCollectionViewHeaderView.h"
#import "MLCalendarViewModel.h"

#define MLColor [UIColor colorWithRed:255/255.0 green:57/255.0 blue:84/255.0 alpha:1.0]

@interface MLCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _currentYear,_totalSelectedDay;
}

@property (nonatomic,strong)UILabel * yearLabel;

@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic,assign) NSInteger year;

@property (nonatomic,assign) NSInteger month;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong)MLCalendarWeekDayView * weekDayView;

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)MLCalendarHighlightedModel * highlightedModel;//高亮Model

@property (nonatomic,strong)MLCalendarHighlightedModel * moreEndHighlightedModel;//多选时 结束高亮Model

@property (nonatomic,strong)MLCalendarHighlightedModel * moreBeginHighlightedModel;//多选时 开始高亮Model

@end

@implementation MLCalendarView

- (NSMutableArray *)dataArray{
    
    if (!_dataArray){
        
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}



- (void)constructionUI{
    
     [self buildData];
}
- (void)buildData{
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100.f, 45.f)];
    _yearLabel.textAlignment = NSTextAlignmentLeft;
    _yearLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _yearLabel.textColor = self.mlColor?self.mlColor:MLColor;
    [self addSubview:_yearLabel];
    
    
    self.weekDayView = [[MLCalendarWeekDayView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_yearLabel.frame), self.bounds.size.width, 45.f)];
    self.weekDayView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.weekDayView];
    
    [[MLCalendarViewModel alloc] getCalendarDataArray:^(NSMutableArray *array, NSInteger monthIndex, NSInteger dayIndex) {
        
        self.dataArray = array;
        
        if (self.multiSelect){
            
            self.moreBeginHighlightedModel = [[MLCalendarHighlightedModel alloc] init];
            
            self.moreBeginHighlightedModel.month = monthIndex;
            
            self.moreBeginHighlightedModel.day = dayIndex;
            
        }else{
            
            self.highlightedModel  = [[MLCalendarHighlightedModel alloc] init];
            
            self.highlightedModel.month = monthIndex;
            
            self.highlightedModel.day = dayIndex;
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self baseUI];
            
        });
        
    }];
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
    }
    return self;
}
- (void)baseUI{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 45.f);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekDayView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.weekDayView.frame) - 45.f ) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
//    [self.collectionView registerNib:[UINib nibWithNibName:@"MLCalendarCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MLCalendarCollectionViewCell"];
    [self.collectionView registerClass:[MLCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MLCalendarCollectionViewCell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"MLCollectionViewHeaderView"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.collectionView];
    
    //滚动到当前日期
    [self layoutIfNeeded];
    NSInteger section = self.multiSelect?self.moreBeginHighlightedModel.month:self.highlightedModel.month;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    //确定选择按钮
    
    UIButton * trueBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.bounds.size.width, 45.f)];
    
    [trueBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [trueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    trueBtn.backgroundColor = self.mlColor?self.mlColor:MLColor;
    
    [self addSubview:trueBtn];
    
    [trueBtn addTarget:self action:@selector(trueBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _currentYear = year([NSDate date]);
    
    _yearLabel.text = [NSString stringWithFormat:@"%ld",(long)_currentYear];
    
    //取消按钮
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60.f, 0, 45.f, 45.f)];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    cancelBtn.backgroundColor = [UIColor clearColor];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:cancelBtn];
    
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)cancelBtnAction{
    
    self.cancelBlock();
}
- (void)trueBtnAction{
    
    if (self.multiSelect ){
        
        if(self.moreBeginHighlightedModel && self.moreEndHighlightedModel){
            
            MLCalendarModel * beginModel = self.dataArray[self.moreBeginHighlightedModel.month];
            
            MLCalendarModel * endModel = self.dataArray[self.moreEndHighlightedModel.month];
            
            NSLog(@"%@-%ld    %@-%ld 共%ld 天",beginModel.date,(long)self.moreBeginHighlightedModel.day,endModel.date,(long)self.moreEndHighlightedModel.day,(long)_totalSelectedDay);
            
            if (self.multiSelectBlock){
                
                self.multiSelectBlock([NSString stringWithFormat:@"%@-%ld",beginModel.date,(long)self.moreBeginHighlightedModel.day], [NSString stringWithFormat:@"%@-%ld",endModel.date,(long)self.moreEndHighlightedModel.day], _totalSelectedDay);
            }
        }
    }else{
        
        if (self.highlightedModel){
            
            MLCalendarModel * selectedModel = self.dataArray[self.highlightedModel.month];

            NSLog(@"%@-%ld",selectedModel.date,(long)self.highlightedModel.day);
            
            if (self.selectBlock){
                
                self.selectBlock([NSString stringWithFormat:@"%@-%ld",selectedModel.date,(long)self.highlightedModel.day]);
            }
        }
        
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section < self.dataArray.count){
        
        MLCalendarModel * model = self.dataArray[section];
        //第一个显示从周几开始
        
        return model.days + model.firstDay_WeekDay - 1;
    }else{
        
        return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MLCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MLCalendarCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.section < self.dataArray.count){
        
        MLCalendarModel * model = self.dataArray[indexPath.section];
        cell.selectedColor = self.mlColor?self.mlColor:MLColor;
        [cell settingModel:model forIndexPath:indexPath];
    }
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < self.dataArray.count){
        
        MLCalendarModel * model = self.dataArray[indexPath.section];

        if (indexPath.row < model.firstDay_WeekDay - 1){
            
            return;
        }else{
            
            if (self.multiSelect){//多选
                
                if (self.moreEndHighlightedModel && self.moreBeginHighlightedModel){//已经多选  取消已经选中的区间 设置新的起始点
                    [self collectionViewAlreadyMultiSelectItemAtIndexPath:indexPath calendarModel:model];
                   
                    return;
                    
                }else{
                    
                    //多选
                    [self collectionViewMultiSelectItemAtIndexPath:indexPath calendarModel:model];
                }
                
            }else{
                //单选
                [self collectionViewMultipleChoiceItemAtIndexPath:indexPath calendarModel:model];
            }
        }
    }
}

#pragma mark -  已经多选 取消已经多选的 设置新的起始点 |ML|
- (void)collectionViewAlreadyMultiSelectItemAtIndexPath:(NSIndexPath *)indexPath calendarModel:(MLCalendarModel *)model{
    
    for(int i = 0 ; i < self.dataArray.count; i ++){
        
        MLCalendarModel * model = self.dataArray[i];
        
        if (i == indexPath.section){
            
            model.highlightedArray = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"%d",indexPath.row - model.firstDay_WeekDay + 2]]];
        }else{
            
            model.highlightedArray = [NSMutableArray new];
        }
        
    }
    [UIView performWithoutAnimation:^{
        
        [self.collectionView reloadData];
    }];
    
    self.moreBeginHighlightedModel.month = indexPath.section;
    self.moreEndHighlightedModel = nil;
}

#pragma mark -  多选点击 |ML|
- (void)collectionViewMultiSelectItemAtIndexPath:(NSIndexPath *)indexPath calendarModel:(MLCalendarModel *)model{
    
   NSInteger total = [self determineDateOldModelItemAtIndexPath:indexPath calendarModel:model];
    
    if (total > (self.maxTotal?self.maxTotal:66)){//超过多选上线
        
        [self collectionViewAlreadyMultiSelectItemAtIndexPath:indexPath calendarModel:model];
        return;
    }
   
    //同月情况下处理
    _totalSelectedDay = 0;
    if(self.moreBeginHighlightedModel.month == self.moreEndHighlightedModel.month){
        
        MLCalendarModel * model = self.dataArray[self.moreBeginHighlightedModel.month];
        
        NSMutableArray * newHidlightedArray = [NSMutableArray new];
        
        for (NSInteger i = 1; i <= model.days; i ++){
            
            if (i >= self.moreBeginHighlightedModel.day && i <= self.moreEndHighlightedModel.day){
                
                _totalSelectedDay += 1;
                
                [newHidlightedArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                
            }
        }
        model.highlightedArray = newHidlightedArray;
        
        [self.dataArray replaceObjectAtIndex:self.moreBeginHighlightedModel.month withObject:model];
        
        [UIView performWithoutAnimation:^{
            
            [self.collectionView reloadData];
        }];
        
    }else{
        //不同月情况下处理
        for (NSInteger i = self.moreBeginHighlightedModel.month ;i <= self.moreEndHighlightedModel.month;i ++){
            
            MLCalendarModel * model = self.dataArray[i];
            
            NSMutableArray * newHidlightedArray = [NSMutableArray new];
            
            for (NSInteger j = 1; j <= model.days; j ++){
                
                if (i == self.moreBeginHighlightedModel.month){
                    
                    if (j >= self.moreBeginHighlightedModel.day){
                        
                        _totalSelectedDay += 1;
                        [newHidlightedArray addObject:[NSString stringWithFormat:@"%ld",(long)j]];
                    }
                }else if (i == self.moreEndHighlightedModel.month){
                    
                    if (j <= self.moreEndHighlightedModel.day){
                        _totalSelectedDay += 1;

                        [newHidlightedArray addObject:[NSString stringWithFormat:@"%ld",(long)j]];
                    }
                }else{
                    _totalSelectedDay += 1;

                    [newHidlightedArray addObject:[NSString stringWithFormat:@"%ld",(long)j]];
                }
            }
            
            model.highlightedArray = newHidlightedArray;
            
            [self.dataArray replaceObjectAtIndex:i withObject:model];
        }
        [UIView performWithoutAnimation:^{
            
            [self.collectionView reloadData];
        }];
    }
}
#pragma mark -  判断是否转换起止日期 |ML|
- (NSInteger )determineDateOldModelItemAtIndexPath:(NSIndexPath *)indexPath calendarModel:(MLCalendarModel *)model{
    
    NSInteger day = 1;

    day = indexPath.row - model.firstDay_WeekDay + 2;
    
    MLCalendarModel * oldHighlightedModel = [self.dataArray objectAtIndex:self.moreBeginHighlightedModel.month];
    
    NSInteger beginRow ;//起始日
    
    NSInteger endRow ;//结束日
    
    NSInteger beginSection ;//起始行
    
    NSInteger endSection ;//结束行
    
    //判断是否转换起始点（点击的日期小于当前高亮的日期 时 转换）
    
    NSInteger comp = compareDate([NSString stringWithFormat:@"%@-%@-%@",oldHighlightedModel.year,oldHighlightedModel.month,[oldHighlightedModel.highlightedArray objectAtIndex:0]], [NSString stringWithFormat:@"%@-%@-%ld",model.year,model.month,(long)day]);
    
    if (comp == -1){
        
        beginRow = indexPath.row - model.firstDay_WeekDay + 2;//结束日
        
        endRow =[[oldHighlightedModel.highlightedArray objectAtIndex:0] integerValue];//起始日
        
        beginSection = indexPath.section;//结束行
        
        endSection = self.moreBeginHighlightedModel.month;//起始行
        
        
    }else{
        beginRow = [[oldHighlightedModel.highlightedArray objectAtIndex:0] integerValue];//起始日
        
        endRow = indexPath.row - model.firstDay_WeekDay + 2;//结束日
        
        beginSection = self.moreBeginHighlightedModel.month;//起始行
        
        endSection = indexPath.section;//结束行
    }
    
    if (!self.moreEndHighlightedModel){
        
        self.moreEndHighlightedModel = [[MLCalendarHighlightedModel alloc] init];
    }
    self.moreBeginHighlightedModel.month = beginSection;
    
    self.moreBeginHighlightedModel.day = beginRow;
    
    self.moreEndHighlightedModel.month = endSection;
    
    self.moreEndHighlightedModel.day = endRow;
    
    //同月情况下处理
    NSInteger total = 0;
    if(self.moreBeginHighlightedModel.month == self.moreEndHighlightedModel.month){
        
        MLCalendarModel * model = self.dataArray[self.moreBeginHighlightedModel.month];
        
        for (NSInteger i = 1; i <= model.days; i ++){
            
            if (i >= self.moreBeginHighlightedModel.day && i <= self.moreEndHighlightedModel.day){
                
                total += 1;
            }
        }
    }else{
        //不同月情况下处理
        for (NSInteger i = self.moreBeginHighlightedModel.month ;i <= self.moreEndHighlightedModel.month;i ++){
            
            MLCalendarModel * model = self.dataArray[i];
            
            
            for (NSInteger j = 1; j <= model.days; j ++){
                
                if (i == self.moreBeginHighlightedModel.month){
                    
                    if (j >= self.moreBeginHighlightedModel.day){
                        
                        total += 1;
                    }
                }else if (i == self.moreEndHighlightedModel.month){
                    
                    if (j <= self.moreEndHighlightedModel.day){
                        total += 1;
                    }
                }else{
                    total += 1;
                    
                }
            }
        }
    }
    return total;
}

#pragma mark -  单选点击 |ML|
- (void)collectionViewMultipleChoiceItemAtIndexPath:(NSIndexPath *)indexPath calendarModel:(MLCalendarModel *)model{
    
    NSInteger day = 1;
    
    day = indexPath.row - model.firstDay_WeekDay + 2;
    
    MLCalendarModel * oldHighlightedModel = [self.dataArray objectAtIndex:self.highlightedModel.month];
    
    oldHighlightedModel.highlightedArray = [NSMutableArray new];
    
    [self.dataArray replaceObjectAtIndex:self.highlightedModel.month withObject:oldHighlightedModel];
    
    model.highlightedArray = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"%d",indexPath.row - model.firstDay_WeekDay + 2]]];
    
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:model];
    
    [UIView performWithoutAnimation:^{
        
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:self.highlightedModel.month]];
        
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
    
    
    self.highlightedModel.month = indexPath.section;
    
    self.highlightedModel.day = day;
    
    NSLog(@"单选点击日期:%@.%@.%ld",model.year,model.month,(long)day);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < self.dataArray.count){
        
        MLCalendarModel * model = self.dataArray[indexPath.section];
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            
            UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MLCollectionViewHeaderView" forIndexPath:indexPath];
            
            for (UIView * subView in header.subviews){
                
                if ([subView isKindOfClass:[UILabel class]]){
                    
                    [subView removeFromSuperview];
                }
            }
            header.backgroundColor =[UIColor whiteColor ];
            
            [self fillHeader:header model:model];
            
            return header;
            
        }else{
            
            return nil;
        }
    }else{
        
        return nil;
    }
}

- (void)fillHeader:(UICollectionReusableView *)headerView model:(MLCalendarModel *)model{
    
    CGFloat spacing = self.bounds.size.width/7;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((model.firstDay_WeekDay - 1) * spacing, 0, spacing, spacing)];
    
    label.text = [NSString stringWithFormat:@"%@月",model.month];
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont boldSystemFontOfSize:19];
    
    label.textAlignment  = NSTextAlignmentCenter;
    
    [headerView addSubview:label];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.bounds.size.width, 45.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(self.bounds.size.width/7,self.bounds.size.width/7);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSArray * indexPathArray = [self.collectionView indexPathsForVisibleItems];
    
    NSIndexPath * indexPath = [indexPathArray firstObject];
    
    if (indexPath.section < self.dataArray.count){
        
        MLCalendarModel * model = self.dataArray[indexPath.section];
        
        if (_currentYear != [model.year integerValue]){
            
            _currentYear = [model.year integerValue];
            
            _yearLabel.text = [NSString stringWithFormat:@"%ld",(long)_currentYear];
        }
    }
}


@end
