//
//  CusPickerView.m
//  Picker
//
//  Created by gshmac on 13-8-18.
//  Copyright (c) 2013年 gshmac. All rights reserved.
//
#define ToolBarTitleTag 989900

#import "CusPickerView.h"
#import "UIColor+Custom.h"
#import "UIViewExt.h"

@interface CusPickerView ()
@property (nonatomic, strong) UIView *disableView;
@end

@implementation CusPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self initPickerView];
    [self updateToolBarTitle];

    }
    return self;
}
//更新工具栏标题
- (void) updateToolBarTitle
{
    UILabel *titleLabel=(UILabel *)[_tool viewWithTag:ToolBarTitleTag];
    titleLabel.text=_title;
    

}
- (id) initWithFrame:(CGRect) frame andOptions:(NSMutableArray *) options
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPickerView];
    }
    return self;
}

- (id) initWithFrame:(CGRect) frame andOptions:(NSMutableArray *) options andType:(PickerType) type andToolBarTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _isScrollAndChoose = NO;
        _options = [options copy];
        _title=[title copy];
        _type=type;
        _isHidden=YES;
        [self initPickerView];
    }
    return self;
}
- (void) setTheme:(int)theme
{
    for (UIBarButtonItem  *bar  in _tool.items) {
            UIButton  *btn =(UIButton *) (bar.customView);
             [btn setTitleColor:[UIColor customColorDefault] forState:UIControlStateNormal];
    }
}
 -(void) initPickerView
{
   //工具栏
    _tool=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    //工具栏的标题
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake((- 120)/2.0, 5, 120, 30)];
    titleLabel.text=_title;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.tag=ToolBarTitleTag;
    [_tool addSubview:titleLabel];
    titleLabel.textColor=[UIColor lightGrayColor];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    
    UIButton  *cancel = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor customColorDefault] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem  alloc] initWithCustomView:cancel];
    UIButton  *done = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor customColorDefault] forState:UIControlStateNormal];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem  alloc] initWithCustomView:done];

    //leftBar.
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _tool.items=[NSArray arrayWithObjects:leftBar,fixSpace,fixSpace,fixSpace,rightBar, nil];
    [self addSubview:_tool];
    if (_type==PickerTypeStandard || _type==PickerTypeMuColumn ) {
        //自定义的pickerview
        _picker=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        _picker.dataSource=self;
        _picker.delegate=self;
        _picker.backgroundColor=[UIColor whiteColor];
        _picker.showsSelectionIndicator=YES;
        _picker.tag=PickerViewTag;

        [self addSubview:_picker];
        
    }else{
        _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
        _datePicker.tag=CusPickerDateTag;
        _datePicker.datePickerMode=UIDatePickerModeDate;
        _datePicker.backgroundColor=[UIColor whiteColor];
        //ios 6 中文日期设置 ios5 是自动进行i匹配的
        NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale=locale;
        NSDate *currentDate=[NSDate date];
        _datePicker.maximumDate=[NSDate dateWithTimeIntervalSinceNow:60*60*24*365];
        _datePicker.minimumDate=currentDate;
        [_datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_datePicker];
    }
}
- (void) cancel:(id) sender
{
    if (_resizeFrameDelegate && [_resizeFrameDelegate respondsToSelector:@selector(cancelSelect)]) {
        [_resizeFrameDelegate cancelSelect];
    }
    if(self.onCancelBlock){
        self.onCancelBlock();
    }
    [self hiddenView];
}
//改变日期
- (void) changeDate:(id) sender
{
    NSDate *date=[((UIDatePicker *) sender) date];
    NSString *newDate=[DateHelper getFormatterDateStringFromDate:date andFormatter:@"yyyy-MM-dd"];

    //要根据日期生成星座,
    //星座和日期同时编辑，同时更新，星座关联日期转出

//    if (_delegate && [_delegate respondsToSelector:@selector(returnDataAndRefeshCellWithSelectValue:)]) {
//        [_delegate returnDataAndRefeshCellWithSelectValue:newDate];
//    }
    if (_resizeFrameDelegate && [_resizeFrameDelegate respondsToSelector:@selector(fillTextFieldValue:)]) {
        [_resizeFrameDelegate fillTextFieldValue:newDate];
    }
    UIDatePicker *datePickerView=(UIDatePicker *)[self viewWithTag:CusPickerDateTag];
    self.doneValue = [DateHelper getFormatterDateStringFromDate:[datePickerView date] andFormatter:@"yyyy-MM-dd"];
}
#pragma mark - UIPickerViewDataSource Methods
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    NSInteger width=300;
    if (_type==PickerTypeMuColumn) {
            if (component == 0) {
                width= 90.0f;
            } else if (component == 1) {
                width= 210.0f;
            }        
    }
    return width;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_type==PickerTypeMuColumn) {
        return 2;
    }else{        
        return 1;
    }

}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count=0;
    if (_type==PickerTypeMuColumn) {
        if (component==0) {
            count=[_options[0] count];
        }else if(component==1){
            count=[_options[1] count];
        }        
    }else{
        count=[_options count];
    }
    return count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *content=@"";
    if (_type==PickerTypeMuColumn) {
        if (component==0) {
            content= [_options[0] objectAtIndex:row];
        }else if(component==1){
            content= [_options[1] objectAtIndex:row];
        }
    }else{
        content= [_options objectAtIndex:row];
    }
    
    return content;;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *value=@"";

    if([_options count]==0)
        return;
    if (_type==PickerTypeMuColumn) {
        }
    //其他单列的情况
    else{
        value=_options[row];
    }
    if (_resizeFrameDelegate && [_resizeFrameDelegate respondsToSelector:@selector(fillTextFieldValue:)]) {
        [_resizeFrameDelegate fillTextFieldValue:value];
    }
    self.doneValue=value;
}
//
- (void) showViewInView:(UIView *) view andTag:(NSInteger)tag
{
    if (_isHidden) {
        self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.tag=tag;
        [view addSubview:self];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
    }
    _isHidden=NO;
    }

//显示pickerview到当前的视图中
- (void) showViewInView:(UIView *) view
{
    if (_isHidden) {
        
        self.disableView = view;
        self.disableView.userInteractionEnabled = NO;
        
        UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
        
        //view.frame.size.height=460 初始化的时候self的纵坐标是460 然后从底部弹出
        self.frame = CGRectMake(0, keywindow.frame.size.height, self.frame.size.width, self.frame.size.height);

        [keywindow addSubview:self];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = CGRectMake(0, keywindow.frame.size.height - self.frame.size.height+18, self.frame.size.width, self.frame.size.height);
        }];
    }
 _isHidden=NO;
}

- (void) show
{
    if (_isHidden) {
        UIView *view = [[UIApplication sharedApplication] keyWindow];
        //view.frame.size.height=460 初始化的时候self的纵坐标是460 然后从底部弹出
        self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
        
        [view addSubview:self];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height+18, self.frame.size.width, self.frame.size.height);
        }];
    }
    _isHidden=NO;
}
- (void) showViewInSuperView:(UIView *) view
{
    if (_isHidden) {
        //view.frame.size.height=460 初始化的时候self的纵坐标是460 然后从底部弹出
        self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
        
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height+10, self.frame.size.width, self.frame.size.height);
        }];
    }
    _isHidden=NO;

}
//隐藏pickerview
- (void) hiddenView
{
    if (!_isHidden) {
        //掩藏 是将self的纵坐标从新变为460回到底部
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         }
                         completion:^(BOOL finished){
                            [self removeFromSuperview];
                             if (_resizeFrameDelegate && [_resizeFrameDelegate respondsToSelector:@selector(resizeViewFrame)]) {
                                 [_resizeFrameDelegate resizeViewFrame];
                             }

                             
                         }];

    }
    _isHidden=YES;

    if (self.disableView) {
        self.disableView.userInteractionEnabled = YES;
        self.disableView = nil;
    }
}
//完成后隐藏pickerview
- (void) done:(id) sender
{
//刷新cell
    
    if (!self.doneValue) {
        UIPickerView *pickerView = nil;

        switch (self.type) {
            case PickerTypeStandard:
            case PickerTypeMuColumn:{
                pickerView = (UIPickerView *)[self viewWithTag:PickerViewTag];
                
            }
                break;
            default:
                break;
        }
        if (pickerView) {
            [self pickerView:pickerView didSelectRow:[pickerView selectedRowInComponent:0] inComponent:0];
            
//            pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
            
        }
    }
    
    if (!_isScrollAndChoose) {
        if (_delegate && [_delegate respondsToSelector:@selector(returnDataAndRefeshCellWithSelectValue:)]) {
            [_delegate returnDataAndRefeshCellWithSelectValue:self.doneValue];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(pickerView:returnDataAndRefeshCellWithSelectValue:)]) {
            [_delegate pickerView:self returnDataAndRefeshCellWithSelectValue:self.doneValue];
        }
        if (_resizeFrameDelegate && [_resizeFrameDelegate respondsToSelector:@selector(fillTextFieldValue:)]) {
            [_resizeFrameDelegate fillTextFieldValue:self.doneValue];
        }
        //用block
        if (self.onSaveBlock) {
            self.onSaveBlock(self.doneValue);
        }
    }
        [self hiddenView];
}
//刷新pickerview
- (void)reloadPickerView
{
    [_picker reloadAllComponents];
    [self updateToolBarTitle];
 
}

@end
