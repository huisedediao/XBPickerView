//
//  XBPickerView.h
//  d11
//
//  Created by xxb on 2017/9/8.
//  Copyright © 2017年 DreamCatcher. All rights reserved.
//

#import "XBAlertViewBase.h"
#import "XBPickerViewHeader.h"

@class XBPickerView;

@protocol XBPickerViewDelegate <NSObject>

- (void)pickerView:(XBPickerView *)pickerView doneClickAtIndexset:(XBPickerViewIndexset)indexset;

@end

@interface XBPickerView : XBAlertViewBase
@property (nonatomic,strong) NSArray *arr_datasource;
@property (nonatomic,assign) XBPickerViewIndexset selectedIndexset;
@property (nonatomic,strong) UIPickerView *pv_choose;
@property (nonatomic,weak) id<UIPickerViewDelegate,UIPickerViewDataSource> pickerDelegate;
@property (nonatomic,weak) id<XBPickerViewDelegate>delegate;
@end
