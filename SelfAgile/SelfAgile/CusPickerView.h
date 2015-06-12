//
//  CusPickerView.h
//  Picker
//
//  Created by gshmac on 13-8-18.
//  Copyright (c) 2013年 gshmac. All rights reserved.
//

#define CusPickerViewTag 967800
#define PickerViewTag    967801
#define PickerDateTag    967802
#define CusPickerDateTag 967803
#define CusPickerViewMuColumnTag 967804
#import <UIKit/UIKit.h>
#import "DateHelper.h"

typedef NS_ENUM(NSUInteger, PickerType) {
    PickerTypeStandard=0,
    PickerTypeDate,
    PickerTypeMuColumn
};
@protocol PickerViewReloadCellDelegate;
@protocol ResizeFrameDelegate;
@interface CusPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *_picker;
    UIDatePicker *_datePicker;
    NSMutableArray *_options;
    UIToolbar *_tool;
    NSString  *_title;
    PickerType _type;
    
    //省份
    NSString *_province;
    BOOL     _isScrollAndChoose;
    
    
    
}
@property(nonatomic,retain) NSMutableArray *options;
@property(nonatomic,copy) NSString *province;
@property(nonatomic,copy) NSString *doneValue;
@property(nonatomic,assign) PickerType type;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *selectDate;
@property(assign)BOOL isHidden;
@property(nonatomic,assign)NSInteger fromSection;
@property(nonatomic,assign)NSInteger fromIndex;
@property(nonatomic,assign)id <PickerViewReloadCellDelegate> delegate;
@property(nonatomic,assign)id <ResizeFrameDelegate>    resizeFrameDelegate;
@property(nonatomic,assign) int theme;

@property(nonatomic,copy) void (^onSaveBlock)(id value);
@property(nonatomic,copy) void (^onCancelBlock)(void);

@property (nonatomic, strong) id info;

- (id) initWithFrame:(CGRect) frame andOptions:(NSMutableArray *) options andType:(PickerType) type andToolBarTitle:(NSString *)title;
- (void)reloadPickerView;
- (void) updateToolBarTitle;
- (void) showViewInView:(UIView *) view andTag:(NSInteger) tag;
- (void) showViewInView:(UIView *) view;
- (void) hiddenView;
- (void) showViewInSuperView:(UIView *) view;

- (void) show;

@end


@protocol PickerViewReloadCellDelegate <NSObject>
@optional
- (void) returnData:(NSString *) selectValue reloadCellWithSection:(NSInteger) section adnIndexPathRow:(NSInteger) row;
- (void) returnDataAndRefeshCellWithSelectValue:(NSString *)selectValue;
- (void) pickerView:(CusPickerView *)pickerView returnDataAndRefeshCellWithSelectValue:(NSString *)selectValue;
@end
@protocol ResizeFrameDelegate<NSObject>
@optional
- (void) resizeViewFrame;
- (void) fillTextFieldValue:(NSString *) selectValue;
- (void) cancelSelect;
@end
