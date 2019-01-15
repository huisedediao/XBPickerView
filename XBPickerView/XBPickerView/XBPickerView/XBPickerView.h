//
//  XBPickerView.h
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBAlertViewBase.h"
#import "XBButton.h"
#import "XBPickerViewHeader.h"

@class XBPickerView;

typedef void (^XBPickerViewDoneBlock)(XBPickerView *pickerView,NSArray *array);

@protocol XBPickerViewDelegate <NSObject>

- (void)pickerView:(XBPickerView *)pickerView doneClickWithStrArr:(NSArray *)array;

@end

@interface XBPickerView : XBAlertViewBase
@property (nonatomic,strong) XBButton *btn_cancel;
@property (nonatomic,strong) XBButton *btn_done;
//要显示的行数，默认5
@property (nonatomic,assign) NSInteger i_rowCount;
/**
 数据源，格式：
 _pickV_time.arr_datasource = @[@[@"1",@"2"],@[@"1",@"2"]];
 */
@property (nonatomic,strong) NSArray *arr_datasource;
@property (nonatomic,assign) XBPickerViewIndexset selectedIndexset;
@property (nonatomic,strong) UIPickerView *pv_choose;
@property (nonatomic,weak) id<XBPickerViewDelegate>delegate;
@property (nonatomic,copy) XBPickerViewDoneBlock bl_done;
@end
